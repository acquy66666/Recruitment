/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.recruitment.dao;

import com.recruitment.model.Service;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author GBCenter
 */
public class ServiceViewDAO extends DBcontext {

    public class ServiceView {

        private int serviceID;
        private String type;
        private int count;
        private double total;
        private Service service;

        public ServiceView() {
        }

        public ServiceView(int serviceID, String type, int count, double total, Service service) {
            this.serviceID = serviceID;
            this.type = type;
            this.count = count;
            this.total = total;
            this.service = service;
        }

        public String getType() {
            return type;
        }

        public void setType(String type) {
            this.type = type;
        }

        public int getCount() {
            return count;
        }

        public void setCount(int count) {
            this.count = count;
        }

        public int getServiceID() {
            return serviceID;
        }

        public void setServiceID(int serviceID) {
            this.serviceID = serviceID;
        }

        public double getTotal() {
            return total;
        }

        public void setTotal(double total) {
            this.total = total;
        }

        public Service getService() {
            return service;
        }

        public void setService(Service service) {
            this.service = service;
        }

    }

    public List<ServiceView> getServiceView() throws SQLException {
        List<ServiceView> list = new ArrayList<>();
        ServiceDAO s = new ServiceDAO();
        String sql = """
                     SELECT td.service_id, s.service_type, COUNT(td.service_id) AS service_count, COUNT(td.service_id)* td.unit_price AS total_price
                     FROM transaction_detail td
                     JOIN [transaction] t ON t.transaction_id = td.transaction_id
                     JOIN service s ON s.service_id = td.service_id
                     GROUP BY td.service_id, td.unit_price, s.service_type""";
        try (PreparedStatement ps = c.prepareStatement(sql)) {
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ServiceView sv = new ServiceView(
                            rs.getInt("service_id"),
                            rs.getString("service_type"),
                            rs.getInt("service_count"),
                            rs.getDouble("total_price"),
                            s.getServiceById(rs.getInt("service_id")));
                    list.add(sv);
                }
            }
        }
        return list;
    }

    public List<ServiceView> getSortedServiceViews(
            String type,
            String sortBy,
            String sortOrder,
            int top,
            int pageIndex
    ) throws SQLException {
        List<ServiceView> list = new ArrayList<>();
        ServiceDAO s = new ServiceDAO();

        StringBuilder sql = new StringBuilder("""
        SELECT td.service_id,
               s.service_type,
               COUNT(td.service_id) AS service_count,
               SUM(td.service_id) * td.unit_price AS total_price
        FROM transaction_detail td
        JOIN [transaction] t ON t.transaction_id = td.transaction_id
        JOIN service s ON s.service_id = td.service_id
    """);

        boolean hasTypeFilter = type != null && !type.equalsIgnoreCase("all");
        if (hasTypeFilter) {
            sql.append(" WHERE s.service_type = ? ");
        }

        sql.append(" GROUP BY td.service_id, td.unit_price, s.service_type ");
        if (sortBy != null && sortOrder != null) {
            String field = switch (sortBy.toLowerCase()) {
                case "count" ->
                    "service_count";
                case "price" ->
                    "total_price";
                default ->
                    "td.service_id";
            };
            String direction = "asc".equalsIgnoreCase(sortOrder) ? "ASC" : "DESC";
            sql.append(" ORDER BY ").append(field).append(" ").append(direction);
        } else {
            sql.append(" ORDER BY td.service_id ASC"); // default fallback
        }
        sql.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        try (PreparedStatement ps = c.prepareStatement(sql.toString())) {
            int paramIndex = 1;
            if (hasTypeFilter) {
                ps.setString(paramIndex++, type);
            }
            ps.setInt(paramIndex++, (pageIndex - 1) * top);
            ps.setInt(paramIndex, top);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    int serviceId = rs.getInt("service_id");
                    String serviceType = rs.getString("service_type");
                    int count = rs.getInt("service_count");
                    double price = rs.getDouble("total_price");

                    Service service = s.getServiceById(serviceId);
                    list.add(new ServiceView(serviceId, serviceType, count, price, service));
                }
            }
        }
        return list;
    }

    public List<ServiceView> getFilteredServiceViews2(
            Integer minCount,
            Integer maxCount,
            Double minPrice,
            Double maxPrice,
            int top,
            int pageIndex
    ) throws SQLException {
        List<ServiceView> list = new ArrayList<>();
        ServiceDAO s = new ServiceDAO();

        StringBuilder sql = new StringBuilder("""
        WITH service_stats AS (
            SELECT td.service_id,
                   COUNT(td.service_id) AS service_count,
                   SUM(td.unit_price) AS total_price
            FROM transaction_detail td
            JOIN [transaction] t ON t.transaction_id = td.transaction_id
            GROUP BY td.service_id
        )
        SELECT * FROM service_stats WHERE 1=1
    """);

        // 🔍 Filtering
        if (minCount != null) {
            sql.append(" AND service_count >= ?");
        }
        if (maxCount != null) {
            sql.append(" AND service_count <= ?");
        }
        if (minPrice != null) {
            sql.append(" AND total_price >= ?");
        }
        if (maxPrice != null) {
            sql.append(" AND total_price <= ?");
        }

        // 📦 Pagination
        sql.append(" ORDER BY service_id OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        try (PreparedStatement ps = c.prepareStatement(sql.toString())) {
            int idx = 1;
            if (minCount != null) {
                ps.setInt(idx++, minCount);
            }
            if (maxCount != null) {
                ps.setInt(idx++, maxCount);
            }
            if (minPrice != null) {
                ps.setDouble(idx++, minPrice);
            }
            if (maxPrice != null) {
                ps.setDouble(idx++, maxPrice);
            }
            ps.setInt(idx++, (pageIndex - 1) * top); // OFFSET
            ps.setInt(idx, top);                    // FETCH NEXT

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    int serviceId = rs.getInt("service_id");
                    String serviceType = rs.getString("service_type");
                    int count = rs.getInt("service_count");
                    double price = rs.getDouble("total_price");
                    Service service = s.getServiceById(serviceId);
                    ServiceView sv = new ServiceView(serviceId, serviceType, count, price, service);
                    list.add(sv);
                }
            }
        }

        return list;
    }

    public int countAllServiceViews(String type) throws SQLException {
        String sql = """
        SELECT COUNT(DISTINCT td.service_id)
        FROM transaction_detail td
        JOIN [transaction] t ON td.transaction_id = t.transaction_id
        JOIN service s ON s.service_id = td.service_id
    """;

        boolean hasTypeFilter = type != null && !type.equalsIgnoreCase("all");
        if (hasTypeFilter) {
            sql += " WHERE s.service_type = ?";
        }

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            if (hasTypeFilter) {
                ps.setString(1, type);
            }
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? rs.getInt(1) : 0;
            }
        }
    }

    public List<ServiceView> getFilteredServiceViewsByRecruiter(
            int id,
            String type,
            String sortBy,
            String sortOrder,
            int top,
            int pageIndex
    ) throws SQLException {
        List<ServiceView> list = new ArrayList<>();
        ServiceDAO s = new ServiceDAO();

        StringBuilder sql = new StringBuilder("""
        SELECT td.service_id,
               s.service_type,
               COUNT(td.service_id) AS service_count,
               SUM(td.service_id) * td.unit_price AS total_price
        FROM transaction_detail td
        JOIN [transaction] t ON t.transaction_id = td.transaction_id
        JOIN service s ON s.service_id = td.service_id
    """);
        sql.append(" WHERE t.recruiter_id = ? ");
        boolean hasTypeFilter = type != null && !type.equalsIgnoreCase("all");
        if (hasTypeFilter) {
            sql.append(" AND s.service_type = ? ");
        }

        sql.append(" GROUP BY td.service_id, td.unit_price, s.service_type ");
        if (sortBy != null && sortOrder != null) {
            String field = switch (sortBy.toLowerCase()) {
                case "count" ->
                    "service_count";
                case "price" ->
                    "total_price";
                default ->
                    "td.service_id";
            };
            String direction = "asc".equalsIgnoreCase(sortOrder) ? "ASC" : "DESC";
            sql.append(" ORDER BY ").append(field).append(" ").append(direction);
        } else {
            sql.append(" ORDER BY td.service_id ASC"); // default fallback
        }
        sql.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        try (PreparedStatement ps = c.prepareStatement(sql.toString())) {
            int paramIndex = 1;
            ps.setInt(paramIndex++, id);
            if (hasTypeFilter) {
                ps.setString(paramIndex++, type);
            }
            ps.setInt(paramIndex++, (pageIndex - 1) * top);
            ps.setInt(paramIndex, top);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    int serviceId = rs.getInt("service_id");
                    String serviceType = rs.getString("service_type");
                    int count = rs.getInt("service_count");
                    double price = rs.getDouble("total_price");

                    Service service = s.getServiceById(serviceId);
                    list.add(new ServiceView(serviceId, serviceType, count, price, service));
                }
            }
        }
        return list;
    }

    public int countAllServiceViewsByRecruiter(int id, String type) throws SQLException {
        String sql = """
        SELECT COUNT(DISTINCT td.service_id)
        FROM transaction_detail td
        JOIN [transaction] t ON td.transaction_id = t.transaction_id
        JOIN service s ON s.service_id = td.service_id
    """;

        boolean hasTypeFilter = type != null && !type.equalsIgnoreCase("all");
        if (hasTypeFilter) {
            sql += " WHERE s.service_type = ? AND t.recruiter_id = ? ";
        }

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            if (hasTypeFilter) {
                ps.setString(1, type);
                ps.setInt(2, id);
            }
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? rs.getInt(1) : 0;
            }
        }
    }
}
