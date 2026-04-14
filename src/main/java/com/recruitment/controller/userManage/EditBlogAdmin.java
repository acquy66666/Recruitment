/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.recruitment.controller.userManage;

import com.recruitment.dao.BlogPostDAO;
import com.recruitment.model.Admin;
import com.recruitment.model.BlogPost;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

@MultipartConfig( // cho phép upload file
        fileSizeThreshold = 1024 * 1024, // 1 MB
        maxFileSize = 10 * 1024 * 1024, // 10 MB
        maxRequestSize = 20 * 1024 * 1024 // 20 MB
)
@WebServlet(name = "EditBlogAdmin", urlPatterns = {"/EditBlogAdmin"})
public class EditBlogAdmin extends HttpServlet {

    private BlogPostDAO dao = new BlogPostDAO();
    private static final String UPLOAD_DIR = "uploadsAdminBlog";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet EditBlogAdmin</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditBlogAdmin at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
        if ((Admin) session.getAttribute("Admin") == null) {
            response.sendRedirect("login");
            return;
        }
        String actionBlog = request.getParameter("actionBlog");
        if (actionBlog != null && actionBlog.equals("create")) {
//                List<String> typeServiceList = service.getAllTypeService();
//                session.setAttribute("typeServiceList", typeServiceList);
            session.setAttribute("actionBlog", actionBlog);
            session.removeAttribute("blogInfo");
            response.sendRedirect("adminEditBlogPost.jsp");
            return;
        }
        String blogPostId = request.getParameter("blogPostId");
        BlogPost blogInfo = dao.getBlogPostById(blogPostId);
//            List<String> typeServiceList = service.getAllTypeService();
//            session.setAttribute("typeServiceList", typeServiceList);
        session.setAttribute("blogInfo", blogInfo);
        session.setAttribute("actionBlog", "edit");
        response.sendRedirect("adminEditBlogPost.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        PrintWriter out = response.getWriter();
        if ((Admin) session.getAttribute("Admin") == null) {
            response.sendRedirect("login");
            return;
        }
        Admin admin = (Admin) session.getAttribute("Admin");
        // 2. Validate
        try {
            // 1. Lấy dữ liệu từ form
            String actionBlog = request.getParameter("actionBlog");
            // Lấy dữ liệu từ form
            String blogIdStr = request.getParameter("blogId");
            String titleBlog = request.getParameter("titleBlog");
            String summaryBlog = request.getParameter("summaryBlog");
            String categoryBlog = request.getParameter("categoryBlog");
            String isPublishedStr = request.getParameter("isPublished");
            String contentJson = request.getParameter("contentJson");
            String oldImageBlogUrl = request.getParameter("oldImageBlogUrl");
            Part imagePartBlog = request.getPart("imageFileBlog");

            // 2. Validate
            List<String> errors = validateBlog(titleBlog, summaryBlog, categoryBlog, contentJson, imagePartBlog);
            if (!errors.isEmpty()) {
                session.setAttribute("blogErrors", errors);

                // Gán lại dữ liệu nhập để hiển thị lại form
                BlogPost blog = new BlogPost(
                        blogIdStr != null && !blogIdStr.isEmpty() ? Integer.parseInt(blogIdStr) : 0,
                        admin.getId(),
                        titleBlog, summaryBlog, categoryBlog, contentJson, oldImageBlogUrl,
                        "1".equals(isPublishedStr)
                );
                request.setAttribute("blogInfo", blog);
                request.setAttribute("actionBlog", actionBlog);
                request.getRequestDispatcher("adminEditBlogPost.jsp").forward(request, response);
                return;
            }

            // 3. Parse dữ liệu
            int blogId = blogIdStr != null && !blogIdStr.isEmpty() ? Integer.parseInt(blogIdStr) : 0;
            boolean isPublished = "1".equals(isPublishedStr);

            // 4. Xử lý ảnh
            String relativePath = null;
            if (imagePartBlog != null && imagePartBlog.getSize() > 0) {
                String fileName = Paths.get(imagePartBlog.getSubmittedFileName()).getFileName().toString();
                String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;

                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                String newFileName = "blog_" + blogId + "_" + System.currentTimeMillis() + "_" + fileName;
                String filePath = uploadPath + File.separator + newFileName;
                imagePartBlog.write(filePath);

                relativePath = UPLOAD_DIR + "/" + newFileName;
            }

            if (relativePath == null || relativePath.isBlank()) {
                relativePath = oldImageBlogUrl;
            }

            boolean success;

            if ("create".equals(actionBlog)) {
                // 5. Tạo đối tượng blog và gọi DAO
                BlogPost blog = new BlogPost(admin.getId(), titleBlog, summaryBlog, categoryBlog, contentJson, relativePath, isPublished);
                success = dao.insertBlog(blog);
                session.setAttribute("messageBlogUpdate", success ? "Thêm blog thành công!" : "Thêm blog thất bại!");
            } else if ("edit".equals(actionBlog)) {
                // 5. Tạo đối tượng blog và gọi DAO
                BlogPost blog = new BlogPost(blogId, admin.getId(), titleBlog, summaryBlog, categoryBlog, contentJson, relativePath, isPublished);
                success = dao.updateBlog(blog);
                session.setAttribute("messageBlogUpdate", success ? "Cập nhật blog thành công!" : "Cập nhật blog thất bại!");
                BlogPost blogInfo = dao.getBlogPostById(blogIdStr);
                session.setAttribute("blogInfo", blogInfo);
                response.sendRedirect("adminEditBlogPost.jsp");
                return;
            } else {
                session.setAttribute("messageBlogUpdate", "Hành động không hợp lệ!");
            }

            response.sendRedirect("ManageBlogPostAdmin");

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("messageBlogUpdate", "Đã xảy ra lỗi: " + e.getMessage());
            response.sendRedirect("ManageBlogPostAdmin");
        }
//        out.println(contentJson);
    }

