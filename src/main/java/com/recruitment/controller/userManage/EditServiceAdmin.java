/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.recruitment.controller.userManage;

import com.recruitment.dao.ServiceDAO;
import com.recruitment.model.Service;
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
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@MultipartConfig( // cho phép upload file
        fileSizeThreshold = 1024 * 1024, // 1 MB
        maxFileSize = 10 * 1024 * 1024, // 10 MB
        maxRequestSize = 20 * 1024 * 1024 // 20 MB
)
@WebServlet(name = "EditServiceAdmin", urlPatterns = {"/EditServiceAdmin"})
public class EditServiceAdmin extends HttpServlet {

    private ServiceDAO service = new ServiceDAO();
    private static final String UPLOAD_DIR = "uploadsAdminService";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet EditServiceAdmin</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditServiceAdmin at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            response.setContentType("text/html;charset=UTF-8");
            PrintWriter out = response.getWriter();
            HttpSession session = request.getSession();
            String actionService = request.getParameter("actionService");
            if (actionService != null && actionService.equals("create")) {

                session.setAttribute("actionService", actionService);
                session.removeAttribute("serviceInfo");
                response.sendRedirect("adminEditService.jsp");
                return;
            }
            String serviceId = request.getParameter("serviceId");
            int serviceID = Integer.parseInt(serviceId);
            Service serviceInfo = service.getServiceById(serviceID);

