package com.recruitment.dao;

import com.recruitment.model.Service;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Data Access Object for managing Service entities in the database.
 */
public class ServiceDAO extends DBcontext {

    private static final int PAGE_SIZE = 8;

    // Create a new service with transaction
    public int insertService(Service service) throws SQLException {
        c.setAutoCommit(false);
        try {
            String sql = "INSERT INTO [dbo].[service] ([title], [credit], [service_type], [description], [isActive], [image_url], [price]) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?)";
            try (PreparedStatement ps = c.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
                ps.setString(1, service.getTitle());
                ps.setInt(2, service.getCredit());
                ps.setString(3, service.getServiceType());
                ps.setString(4, service.getDescription());
                ps.setBoolean(5, service.isIsActive());
                ps.setString(6, service.getImgUrl());
                ps.setDouble(7, service.getPrice());

                int affectedRows = ps.executeUpdate();
                if (affectedRows == 0) {
                    throw new SQLException("Inserting service failed, no rows affected.");
                }
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        int serviceId = rs.getInt(1);
                        c.commit();
                        return serviceId; // Return the generated service_id
                    }
                }
            }
        } catch (SQLException e) {
            c.rollback();
            throw e;
        } finally {
            c.setAutoCommit(true);
        }
        return -1; // If failed
    }

    // Update an existing service with transaction
    public void updateService(Service service) throws SQLException {
        c.setAutoCommit(false);
        try {
            String sql = "UPDATE [dbo].[service] SET [title] = ?, [credit] = ?, [service_type] = ?, "
                    + "[description] = ?, [isActive] = ?, [image_url] = ?, [price] = ? WHERE [service_id] = ?";
            try (PreparedStatement ps = c.prepareStatement(sql)) {
                ps.setString(1, service.getTitle());
                ps.setInt(2, service.getCredit());
                ps.setString(3, service.getServiceType());
                ps.setString(4, service.getDescription());
                ps.setBoolean(5, service.isIsActive());
                ps.setString(6, service.getImgUrl());
                ps.setDouble(7, service.getPrice());
                ps.setInt(8, service.getServiceId());

                int rowsAffected = ps.executeUpdate();
                if (rowsAffected == 0) {
                    throw new SQLException("No service found with ID: " + service.getServiceId());
                }
                c.commit();
            }
        } catch (SQLException e) {
            c.rollback();
            throw e;
        } finally {
            c.setAutoCommit(true);
        }
    }

    // Delete a service by ID
    public void deleteService(int serviceId) throws SQLException {
        String sql = "DELETE FROM [dbo].[service] WHERE [service_id] = ?";
        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, serviceId);
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected == 0) {
                throw new SQLException("No service found with ID: " + serviceId);
            }
        }
    }

    // Get a service by ID
    public Service getServiceById(int serviceId) throws SQLException {
        String sql = "SELECT * FROM [dbo].[service] WHERE [service_id] = ?";
        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, serviceId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToService(rs);
                }
            }
        }
        return null;
    }

    // Get all service types
    public List<String> getAllServiceTypes() throws SQLException {
        String sql = "SELECT DISTINCT [service_type] FROM [dbo].[service] WHERE [service_type] IS NOT NULL  AND [isActive] = 1";
        List<String> typeList = new ArrayList<>();
        try (PreparedStatement ps = c.prepareStatement(sql)) {
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    typeList.add(rs.getString("service_type"));
                }
            }
        }
        return typeList;
    }

    // Get filtered and sorted services with pagination
    public List<Service> getFilteredServices(String search, String type, String status, String sortBy, int page) throws SQLException {
        List<Service> services = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM [dbo].[service] WHERE 1=1");
        List<Object> params = new ArrayList<>();

        // Search by title
        if (search != null && !search.trim().isEmpty()) {
            search = search.replaceAll("\\s+", " ");
            sql.append(" AND [title] LIKE ?");
            params.add("%" + search.trim() + "%");
            sql.append(" OR [description] LIKE ?");
            params.add("%" + search.trim() + "%");
        }

        // Filter by type
        if (type != null && !type.isEmpty()) {
            sql.append(" AND [service_type] = ?");
            params.add(type);
        }

        // Filter by status
        if (status != null && !status.isEmpty()) {
            sql.append(" AND [isActive] = ?");
            params.add("active".equals(status) ? 1 : 0);
        }

        // Sorting
        switch (sortBy != null ? sortBy : "service_id_desc") {
            case "credit_asc":
                sql.append(" ORDER BY [credit] ASC");
                break;
            case "credit_desc":
                sql.append(" ORDER BY [credit] DESC");
                break;
            case "price_asc":
                sql.append(" ORDER BY [price] ASC");
                break;
            case "price_desc":
                sql.append(" ORDER BY [price] DESC");
                break;
            default:
                sql.append(" ORDER BY [service_id] DESC");
        }

        // Pagination
        sql.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        params.add((page - 1) * PAGE_SIZE);
        params.add(PAGE_SIZE);

        try (PreparedStatement ps = c.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    services.add(mapResultSetToService(rs));
                }
            }
        }
        return services;
    }

    // Get total number of pages for filtered services
    public int getTotalPages(String search, String type, String status) throws SQLException {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM [dbo].[service] WHERE 1=1");
        List<Object> params = new ArrayList<>();

        if (search != null && !search.trim().isEmpty()) {
            sql.append(" AND [title] LIKE ?");
            params.add("%" + search.trim() + "%");
        }

        if (type != null && !type.isEmpty()) {
            sql.append(" AND [service_type] = ?");
            params.add(type);
        }

        if (status != null && !status.isEmpty()) {
            sql.append(" AND [isActive] = ?");
            params.add("active".equals(status) ? 1 : 0);
        }

        try (PreparedStatement ps = c.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    int totalRecords = rs.getInt(1);
                    return (int) Math.ceil((double) totalRecords / PAGE_SIZE);
                }
            }
        }
        return 0;
    }

    // Activate or deactivate a service
    public void setServiceActive(int serviceId, boolean isActive) throws SQLException {
        String sql = "UPDATE [dbo].[service] SET [isActive] = ? WHERE [service_id] = ?";
        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setBoolean(1, isActive);
            ps.setInt(2, serviceId);
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected == 0) {
                throw new SQLException("No service found with ID: " + serviceId);
            }
        }
    }

    // Helper method to map ResultSet to Service object
    private Service mapResultSetToService(ResultSet rs) throws SQLException {
        Service service = new Service();
        service.setServiceId(rs.getInt("service_id"));
        service.setTitle(rs.getString("title"));
        service.setCredit(rs.getInt("credit"));
        service.setServiceType(rs.getString("service_type"));
        service.setDescription(rs.getString("description"));
        service.setIsActive(rs.getBoolean("isActive"));
        service.setImgUrl(rs.getString("image_url"));
        service.setPrice(rs.getDouble("price"));
        return service;
    }

    // Get a service by ID
    public List<Service> getAllServiceAdmin() {
        List<Service> services = new ArrayList<>();
        String sql = "SELECT * FROM [dbo].[service]";
        try (PreparedStatement ps = c.prepareStatement(sql)) {
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Service service = new Service();
                    service.setServiceId(rs.getInt("service_id"));
                    service.setTitle(rs.getString("title"));
                    service.setCredit(rs.getInt("credit"));
                    service.setServiceType(rs.getString("service_type"));
                    service.setDescription(rs.getString("description"));
                    service.setIsActive(rs.getBoolean("isActive"));
                    service.setImgUrl(rs.getString("image_url"));
                    service.setPrice(rs.getDouble("price"));
                    services.add(service);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return services;
    }

    public List<Service> getListServiceByPage(List<Service> list, int start, int end) {
        ArrayList<Service> arr = new ArrayList<>();
        for (int i = start; i < end; i++) {
            arr.add(list.get(i));
        }
        return arr;
    }

    // Get a service by ID
    public List<String> getAllTypeService() {
        List<String> list = new ArrayList<>();
        String sql = "SELECT DISTINCT service_type FROM [dbo].[service]";
        try {
            PreparedStatement ps = c.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(rs.getString("service_type")); // ✅ Lấy trực tiếp chuỗi
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Service> filterServicesAdmin(String keyword, String type, Double fromPrice, Double toPrice, String sort) {
        List<Service> list = new ArrayList<>();
        String sql = "SELECT * FROM service WHERE 1=1";

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql += " AND title LIKE ?";
        }

        if (type != null && !type.trim().isEmpty()) {
            sql += " AND service_type = ?";
        }

        if (fromPrice != null) {
            sql += " AND price >= ?";
        }

        if (toPrice != null) {
            sql += " AND price <= ?";
        }

        if (sort != null && !sort.trim().isEmpty()) {
            switch (sort) {
                case "credit_desc_service":
                    sql += " ORDER BY credit DESC";
                    break;
                case "credit_asc_service":
                    sql += " ORDER BY credit ASC";
                    break;
                case "title_asc_service":
                    sql += " ORDER BY title ASC";
                    break;
                case "title_desc_service":
                    sql += " ORDER BY title DESC";
                    break;
            }
        }

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            int index = 1;

            if (keyword != null && !keyword.trim().isEmpty()) {
                ps.setString(index++, "%" + keyword.trim() + "%");
            }

            if (type != null && !type.trim().isEmpty()) {
                ps.setString(index++, type.trim());
            }

            if (fromPrice != null) {
                ps.setDouble(index++, fromPrice);
            }

            if (toPrice != null) {
                ps.setDouble(index++, toPrice);
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Service s = new Service();
                    s.setServiceId(rs.getInt("service_id"));
                    s.setTitle(rs.getString("title"));
                    s.setCredit(rs.getInt("credit"));
                    s.setPrice(rs.getDouble("price"));
                    s.setServiceType(rs.getString("service_type"));
                    s.setDescription(rs.getString("description"));
                    s.setIsActive(rs.getBoolean("isActive"));
                    s.setImgUrl(rs.getString("image_url"));
                    list.add(s);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public void updateIsActiveService(boolean isActive, String serviceId) {
        String sql = "UPDATE service SET isActive = ? WHERE service_id = ?";
        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setBoolean(1, isActive);   // JDBC tự map boolean ↔ BIT (0/1)
            ps.setString(2, serviceId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();          // hoặc log ra logger của bạn
        }
    }

    public boolean updateServiceNew(Service service) throws SQLException {
        boolean success = false;
        c.setAutoCommit(false);

        String sql = "UPDATE [dbo].[service] SET [title] = ?, [credit] = ?, [service_type] = ?, "
                + "[description] = ?, [isActive] = ?, [image_url] = ?, [price] = ? "
                + "WHERE [service_id] = ?";

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, service.getTitle());
            ps.setInt(2, service.getCredit());
            ps.setString(3, service.getServiceType());
            ps.setString(4, service.getDescription());
            ps.setBoolean(5, service.isIsActive());
            ps.setString(6, service.getImgUrl());
            ps.setDouble(7, service.getPrice());
            ps.setInt(8, service.getServiceId());

            int rows = ps.executeUpdate();

            if (rows > 0) {          // có dòng bị ảnh hưởng
                c.commit();
                success = true;
            } else {                 // không tìm thấy service_id
                c.rollback();
            }
        } catch (SQLException e) {
            c.rollback();            // lỗi => rollback
            throw e;                 // ném tiếp cho caller
        } finally {
            c.setAutoCommit(true);   // trả lại chế độ tự commit
        }

        return success;
    }

    public boolean insertServiceNew(Service service) {
        String sql = "INSERT INTO [service] "
                + "([title], [credit], [price], [service_type], "
                + "[description], [isActive], [image_url]) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try {
            PreparedStatement ps = c.prepareStatement(sql);
            ps.setString(1, service.getTitle());
            ps.setInt(2, service.getCredit());
            ps.setDouble(3, service.getPrice());
            ps.setString(4, service.getServiceType());
            ps.setString(5, service.getDescription());
            ps.setBoolean(6, service.isIsActive());
            ps.setString(7, service.getImgUrl());

            int rows = ps.executeUpdate();
            return rows > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public void deleteServiceNew(int serviceId) {
        String sql1 = "DELETE FROM [transaction_detail] WHERE [service_id] = ?";
        String sql2 = "DELETE FROM [service] WHERE [service_id] = ?";

        try {
            PreparedStatement ps1 = c.prepareStatement(sql1);
            ps1.setInt(1, serviceId);
            ps1.executeUpdate();

            PreparedStatement ps2 = c.prepareStatement(sql2);
            ps2.setInt(1, serviceId);
            ps2.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Lấy tất cả gói dịch vụ
//    public List<Service> getAllService() {
//        List<Service> list = new ArrayList<>();
//        String sql = "SELECT * FROM service";   // hoặc [dbo].[service] nếu bạn thích
//
//        try {
//            PreparedStatement ps = c.prepareStatement(sql);
//            ResultSet rs = ps.executeQuery();
//
//            while (rs.next()) {
//                // Nếu Service đã có constructor đầy đủ 8 tham số
//                Service s = new Service(
//                        rs.getInt("service_id"),
//                        rs.getString("title"),
//                        rs.getInt("credit"),
//                        rs.getDouble("price"),
//                        rs.getString("service_type"),
//                        rs.getString("description"),
//                        rs.getBoolean("isActive"),
//                        rs.getString("image_url")
//                );
//                list.add(s);
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        return list;
//    }
    public boolean isTitleAndTypeDuplicate(String title, String type) {
        String sql = "SELECT COUNT(*) FROM service WHERE title = ? AND service_type = ?";
        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, title);
            ps.setString(2, type);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public static void main(String[] args) {
        ServiceDAO service = new ServiceDAO();
//        List<Service> a = service.filterServicesAdmin(null, null, null, null, "credit_desc_service");
//        for (Service service1 : a) {
//            System.out.println(service1.toString());
//        }
        Service s = new Service();
        s.setServiceId(1);                              // ID cần update (bảo đảm tồn tại)
        s.setTitle("Online Test – Java UPDATED");
        s.setCredit(30);
        s.setPrice(39.90);
        s.setServiceType("Bài online test");
        s.setDescription("Bộ câu hỏi Java Junior, sửa lần 2.");
        s.setIsActive(true);
        s.setImgUrl("assets/images/service/test_update.png"); // nếu muốn giữ ảnh cũ thì set null
        // 3. Gọi DAO → update
        try {
            boolean ok = service.updateServiceNew(s);
            System.out.println(ok ? "✔ Update thành công" : "✘ Không tìm thấy service_id");
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }
}