    private List<String> validateBlog(String title, String summary, String category, String contentJson, Part imageFile) {
        List<String> errors = new ArrayList<>();

        if (title == null || title.trim().isEmpty()) {
            errors.add("Tiêu đề blog là bắt buộc.");
        }
        if (summary == null || summary.trim().isEmpty()) {
            errors.add("Mô tả ngắn là bắt buộc.");
        }
        if (category == null || category.trim().isEmpty()) {
            errors.add("Lĩnh vực là bắt buộc.");
        }
        if (contentJson == null || contentJson.trim().isEmpty()) {
            errors.add("Nội dung blog không được để trống.");
        }
        if (imageFile != null && imageFile.getSize() > 0) {
            String contentType = imageFile.getContentType();
            String fileName = imageFile.getSubmittedFileName().toLowerCase();
            if (contentType == null || !contentType.startsWith("image/")
                    || !(fileName.endsWith(".jpg") || fileName.endsWith(".jpeg")
                    || fileName.endsWith(".png") || fileName.endsWith(".gif"))) {
                errors.add("Ảnh không hợp lệ. Chỉ chấp nhận JPG, PNG, JPEG, GIF.");
            }
        }

        return errors;
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
//lấy thông tin từ header mà trình duyệt tự thêm vào khi submit file.
//getSubmittedFileName() ⇢ tên file gốc (có thể kèm C:\fakepath\), bạn cắt lấy phần cuối thành cat.png.

//Paths.get(...).getFileName().toString()
//Dùng API java.nio.file.Paths để tách lấy phần tên cuối cùng sau dấu \ hoặc /, bất kể hệ điều hành.


//getServletContext().getRealPath(""): trả về đường dẫn thư mục gốc của web‑app
//trên server (ví dụ: C:\Tomcat\webapps\MyApp\ hoặc /opt/tomcat/webapps/MyApp/).




//write(String filePath)	Ghi thẳng file xuống đĩa ở đường dẫn chỉ định.
//getSubmittedFileName()	Tên file gốc người dùng chọn (cat.png).
//getContentType()	MIME type do trình duyệt khai báo (image/png).
//getSize()	Kích thước tính bằng byte.





//// Giả sử admin đã đăng nhập
//int adminId = admin.getId();
//
//// ---------- Dữ liệu mẫu ----------
//String sampleTitle       = "Hướng dẫn viết blog trên JobHub";
//String sampleSummary     = "Đây là bài viết mẫu, bạn có thể chỉnh sửa nội dung, chèn ảnh, đổi tiêu đề…";
//String sampleCategory    = "Hướng dẫn";
//String sampleThumbnail   = "https://jobhub-cdn.s3.ap-southeast-1.amazonaws.com/default-thumbnail.png";
//
//// Một content JSON rất gọn để EditorJS đọc được
//String sampleContentJson =
//    """
//    {
//      "time": %d,
//      "blocks": [
//        {
//          "type": "header",
//          "data": { "text": "Xin chào!", "level": 2 }
//        },
//        {
//          "type": "paragraph",
//          "data": {
//            "text": "Đây là <b>bài viết mẫu</b>. Bạn hãy bấm vào để sửa, thêm tiêu đề phụ, danh sách, hình ảnh…"
//          }
//        },
//        {
//          "type": "list",
//          "data": {
//            "style": "unordered",
//            "items": [
//              "Thay đổi tiêu đề",
//              "Chỉnh sửa mô tả ngắn",
//              "Chèn ảnh JPG/PNG &lt; 1 MB",
//              "Nhấn Xuất bản khi hoàn tất"
//            ]
//          }
//        }
//      ],
//      "version": "2.29.0"
//    }
//    """.formatted(System.currentTimeMillis());
//
//// ---------- Tạo bài BlogPost mẫu ----------
//BlogPost sampleBlog = new BlogPost(
//    adminId,
//    sampleTitle,
//    sampleSummary,
//    sampleCategory,
//    sampleContentJson,
//    sampleThumbnail,
//    false          // chưa xuất bản
//);
//
//// Bạn có thể đặt thời gian tạo/cập nhật luôn nếu entity có setter
//sampleBlog.setCreatedAt(LocalDateTime.now());
//sampleBlog.setUpdatedAt(LocalDateTime.now());
//
//// Ghi vào DB
//blogPostDAO.insert(sampleBlog);
//
//// Sau khi insert, chuyển thẳng tới trang chỉnh sửa
//response.sendRedirect("adminEditBlogPost.jsp?blogId=" + sampleBlog.getBlogId());






































//public class BlogPostService {
//
//    private final BlogPostDAO blogPostDAO;
//
//    public BlogPostService(BlogPostDAO blogPostDAO) {
//        this.blogPostDAO = blogPostDAO;
//    }
//
//    /**
//     * Tạo một bài blog mẫu cho admin và lưu vào DB.
//     *
//     * @param adminId ID của admin hiện tại
//     * @return BlogPost vừa lưu (đã có blogId)
//     * @throws SQLException nếu có lỗi DB
//     */
//    public BlogPost createSampleBlog(int adminId) throws SQLException {
//
//        // ---------- Dữ liệu mẫu ----------
//        final String sampleTitle     = "Hướng dẫn viết blog trên JobHub";
//        final String sampleSummary   = "Đây là bài viết mẫu, bạn có thể chỉnh sửa nội dung, chèn ảnh, đổi tiêu đề…";
//        final String sampleCategory  = "Hướng dẫn";
//        final String sampleThumbnail = "https://jobhub-cdn.s3.ap-southeast-1.amazonaws.com/default-thumbnail.png";
//
//        // JSON EditorJS gọn nhẹ
//        String sampleContentJson = """
//            {
//              "time": %d,
//              "blocks": [
//                { "type": "header", "data": { "text": "Xin chào!", "level": 2 } },
//                { "type": "paragraph", "data": {
//                    "text": "Đây là <b>bài viết mẫu</b>. Bạn hãy bấm vào để sửa, thêm tiêu đề phụ, danh sách, hình ảnh…"
//                  }
//                },
//                { "type": "list", "data": {
//                    "style": "unordered",
//                    "items": [
//                      "Thay đổi tiêu đề",
//                      "Chỉnh sửa mô tả ngắn",
//                      "Chèn ảnh JPG/PNG < 1 MB",
//                      "Nhấn Xuất bản khi hoàn tất"
//                    ]
//                  }
//                }
//              ],
//              "version": "2.29.0"
//            }
//            """.formatted(System.currentTimeMillis());
//
//        // ---------- Khởi tạo đối tượng ----------
//        BlogPost sampleBlog = new BlogPost(
//                adminId,
//                sampleTitle,
//                sampleSummary,
//                sampleCategory,
//                sampleContentJson,
//                sampleThumbnail,
//                false      // chưa xuất bản
//        );
//
//        sampleBlog.setCreatedAt(LocalDateTime.now());
//        sampleBlog.setUpdatedAt(LocalDateTime.now());
//
//        // ---------- Lưu DB ----------
//        blogPostDAO.insert(sampleBlog);
//
//        // Trả về object để controller quyết định redirect hay gì tiếp
//        return sampleBlog;
//    }
//}
