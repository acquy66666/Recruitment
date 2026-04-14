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
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.util.List;

@WebServlet(name = "ManageServiceAdmin", urlPatterns = {"/ManageServiceAdmin"})
public class ManageServiceAdmin extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ManageServiceAdmin</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManageServiceAdmin at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        ServiceDAO service = new ServiceDAO();
        HttpSession session = request.getSession();
        List<Service> listService = service.getAllServiceAdmin();
        List<String> typeServiceList = service.getAllTypeService();
        //Phan trang
        int numAll = listService.size();
        int numPerPage = 5; // moi trang co 10
        int numPage = numAll / numPerPage + (numAll % numPerPage == 0 ? 0 : 1);
        int start, end;
        int page;
        String tpage = request.getParameter("page");//Lay trang page so may hien tai
        try {
            page = Integer.parseInt(tpage);
        } catch (NumberFormatException e) {
            page = 1;
        }
        start = (page - 1) * numPerPage;
        if (numPerPage * page > numAll) {
            end = numAll;
        } else {
            end = numPerPage * page;
        }
        var arr = service.getListServiceByPage(listService, start, end);
        session.setAttribute("listService", arr);
        session.setAttribute("num", numPage);
        session.setAttribute("page", page);
        session.setAttribute("typeServiceList", typeServiceList);

        session.removeAttribute("currentTab");
        session.removeAttribute("keywordService");
        session.removeAttribute("typeService");
        session.removeAttribute("fromPriceService");
        session.removeAttribute("toPriceService");
        session.removeAttribute("sortService");

        response.sendRedirect("manageService.jsp");

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        ServiceDAO service = new ServiceDAO();
        HttpSession session = request.getSession();
        String keywordService = request.getParameter("keywordService");
        String typeService = request.getParameter("typeService");

        String fromPriceService = request.getParameter("fromPriceService").replace(".", "");;
        Double fromPrice = (fromPriceService != null && !fromPriceService.isEmpty()) ? Double.valueOf(fromPriceService) : null;

        String toPriceService = request.getParameter("toPriceService").replace(".", "");;
        Double toPrice = (toPriceService != null && !toPriceService.isEmpty()) ? Double.valueOf(toPriceService) : null;

        String sortService = request.getParameter("sortService");

        String serviceId = request.getParameter("serviceId");
        String statusServiceUpdate = request.getParameter("statusServiceUpdate");
        String actionService = request.getParameter("actionService");
        if (actionService != null && actionService.equals("updateService")) {
            boolean isActive = "1".equals(statusServiceUpdate); // "1" → true, "0" → false
            service.updateIsActiveService(isActive, serviceId);
            session.setAttribute("messageServiceUpdate", "Cập nhật trạng thái thành công");
        }
        if (!isValidPriceRange(fromPrice, toPrice)) {
            session.setAttribute("errorService", "Giá đến phải lớn hơn hoặc bằng giá từ.");
            session.setAttribute("keywordService", keywordService);
            session.setAttribute("typeService", typeService);
            session.setAttribute("fromPriceService", (fromPriceService != null && !fromPriceService.isEmpty()) ? formatSalary(fromPrice) : null);
            session.setAttribute("toPriceService", (toPriceService != null && !toPriceService.isEmpty()) ? formatSalary(toPrice) : null);
            session.setAttribute("sortService", sortService);
            response.sendRedirect("manageService.jsp");
            return;
        }
        List<Service> services = service.filterServicesAdmin(keywordService, typeService, fromPrice, toPrice, sortService);
        //Phan trang
        int numAll = services.size();
        int numPerPage = 5; // moi trang co 10
        int numPage = numAll / numPerPage + (numAll % numPerPage == 0 ? 0 : 1);
        int start, end;
        int page;
        String tpage = request.getParameter("page");//Lay trang page so may hien tai
        try {
            page = Integer.parseInt(tpage);
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
        session.setAttribute("fromPriceService", (fromPriceService != null && !fromPriceService.isEmpty()) ? formatSalary(fromPrice) : null);
        session.setAttribute("toPriceService", (toPriceService != null && !toPriceService.isEmpty()) ? formatSalary(toPrice) : null);
        session.setAttribute("sortService", sortService);
        response.sendRedirect("manageService.jsp");
    }

    private boolean isValidPriceRange(Double fromPrice, Double toPrice) {
        if (fromPrice == null || toPrice == null) {
            return true; // nếu thiếu 1 trong 2 giá thì không kiểm tra
        }
        return toPrice >= fromPrice;
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
