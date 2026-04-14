package com.recruitment.controller.recruiter;

import com.recruitment.dao.RecruiterDAO;
import com.recruitment.dao.ServiceDAO;
import com.recruitment.model.Recruiter;
import com.recruitment.model.Service;
import com.recruitment.utils.CreditManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

@WebServlet(name = "BuyServices", urlPatterns = {"/buyServices"})
public class BuyServicesServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(BuyServicesServlet.class.getName());
    private ServiceDAO serviceDAO;

    @Override
    public void init() throws ServletException {
        serviceDAO = new ServiceDAO();
        LOGGER.info("BuyServicesServlet initialized");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("Recruiter") == null) {
                LOGGER.warning("No session or Recruiter found, redirecting to login");
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }

            String search = request.getParameter("search");
            String sortBy = request.getParameter("sort") != null ? request.getParameter("sort") : "service_id_desc";
            String serviceType = request.getParameter("serviceType");
            int page = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;

            // Fetch distinct service types for the filter dropdown
            List<String> availableServiceTypes = serviceDAO.getAllServiceTypes();
            LOGGER.info("Fetched service types: " + availableServiceTypes);

            // Fetch services
            List<Service> services = serviceDAO.getFilteredServices(search, serviceType, "active", sortBy, page);
            int totalPages = serviceDAO.getTotalPages(search, serviceType, "active");

            // Get recruiter credits from session
            Recruiter recruiter = (Recruiter) session.getAttribute("Recruiter");
            Map<String, Integer> recruiterCredits = new HashMap<>();

            // Lấy credit từ DB thay vì session
            RecruiterDAO recruiterDAO = new RecruiterDAO();
            String creditsJson = recruiterDAO.getCreditByRecruiterId(recruiter.getRecruiterId());

            if (creditsJson != null) {
                recruiterCredits = CreditManager.parseCreditsFromJson(creditsJson);
                LOGGER.info("Parsed recruiter credits from DB: " + recruiterCredits);
            } else {
                LOGGER.warning("Recruiter credit is null in DB for recruiterId: " + recruiter.getRecruiterId());
            }

            request.setAttribute("availableServiceTypes", availableServiceTypes);
            request.setAttribute("services", services);
            request.setAttribute("search", search);
            request.setAttribute("serviceType", serviceType);
            request.setAttribute("sort", sortBy);
            request.setAttribute("page", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("recruiterCredits", recruiterCredits);
            request.getRequestDispatcher("/buyServices.jsp").forward(request, response);
        } catch (SQLException e) {
            LOGGER.severe("Database error: " + e.getMessage());
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi cơ sở dữ liệu: " + e.getMessage());
        } catch (NumberFormatException e) {
            LOGGER.warning("Invalid page number format: " + e.getMessage());
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Định dạng số trang không hợp lệ.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("Recruiter") == null) {
                LOGGER.warning("No session or Recruiter found, redirecting to login");
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }

            Recruiter recruiter = (Recruiter) session.getAttribute("Recruiter");
            Map<String, Integer> recruiterCredits = recruiter.getCredit() != null
                    ? CreditManager.parseCreditsFromJson(recruiter.getCredit())
                    : new HashMap<>();

            String[] selectedServiceIds = request.getParameterValues("serviceId");
            if (selectedServiceIds == null || selectedServiceIds.length == 0) {
                request.setAttribute("message", "Vui lòng chọn ít nhất một dịch vụ để mua.");
                doGet(request, response);
                return;
            }
            int n = selectedServiceIds.length;
            for (int i = 0; i < n - 1; i++) {
                for (int j = i + 1; j < n; j++) {
                    int id1 = Integer.parseInt(selectedServiceIds[i]);
                    int id2 = Integer.parseInt(selectedServiceIds[j]);
                    if (serviceDAO.getServiceById(id2).equals(serviceDAO.getServiceById(id1))) {
                        request.setAttribute("message", "Không thể chọn 2 gói cùng 1 loại dịch vj.");
                        doGet(request, response);
                        return;
                    }
                }
            }

            // Fetch restricted service types dynamically
            List<String> restrictedServiceTypes = serviceDAO.getAllServiceTypes();

            // Validate selected services
            List<Integer> serviceIds = new ArrayList<>();
            for (String serviceId : selectedServiceIds) {
                try {
                    int id = Integer.parseInt(serviceId);
                    Service service = serviceDAO.getServiceById(id);
                    if (service == null) {
                        request.setAttribute("message", "ID dịch vụ không hợp lệ: " + id);
                        doGet(request, response);
                        return;
                    }
                    String serviceType = service.getServiceType();
                    if (restrictedServiceTypes.contains(serviceType) && recruiterCredits.getOrDefault(serviceType, 0) > 0) {
                        request.setAttribute("message", "Không thể mua dịch vụ '" + service.getServiceType() + "' vì bạn đã có " + recruiterCredits.get(serviceType) + " credits cho loại '" + serviceType + "'.");
                        doGet(request, response);
                        return;
                    }
                    serviceIds.add(id);
                } catch (NumberFormatException e) {
                    LOGGER.warning("Invalid service ID format: " + e.getMessage());
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Định dạng ID dịch vụ không hợp lệ.");
                    return;
                }
            }

            // Store selected service IDs in session
            session.setAttribute("selectedServiceIds", serviceIds);

            // Redirect to service payment page
            response.sendRedirect(request.getContextPath() + "/servicepayment");
        } catch (SQLException e) {
            LOGGER.severe("Database error: " + e.getMessage());
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi cơ sở dữ liệu: " + e.getMessage());
        }
    }

    @Override
    public void destroy() {
        // Cleanup if needed
    }
}
