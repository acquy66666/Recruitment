/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.recruitment.dao;

import com.recruitment.model.BlogPost;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.sql.Types;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class BlogPostDAO extends DBcontext {

    public List<BlogPost> getAllBlogPost() {
        List<BlogPost> list = new ArrayList<>();
        String sql = "SELECT * FROM blog_post";

        try {
            PreparedStatement ps = c.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                BlogPost post = new BlogPost(
                        rs.getInt("blog_id"),
                        rs.getInt("admin_id"),
                        rs.getString("title"),
                        rs.getString("thumbnail_url"),
                        rs.getString("summary"),
                        rs.getString("content_json"),
                        rs.getString("category"),
                        rs.getBoolean("is_published"),
                        rs.getTimestamp("published_at") != null ? rs.getTimestamp("published_at").toLocalDateTime() : null,
                        rs.getTimestamp("created_at") != null ? rs.getTimestamp("created_at").toLocalDateTime() : null,
                        rs.getTimestamp("updated_at") != null ? rs.getTimestamp("updated_at").toLocalDateTime() : null
                );

                list.add(post);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<BlogPost> getListBlogPost() {
        List<BlogPost> list = new ArrayList<>();
        String sql = "SELECT * FROM blog_post where is_published = 1";

        try {
            PreparedStatement ps = c.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                BlogPost post = new BlogPost(
                        rs.getInt("blog_id"),
                        rs.getInt("admin_id"),
                        rs.getString("title"),
                        rs.getString("thumbnail_url"),
                        rs.getString("summary"),
                        rs.getString("content_json"),
                        rs.getString("category"),
                        rs.getBoolean("is_published"),
                        rs.getTimestamp("published_at") != null ? rs.getTimestamp("published_at").toLocalDateTime() : null,
                        rs.getTimestamp("created_at") != null ? rs.getTimestamp("created_at").toLocalDateTime() : null,
                        rs.getTimestamp("updated_at") != null ? rs.getTimestamp("updated_at").toLocalDateTime() : null
                );

                list.add(post);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<BlogPost> getListBlogPostTop5() {
        List<BlogPost> list = new ArrayList<>();
        String sql = "SELECT TOP 6 * FROM blog_post WHERE is_published = 1 ORDER BY published_at DESC";

        try {
            PreparedStatement ps = c.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                BlogPost post = new BlogPost(
                        rs.getInt("blog_id"),
                        rs.getInt("admin_id"),
                        rs.getString("title"),
                        rs.getString("thumbnail_url"),
                        rs.getString("summary"),
                        rs.getString("content_json"),
                        rs.getString("category"),
                        rs.getBoolean("is_published"),
                        rs.getTimestamp("published_at") != null ? rs.getTimestamp("published_at").toLocalDateTime() : null,
                        rs.getTimestamp("created_at") != null ? rs.getTimestamp("created_at").toLocalDateTime() : null,
                        rs.getTimestamp("updated_at") != null ? rs.getTimestamp("updated_at").toLocalDateTime() : null
                );

                list.add(post);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<BlogPost> getBlogCountByCategory() {
        List<BlogPost> list = new ArrayList<>();

        String sql
                = "SELECT category, COUNT(*) AS number_blog "
                + "FROM   blog_post "
                + "WHERE  is_published = 1 "
                + "GROUP BY category";

        try (PreparedStatement ps = c.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                BlogPost stat = new BlogPost(
                        rs.getInt("number_blog"),
                        rs.getString("category")
                );
                list.add(stat);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<BlogPost> getListBlogPostByPage(List<BlogPost> list, int start, int end) {
        ArrayList<BlogPost> arr = new ArrayList<>();
        for (int i = start; i < end; i++) {
            arr.add(list.get(i));
        }
        return arr;
    }

    public List<BlogPost> filterBlogPostAdmin(String keyword, String category, String fromDateStr, String toDateStr, String sort) {
        List<BlogPost> list = new ArrayList<>();
        String sql = "SELECT * FROM blog_post WHERE 1=1";

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql += " AND title LIKE ?";
        }

        if (category != null && !category.trim().isEmpty()) {
            sql += " AND category = ?";
        }

        if (fromDateStr != null && !fromDateStr.trim().isEmpty()) {
            sql += " AND created_at >= ?";
        }

        if (toDateStr != null && !toDateStr.trim().isEmpty()) {
            sql += " AND created_at <= ?";
        }

        if (sort != null && !sort.trim().isEmpty()) {
            switch (sort) {
                case "createAt_desc_blog":
                    sql += " ORDER BY created_at DESC";
                    break;
                case "createAt_asc_blog":
                    sql += " ORDER BY created_at ASC";
                    break;
                case "title_asc_blog":
                    sql += " ORDER BY title ASC";
                    break;
                case "title_desc_blog":
                    sql += " ORDER BY title DESC";
                    break;
            }
        }

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            int index = 1;

            if (keyword != null && !keyword.trim().isEmpty()) {
                ps.setString(index++, "%" + keyword.trim() + "%");
            }

            if (category != null && !category.trim().isEmpty()) {
                ps.setString(index++, category.trim());
            }

            if (fromDateStr != null && !fromDateStr.trim().isEmpty()) {
                ps.setDate(index++, java.sql.Date.valueOf(fromDateStr));
            }

            if (toDateStr != null && !toDateStr.trim().isEmpty()) {
                ps.setDate(index++, java.sql.Date.valueOf(toDateStr));
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    BlogPost b = new BlogPost(
                            rs.getInt("blog_id"),
                            rs.getInt("admin_id"),
                            rs.getString("title"),
                            rs.getString("thumbnail_url"),
                            rs.getString("summary"),
                            rs.getString("content_json"),
                            rs.getString("category"),
                            rs.getBoolean("is_published"),
                            rs.getTimestamp("published_at") != null ? rs.getTimestamp("published_at").toLocalDateTime() : null,
                            rs.getTimestamp("created_at").toLocalDateTime(),
                            rs.getTimestamp("updated_at") != null ? rs.getTimestamp("updated_at").toLocalDateTime() : null
                    );
                    list.add(b);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<BlogPost> filterBlogPostUser(String keyword, String sort) {
        List<BlogPost> list = new ArrayList<>();

        // 1. Câu SQL gốc
        String sql = "SELECT * FROM blog_post WHERE is_published = 1";

        // 2. Điều kiện tìm theo title
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql += " AND title LIKE ?";
        }

        // 3. Sắp xếp theo dropdown
        if (sort != null && !sort.trim().isEmpty()) {
            switch (sort) {
                case "publishedAsc":
                    sql += " ORDER BY published_at ASC";
                    break;
                case "publishedDesc":
                    sql += " ORDER BY published_at DESC";
                    break;
                case "titleAsc":
                    sql += " ORDER BY title ASC";
                    break;
                case "titleDesc":
                    sql += " ORDER BY title DESC";
                    break;
                default:
                    sql += " ORDER BY published_at DESC";   // mặc định
            }
        }

        try (PreparedStatement ps = c.prepareStatement(sql)) {

            // 4. Gán tham số LIKE
            int index = 1;
            if (keyword != null && !keyword.trim().isEmpty()) {
                ps.setString(index++, "%" + keyword.trim() + "%");
            }

            // 5. Thực thi và map kết quả
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                BlogPost post = new BlogPost(
                        rs.getInt("blog_id"),
                        rs.getInt("admin_id"),
                        rs.getString("title"),
                        rs.getString("thumbnail_url"),
                        rs.getString("summary"),
                        rs.getString("content_json"),
                        rs.getString("category"),
                        rs.getBoolean("is_published"),
                        rs.getTimestamp("published_at") != null ? rs.getTimestamp("published_at").toLocalDateTime() : null,
                        rs.getTimestamp("created_at") != null ? rs.getTimestamp("created_at").toLocalDateTime() : null,
                        rs.getTimestamp("updated_at") != null ? rs.getTimestamp("updated_at").toLocalDateTime() : null
                );
                list.add(post);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<BlogPost> filterBlogPostUserByCategory(String categoryBlogPublish) {
        List<BlogPost> list = new ArrayList<>();

        // 1. Câu SQL gốc
        String sql = "SELECT * FROM blog_post WHERE is_published = 1 and category = ?";

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, categoryBlogPublish);
            // 5. Thực thi và map kết quả
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                BlogPost post = new BlogPost(
                        rs.getInt("blog_id"),
                        rs.getInt("admin_id"),
                        rs.getString("title"),
                        rs.getString("thumbnail_url"),
                        rs.getString("summary"),
                        rs.getString("content_json"),
                        rs.getString("category"),
                        rs.getBoolean("is_published"),
                        rs.getTimestamp("published_at") != null ? rs.getTimestamp("published_at").toLocalDateTime() : null,
                        rs.getTimestamp("created_at") != null ? rs.getTimestamp("created_at").toLocalDateTime() : null,
                        rs.getTimestamp("updated_at") != null ? rs.getTimestamp("updated_at").toLocalDateTime() : null
                );
                list.add(post);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public void updateIsActiveBlog(boolean isActive, String blogPostId) {
        String sql = "UPDATE [blog_post] SET is_published = ? WHERE blog_id = ?";
        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setBoolean(1, isActive);   // JDBC tự map boolean ↔ BIT (0/1)
            ps.setString(2, blogPostId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();          // hoặc log ra logger của bạn
        }
    }

    public BlogPost getBlogPostById(String id) {
        String sql = "SELECT * FROM blog_post WHERE blog_id = ?";

        try {
            PreparedStatement ps = c.prepareStatement(sql);
            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return new BlogPost(
                        rs.getInt("blog_id"),
                        rs.getInt("admin_id"),
                        rs.getString("title"),
                        rs.getString("thumbnail_url"),
                        rs.getString("summary"),
                        rs.getString("content_json"),
                        rs.getString("category"),
                        rs.getBoolean("is_published"),
                        rs.getTimestamp("published_at") != null ? rs.getTimestamp("published_at").toLocalDateTime() : null,
                        rs.getTimestamp("created_at") != null ? rs.getTimestamp("created_at").toLocalDateTime() : null,
                        rs.getTimestamp("updated_at") != null ? rs.getTimestamp("updated_at").toLocalDateTime() : null
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return null; // không tìm thấy
    }

//    public List<BlogPost> getListBlogPost() {
//        List<BlogPost> list = new ArrayList<>();
//        String sql = "SELECT * FROM blog_post";
//        try {
//            PreparedStatement ps = c.prepareStatement(sql);
//            ResultSet rs = ps.executeQuery();
//
//            while (rs.next()) {
//                BlogPost blogPost = new BlogPost(
//                        rs.getInt("blog_id"),
//                        rs.getInt("admin_id"),
//                        rs.getString("title"),
//                        rs.getString("thumbnail_url"),
//                        rs.getString("summary"),
//                        rs.getString("content_json"),
//                        rs.getString("category"),
//                        rs.getBoolean("is_published"),
//                        rs.getTimestamp("published_at") != null ? rs.getTimestamp("published_at").toLocalDateTime() : null,
//                        rs.getTimestamp("created_at") != null ? rs.getTimestamp("created_at").toLocalDateTime() : null,
//                        rs.getTimestamp("updated_at") != null ? rs.getTimestamp("updated_at").toLocalDateTime() : null
//                );
//                list.add(blogPost);
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//
//        return list; // không tìm thấy
//    }
    public boolean insertBlog(BlogPost blog) {
        String sql = "INSERT INTO blog_post "
                + "(admin_id, title, thumbnail_url, summary, content_json, category, is_published, published_at, created_at, updated_at) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setInt(1, blog.getAdminId());
            ps.setString(2, blog.getTitle());
            ps.setString(3, blog.getThumbnailUrl());
            ps.setString(4, blog.getSummary());
            ps.setString(5, blog.getContentJson());
            ps.setString(6, blog.getCategory());
            ps.setBoolean(7, blog.isIsPublished());

            // published_at
            if (blog.isIsPublished()) {
                ps.setTimestamp(8, new Timestamp(System.currentTimeMillis()));
            } else {
                ps.setNull(8, Types.TIMESTAMP);
            }

            // created_at
            ps.setTimestamp(9, new Timestamp(System.currentTimeMillis()));

            // updated_at = NULL khi insert mới
            ps.setNull(10, Types.TIMESTAMP);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateBlog(BlogPost blog) {
        String sql = "UPDATE blog_post SET "
                + "admin_id = ?, "
                + "title = ?, "
                + "thumbnail_url = ?, "
                + "summary = ?, "
                + "content_json = ?, "
                + "category = ?, "
                + "is_published = ?, "
                + "published_at = ?, "
                + "updated_at = ? "
                + "WHERE blog_id = ?";

        try (PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setInt(1, blog.getAdminId());
            ps.setString(2, blog.getTitle());
            ps.setString(3, blog.getThumbnailUrl());
            ps.setString(4, blog.getSummary());
            ps.setString(5, blog.getContentJson());
            ps.setString(6, blog.getCategory());
            ps.setBoolean(7, blog.isIsPublished());

            // published_at
            if (blog.isIsPublished()) {
                ps.setTimestamp(8, new Timestamp(System.currentTimeMillis()));
            } else {
                ps.setNull(8, Types.TIMESTAMP);
            }

            // updated_at
            ps.setTimestamp(9, new Timestamp(System.currentTimeMillis()));

            // WHERE blog_id
            ps.setInt(10, blog.getBlogId());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public void deleteBlog(int blogPostID) {
        String sql1 = "delete from blog_post where blog_id = ?";

        try {
            PreparedStatement ps1 = c.prepareStatement(sql1);
            ps1.setInt(1, blogPostID);
            ps1.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<BlogPost> getRelatedByCategory(String category, String currentBlogId) {
        List<BlogPost> list = new ArrayList<>();
        String sql = "SELECT TOP 5 * FROM blog_post WHERE is_published = 1 AND category = ? AND blog_id <> ? ORDER BY published_at DESC";
        try {
            PreparedStatement ps = c.prepareStatement(sql);
            ps.setString(1, category);
            ps.setString(2, currentBlogId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                BlogPost post = new BlogPost(
                        rs.getInt("blog_id"),
                        rs.getInt("admin_id"),
                        rs.getString("title"),
                        rs.getString("thumbnail_url"),
                        rs.getString("summary"),
                        rs.getString("content_json"),
                        rs.getString("category"),
                        rs.getBoolean("is_published"),
                        rs.getTimestamp("published_at") != null ? rs.getTimestamp("published_at").toLocalDateTime() : null,
                        rs.getTimestamp("created_at") != null ? rs.getTimestamp("created_at").toLocalDateTime() : null,
                        rs.getTimestamp("updated_at") != null ? rs.getTimestamp("updated_at").toLocalDateTime() : null
                );
                list.add(post);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
//        // 2. Nếu KHÔNG có bài cùng category → lấy 5 bài mới nhất bất kỳ (loại trừ bài hiện tại)
//        if (list.isEmpty()) {
//            String fallback = """
//                          SELECT TOP 5 *
//                          FROM   blog_post
//                          WHERE  is_published = 1
//                            AND  blog_id <> ?
//                          ORDER BY published_at DESC
//                          """;
//            try (PreparedStatement ps = c.prepareStatement(fallback)) {
//                ps.setString(1, currentBlogId);
//
//                try (ResultSet rs = ps.executeQuery()) {
//                    while (rs.next()) {
//                        list.add(mapRow(rs));
//                    }
//                }
//            } catch (Exception e) {
//                e.printStackTrace();
//            }
//        }

        return list; // không tìm thấy
    }

    public List<BlogPost> filterBlogPostUserNew(String keyword, String sort, String category) {
        List<BlogPost> list = new ArrayList<>();

        // 1. Câu SQL gốc
        String sql = "SELECT * FROM blog_post WHERE is_published = 1";

        // 2. Lọc theo category nếu có
        if (category != null && !category.trim().isEmpty()) {
            sql += " AND category = ?";
        }

        // 3. Lọc theo keyword nếu có (title LIKE ?)
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql += " AND title LIKE ?";
        }

        // 4. Sắp xếp theo sort
        if (sort != null && !sort.trim().isEmpty()) {
            switch (sort) {
                case "publishedAsc":
                    sql += " ORDER BY published_at ASC";
                    break;
                case "publishedDesc":
                    sql += " ORDER BY published_at DESC";
                    break;
                case "titleAsc":
                    sql += " ORDER BY title ASC";
                    break;
                case "titleDesc":
                    sql += " ORDER BY title DESC";
                    break;
                default:
                    sql += " ORDER BY published_at DESC"; // mặc định
            }
        } else {
            sql += " ORDER BY published_at DESC"; // mặc định nếu sort null
        }

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            // 5. Gán tham số đúng thứ tự
            int index = 1;
            if (category != null && !category.trim().isEmpty()) {
                ps.setString(index++, category.trim());
            }
            if (keyword != null && !keyword.trim().isEmpty()) {
                ps.setString(index++, "%" + keyword.trim() + "%");
            }

            // 6. Thực thi và map kết quả
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                BlogPost post = new BlogPost(
                        rs.getInt("blog_id"),
                        rs.getInt("admin_id"),
                        rs.getString("title"),
                        rs.getString("thumbnail_url"),
                        rs.getString("summary"),
                        rs.getString("content_json"),
                        rs.getString("category"),
                        rs.getBoolean("is_published"),
                        rs.getTimestamp("published_at") != null ? rs.getTimestamp("published_at").toLocalDateTime() : null,
                        rs.getTimestamp("created_at") != null ? rs.getTimestamp("created_at").toLocalDateTime() : null,
                        rs.getTimestamp("updated_at") != null ? rs.getTimestamp("updated_at").toLocalDateTime() : null
                );
                list.add(post);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    
    public List<BlogPost> getListBlogPostTop3() {
        List<BlogPost> list = new ArrayList<>();
        String sql = "SELECT TOP 3 * FROM blog_post WHERE is_published = 1 ORDER BY published_at DESC";

        try {
            PreparedStatement ps = c.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                BlogPost post = new BlogPost(
                        rs.getInt("blog_id"),
                        rs.getInt("admin_id"),
                        rs.getString("title"),
                        rs.getString("thumbnail_url"),
                        rs.getString("summary"),
                        rs.getString("content_json"),
                        rs.getString("category"),
                        rs.getBoolean("is_published"),
                        rs.getTimestamp("published_at") != null ? rs.getTimestamp("published_at").toLocalDateTime() : null,
                        rs.getTimestamp("created_at") != null ? rs.getTimestamp("created_at").toLocalDateTime() : null,
                        rs.getTimestamp("updated_at") != null ? rs.getTimestamp("updated_at").toLocalDateTime() : null
                );

                list.add(post);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public static void main(String[] args) {
        BlogPostDAO dao = new BlogPostDAO();
//        dao.deleteBlog(1);
//        var list = dao.filterBlogPostAdmin(null, "	Công nghệ thông tin", null, null, null);
        var list = dao.getRelatedByCategory("Bất động sản", "25");
        System.out.println(list.toString());
//        for (BlogPost blogPost : list) {
//            System.out.println(blogPost.toString());
//        }
//        var list = dao.filterBlogPostUserByCategory("Bất động sản");
//        for (BlogPost blogPost : list) {
//            System.out.println(blogPost.toString());
//        }
//        System.out.println(dao.getBlogPostById("1").toString());

//        BlogPost blog = new BlogPost(
//                1, // adminId
//                "Cách trở thành người giàu có số 1",
//                "Hướng dẫn chi tiết cách trở thành người giàu có số 1",
//                "Công nghệ thông tin",
//                """
//            {
//              "time": 1908900679235,
//              "blocks": [
//                {
//                  "type": "header",
//                  "data": {
//                    "text": "Giới thiệu",
//                    "level": 2
//                  }
//                },
//                {
//                  "type": "paragraph",
//                  "data": {
//                    "text": "CV là yếu tố quan trọng giúp bạn gây ấn tượng với nhà tuyển dụng."
//                  }
//                }
//              ],
//              "version": "2.25.0"
//            }
//            """,
//                "uploadsAdminBlog/blog_sssuper1.jpg", // giả sử có file mẫu
//                false // công khai → published_at sẽ được gán
//        );
//        BlogPost blog2 = new BlogPost(
//                1, // adminId
//                "Thử",
//                "Thử",
//                "Công nghệ thông tin",
//                "Thử",
//                "uploadsAdminBlog/blog_sssuper1.jpg", // giả sử có file mẫu
//                false // công khai → published_at sẽ được gán
//        );
//        boolean success = dao.insertBlog(blog2);
//        if (success) {
//            System.out.println("✅ Thêm blog thành công.");
//        } else {
//            System.out.println("❌ Thêm blog thất bại.");
//        }
    }
}
// Khi list rỗng, thử tìm 5 bài viết phù hợp từ khóa tìm kiếm (keyword)
//if (list.isEmpty()) {
//    String searchSql = """
//        SELECT TOP 5 *
//        FROM   blog_post
//        WHERE  is_published = 1
//          AND  blog_id <> ?                      -- bỏ bài hiện tại
//          AND (title     LIKE ?                 -- tìm trong tiêu đề
//               OR summary LIKE ?               -- hoặc trong tóm tắt
//               OR category LIKE ?)             -- hoặc trong chuyên mục
//        ORDER BY published_at DESC
//        """;
//
//    try (PreparedStatement ps = c.prepareStatement(searchSql)) {
//        ps.setString(1, currentBlogId);         // id bài hiện tại
//
//        // Thêm wildcard trước & sau keyword để LIKE hoạt động
//        String kw = "%" + keyword + "%";        // keyword = keySearchListBlog bạn truyền vào
//        ps.setString(2, kw);
//        ps.setString(3, kw);
//        ps.setString(4, kw);
//
//        try (ResultSet rs = ps.executeQuery()) {
//            while (rs.next()) {
//                list.add(mapRow(rs));
//            }
//        }
//    } catch (Exception e) {
//        e.printStackTrace();
//    }
//}

//public List<BlogPost> filterBlogPostUser(String keyword, String sort, String category) {
//    List<BlogPost> list = new ArrayList<>();
//
//    // 1. Câu SQL gốc
//    String sql = "SELECT * FROM blog_post WHERE is_published = 1";
//
//    // 2. Lọc theo category nếu có
//    if (category != null && !category.trim().isEmpty()) {
//        sql += " AND category = ?";
//    }
//
//    // 3. Lọc theo keyword nếu có (title LIKE ?)
//    if (keyword != null && !keyword.trim().isEmpty()) {
//        sql += " AND title LIKE ?";
//    }
//
//    // 4. Sắp xếp theo sort
//    if (sort != null && !sort.trim().isEmpty()) {
//        switch (sort) {
//            case "publishedAsc":
//                sql += " ORDER BY published_at ASC";
//                break;
//            case "publishedDesc":
//                sql += " ORDER BY published_at DESC";
//                break;
//            case "titleAsc":
//                sql += " ORDER BY title ASC";
//                break;
//            case "titleDesc":
//                sql += " ORDER BY title DESC";
//                break;
//            default:
//                sql += " ORDER BY published_at DESC"; // mặc định
//        }
//    } else {
//        sql += " ORDER BY published_at DESC"; // mặc định nếu sort null
//    }
//
//    try (PreparedStatement ps = c.prepareStatement(sql)) {
//        // 5. Gán tham số đúng thứ tự
//        int index = 1;
//        if (category != null && !category.trim().isEmpty()) {
//            ps.setString(index++, category.trim());
//        }
//        if (keyword != null && !keyword.trim().isEmpty()) {
//            ps.setString(index++, "%" + keyword.trim() + "%");
//        }
//
//        // 6. Thực thi và map kết quả
//        ResultSet rs = ps.executeQuery();
//        while (rs.next()) {
//            BlogPost post = new BlogPost(
//                    rs.getInt("blog_id"),
//                    rs.getInt("admin_id"),
//                    rs.getString("title"),
//                    rs.getString("thumbnail_url"),
//                    rs.getString("summary"),
//                    rs.getString("content_json"),
//                    rs.getString("category"),
//                    rs.getBoolean("is_published"),
//                    rs.getTimestamp("published_at") != null ? rs.getTimestamp("published_at").toLocalDateTime() : null,
//                    rs.getTimestamp("created_at") != null ? rs.getTimestamp("created_at").toLocalDateTime() : null,
//                    rs.getTimestamp("updated_at") != null ? rs.getTimestamp("updated_at").toLocalDateTime() : null
//            );
//            list.add(post);
//        }
//    } catch (Exception e) {
//        e.printStackTrace();
//    }
//
//    return list;
//}