            session.setAttribute("serviceInfo", serviceInfo);
            session.setAttribute("actionService", "edit");
            response.sendRedirect("adminEditService.jsp");
        } catch (SQLException ex) {
            Logger.getLogger(EditServiceAdmin.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            response.setContentType("text/html;charset=UTF-8");
            HttpSession session = request.getSession();
            // 1. Lấy dữ liệu từ form
            String actionService = request.getParameter("actionService");

            String idStr = request.getParameter("serviceId");
            String title = request.getParameter("titleService");
            String creditStr = request.getParameter("creditService");
            String priceStr = request.getParameter("priceService");
            String type = request.getParameter("serviceType");
            String description = request.getParameter("descriptionService");
            String isActiveStr = request.getParameter("isActive");
            String oldImageUrl = request.getParameter("oldImageUrl"); // <-- Thêm
            Part filePart = request.getPart("imageFileService");

            //Validate
            // 2. Validate
            List<String> errors = validateService(title, creditStr, priceStr, type, description, filePart);
            if (!errors.isEmpty()) {
                double price = Double.parseDouble(priceStr);
                session.setAttribute("serviceErrors", errors);
                request.setAttribute("serviceId", idStr);
                request.setAttribute("titleService", title);
                request.setAttribute("creditService", creditStr);
                request.setAttribute("priceService", formatSalary(price));
                request.setAttribute("serviceType", type);
                request.setAttribute("descriptionService", description);
                request.setAttribute("checkedStatus", isActiveStr);
                request.setAttribute("oldImageUrl", oldImageUrl);
                request.setAttribute("actionService", actionService);
//                request.setAttribute("imageFileService", filePart);

                request.getRequestDispatcher("adminEditService.jsp").forward(request, response);
                return;
            }
            // 2. Parse dữ liệu
            int serviceId = 0; // khai báo sẵn

            if ("edit".equals(actionService)) {
                if (idStr != null && !idStr.isEmpty()) {
                    serviceId = Integer.parseInt(idStr);
                }
            }
            int credit = Integer.parseInt(creditStr);
            Double price = (priceStr == null || priceStr.isBlank()) ? null : Double.parseDouble(priceStr);
            boolean isActive = "1".equals(isActiveStr);

            // 2. Xử lý file ảnh
//            Part filePart = request.getPart("imageFileService");
            String relativePath = null;

            if (filePart != null && filePart.getSize() > 0) {
                // Kiểm tra định dạng ảnh (tuỳ bạn muốn thêm)
                String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;

                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                String newFileName = "service_" + serviceId + "_" + System.currentTimeMillis() + "_" + fileName;
                String filePath = uploadPath + File.separator + newFileName;
                filePart.write(filePath);

                // Lưu đường dẫn tương đối
                relativePath = UPLOAD_DIR + "/" + newFileName;
            }
            // Nếu không chọn ảnh mới → dùng lại ảnh cũ
            if (relativePath == null || relativePath.isBlank()) {
                relativePath = oldImageUrl;
            }
            // 3. Tạo service mới để cập nhật
            Service s = new Service();
            s.setServiceId(serviceId);
            s.setTitle(title);
            s.setCredit(credit);
            s.setPrice(price);
            s.setServiceType(type);
            s.setDescription(description);
            s.setIsActive(isActive);
            if (relativePath != null) {
                s.setImgUrl(relativePath);
            }
            boolean success = false;
            if ("create".equals(actionService)) {
                success = service.insertServiceNew(s);
                session.setAttribute("messageService", success ? "Thêm mới thành công!" : "Thêm mới thất bại!");
            } else if ("edit".equals(actionService)) {
                s.setServiceId(Integer.parseInt(idStr));
                success = service.updateServiceNew(s);
                session.setAttribute("messageService", success ? "Cập nhật thành công!" : "Cập nhật thất bại!");
            } else {
                session.setAttribute("messageService", "Hành động không hợp lệ!");
            }
            session.removeAttribute("actionService");
            if (session.getAttribute("keywordService") != null && session.getAttribute("typeService") != null
                    && session.getAttribute("sortService") != null) {

                // Lấy bộ lọc đã lưu trong session
                String keywordService = session.getAttribute("keywordService").toString();
                String typeService = session.getAttribute("typeService").toString();

                String fromPriceStr = session.getAttribute("fromPriceService") != null
                        ? session.getAttribute("fromPriceService").toString().replace(".", "")
                        : null;
                String toPriceStr = session.getAttribute("toPriceService") != null
                        ? session.getAttribute("toPriceService").toString().replace(".", "")
                        : null;

                Double fromPrice = (fromPriceStr != null && !fromPriceStr.isBlank())
                        ? Double.valueOf(fromPriceStr)
                        : null;
                Double toPrice = (toPriceStr != null && !toPriceStr.isBlank())
                        ? Double.valueOf(toPriceStr)
                        : null;

                String sortService = (String) session.getAttribute("sortService").toString();

                List<Service> services = service.filterServicesAdmin(keywordService, typeService, fromPrice, toPrice, sortService);
                //Phan trang
                int numAll = services.size();
                int numPerPage = 5; // moi trang co 10
                int numPage = numAll / numPerPage + (numAll % numPerPage == 0 ? 0 : 1);
                int start, end;
                int page;
                Object tpage = session.getAttribute("page");
                try {
                    page = Integer.parseInt(tpage.toString());
                } catch (NumberFormatException e) {
                    page = 1;
                }
                start = (page - 1) * numPerPage;
                if (numPerPage * page > numAll) {
                    end = numAll;
                } else {
                    end = numPerPage * page;
                }
                var arr = service.getListServiceByPage(services, start, end);
                session.setAttribute("listService", arr);
                session.setAttribute("num", numPage);
                session.setAttribute("page", page);

                session.setAttribute("keywordService", keywordService);
                session.setAttribute("typeService", typeService);
                session.setAttribute("fromPriceService", (fromPriceStr != null && !fromPriceStr.isEmpty()) ? formatSalary(fromPrice) : null);
                session.setAttribute("toPriceService", (toPriceStr != null && !toPriceStr.isEmpty()) ? formatSalary(toPrice) : null);
                session.setAttribute("sortService", sortService);
                response.sendRedirect("manageService.jsp");
                return;
            }

            response.sendRedirect("ManageServiceAdmin");
        } catch (SQLException ex) {
            Logger.getLogger(EditServiceAdmin.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public List<String> validateService(
            String title,
            String creditStr,
            String priceStr,
            String type,
            String description,
            Part imageFile
    ) {
        List<String> errors = new ArrayList<>();

        // Validate title
        if (title == null || title.trim().isEmpty()) {
            errors.add("Tên gói dịch vụ là bắt buộc.");
        }

        // Validate credit
        if (creditStr == null || creditStr.trim().isEmpty()) {
            errors.add("Số lượng đăng bài là bắt buộc.");
        } else {
            try {
                int credit = Integer.parseInt(creditStr);
                if (credit <= 0) {
                    errors.add("Credit phải lớn hơn 0.");
                } else if (credit > 100000000) {
                    errors.add("Credit lớn quá.");
                }
            } catch (NumberFormatException e) {
                errors.add("Credit phải là số nguyên hợp lệ.");
            }
        }

        // Validate price (có thể null)
        if (priceStr != null && !priceStr.trim().isEmpty()) {
            try {
                double price = Double.parseDouble(priceStr);
                if (price < 0) {
                    errors.add("Giá không được âm.");
                } else if (price > 100000000) {
                    errors.add("price lớn quá.");
                }
            } catch (NumberFormatException e) {
                errors.add("Giá phải là số hợp lệ.");
            }
        }

        // Validate type
        if (type == null || type.trim().isEmpty()) {
            errors.add("Loại dịch vụ là bắt buộc.");
        }
        // Check duplicate (chỉ khi cả hai đã có giá trị)
        if (title != null && !title.trim().isEmpty()
                && type != null && !type.trim().isEmpty()) {
            if (service.isTitleAndTypeDuplicate(title.trim(), type.trim())) {
                errors.add("Tên gói dịch vụ và loại đã tồn tại.");
            }
        }

        // Validate description
        if (description == null || description.trim().isEmpty()) {
            errors.add("Mô tả dịch vụ là bắt buộc.");
        }

        // Validate image file nếu được chọn
        if (imageFile != null && imageFile.getSize() > 0) {
            String contentType = imageFile.getContentType();
            String fileName = Paths.get(imageFile.getSubmittedFileName()).getFileName().toString().toLowerCase();
            if (contentType == null || !contentType.startsWith("image/")
                    || !(fileName.endsWith(".jpg") || fileName.endsWith(".jpeg")
                    || fileName.endsWith(".png") || fileName.endsWith(".gif"))) {
                errors.add("Tệp ảnh không hợp lệ. Chỉ chấp nhận JPG, JPEG, PNG, GIF.");
            }
        }

        return errors;
    }

    public String formatSalary(double salary) {
        DecimalFormatSymbols symbols = new DecimalFormatSymbols();
        symbols.setGroupingSeparator('.');
        DecimalFormat df = new DecimalFormat("#,##0", symbols);
        return df.format(salary);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
