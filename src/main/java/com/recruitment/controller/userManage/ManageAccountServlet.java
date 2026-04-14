package com.recruitment.controller.userManage;

import com.recruitment.dao.RecruiterDAO;
import com.recruitment.dao.AdminDAO;
import com.recruitment.dao.CandidateDAO;
import com.recruitment.model.Recruiter;
import com.recruitment.model.Candidate;
import com.recruitment.model.Admin;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@WebServlet(name = "ManageAccountServlet", urlPatterns = {"/manageAccount"})
public class ManageAccountServlet extends HttpServlet {

    private static final int ACCOUNTS_PER_PAGE = 5;

    private static final String[] ALLOWED_TABS = {"admin", "recruiter", "candidate"};
    private static final String[] ALLOWED_STATUSES = {"", "active", "inactive"};

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Check if admin is logged in
        if (request.getSession().getAttribute("Admin") == null) {
            response.sendRedirect("login");
            return;
        }

        try {
            // Validate tab parameter
            String tab = request.getParameter("tab");
            boolean isValidTab = false;
            if (tab == null || tab.isEmpty()) {
                tab = "admin"; // Default to admin
                isValidTab = true;
            } else {
                for (String allowedTab : ALLOWED_TABS) {
                    if (allowedTab.equals(tab)) {
                        isValidTab = true;
                        break;
                    }
                }
            }

            // Validate status parameter
            String status = request.getParameter("status");
            boolean isValidStatus = false;
            if (status == null || status.isEmpty()) {
                status = ""; // Default to all statuses
                isValidStatus = true;
            } else {
                for (String allowedStatus : ALLOWED_STATUSES) {
                    if (allowedStatus.equals(status)) {
                        isValidStatus = true;
                        break;
                    }
                }
            }

            // Validate page parameter
            int page = parsePageNumber(request.getParameter("page"));
            if (page < 1) {
                page = 1; // Default to page 1
            }

            // Redirect if tab or status is invalid
            if (!isValidTab || !isValidStatus) {
                response.sendRedirect("manageAccount?tab=admin&page=1&status=");
                return;
            }

            // Sanitize search query
            String searchQuery = request.getParameter("search_query");
            if (searchQuery != null) {
                searchQuery = searchQuery.trim().replaceAll("\\s+", " ");
                // Basic sanitization to prevent SQL injection
                if (searchQuery.length() > 100 || searchQuery.contains(";") || searchQuery.contains("--")) {
                    searchQuery = null; // Reject potentially malicious input
                }
            }

            // Initialize DAOs
            RecruiterDAO recruiterDAO = new RecruiterDAO();
            CandidateDAO candidateDAO = new CandidateDAO();
            AdminDAO adminDAO = new AdminDAO();

            // Fetch data based on tab, search query, and status
            List<Admin> admins = null;
            List<Recruiter> recruiters = null;
            List<Candidate> candidates = null;
            int totalPages = 0;

            switch (tab) {
                case "admin":
                    if (searchQuery != null && !searchQuery.isEmpty()) {
                        admins = adminDAO.getPaginatedAdminsByUsername(searchQuery, status, page, ACCOUNTS_PER_PAGE);
                        totalPages = (int) Math.ceil(adminDAO.getTotalAdminsByUsername(searchQuery, status) / (double) ACCOUNTS_PER_PAGE);
                    } else {
                        admins = adminDAO.getPaginatedAdmins(status, page, ACCOUNTS_PER_PAGE);
                        totalPages = (int) Math.ceil(adminDAO.getTotalAdmins(status) / (double) ACCOUNTS_PER_PAGE);
                    }
                    break;
                case "recruiter":
                    if (searchQuery != null && !searchQuery.isEmpty()) {
                        recruiters = recruiterDAO.getPaginatedRecruitersByNameOrEmail(searchQuery, status, page, ACCOUNTS_PER_PAGE);
                        totalPages = (int) Math.ceil(recruiterDAO.getTotalRecruitersByNameOrEmail(searchQuery, status) / (double) ACCOUNTS_PER_PAGE);
                    } else {
                        recruiters = recruiterDAO.getPaginatedRecruiters(status, page, ACCOUNTS_PER_PAGE);
                        totalPages = (int) Math.ceil(recruiterDAO.getTotalRecruiters(status) / (double) ACCOUNTS_PER_PAGE);
                    }
                    break;
                case "candidate":
                    if (searchQuery != null && !searchQuery.isEmpty()) {
                        candidates = candidateDAO.getPaginatedCandidatesByNameOrEmail(searchQuery, status, page, ACCOUNTS_PER_PAGE);
                        totalPages = (int) Math.ceil(candidateDAO.getTotalCandidatesByNameOrEmail(searchQuery, status) / (double) ACCOUNTS_PER_PAGE);
                    } else {
                        candidates = candidateDAO.getPaginatedCandidates(status, page, ACCOUNTS_PER_PAGE);
                        totalPages = (int) Math.ceil(candidateDAO.getTotalCandidates(status) / (double) ACCOUNTS_PER_PAGE);
                    }
                    break;
            }

            // Set attributes
            request.setAttribute("admins", admins);
            request.setAttribute("recruiters", recruiters);
            request.setAttribute("candidates", candidates);
            request.setAttribute("tab", tab);
            request.setAttribute("page", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("search_query", searchQuery);
            request.setAttribute("status", status);

            // Forward to JSP
            request.getRequestDispatcher("manageAccount.jsp").forward(request, response);

        } catch (SQLException e) {
            request.getSession().setAttribute("errorMessage", "Database error: " + e.getMessage());
            response.sendRedirect("manageAccount?tab=admin&page=1&status=");
        } catch (ServletException | IOException e) {
            request.getSession().setAttribute("errorMessage", "Unexpected error: " + e.getMessage());
            response.sendRedirect("manageAccount?tab=admin&page=1&status=");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Check if admin is logged in
        if (request.getSession().getAttribute("Admin") == null) {
            response.sendRedirect("login");
            return;
        }

        try {
            String action = request.getParameter("action");
            String tab = request.getParameter("tab");
            if (tab == null) {
                tab = "admin";
            }
            Admin currentAdmin = (Admin) request.getSession().getAttribute("Admin");
            RecruiterDAO recruiterDAO = new RecruiterDAO();
            CandidateDAO candidateDAO = new CandidateDAO();
            AdminDAO adminDAO = new AdminDAO();

            String searchQuery = request.getParameter("search_query");
            String status = request.getParameter("status");
            String page = request.getParameter("page");

            if ("ban".equals(action)) {
                String id = request.getParameter("id");
                switch (tab) {
                    case "admin":
                        Admin admin = adminDAO.getAdminById(Integer.parseInt(id));
                        if (admin != null) {
                            admin.setActive(!admin.isActive());
                            adminDAO.updateAdmin(admin);
                            request.getSession().setAttribute("message", " Tài khoản " + admin.getRole() + " đã " + (admin.isActive() ? "gỡ bỏ hạn chế" : "bị hạn chế"));
                        }
                        break;
                    case "recruiter":
                        Recruiter recruiter = recruiterDAO.getRecruiterById(Integer.parseInt(id));
                        if (recruiter != null) {
                            recruiter.setIsActive(!recruiter.isIsActive());
                            recruiterDAO.updateRecruiter(recruiter);
                            request.getSession().setAttribute("message", "Tài khoản doanh nghiệp " + (recruiter.isIsActive() ? "đã được gỡ hạn chế" : "đã bị hạn chế"));
                        }
                        break;
                    case "candidate":
                        Candidate candidate = candidateDAO.getCandidateById(Integer.parseInt(id));
                        if (candidate != null) {
                            candidate.setActive(!candidate.isActive());
                            candidateDAO.updateCandidate(candidate);
                            request.getSession().setAttribute("message", "Tài khoản ứng viên " + (candidate.isActive() ? "đã được gỡ bỏ hạn chế" : "đã bị hạn chế"));
                        }
                        break;
                }
            } else if ("delete".equals(action)) {
                String id = request.getParameter("id");
                switch (tab) {
                    case "admin":
                        int adminId = Integer.parseInt(id);
                        if (currentAdmin.getId() != adminId) {
                            adminDAO.deleteAdmin(adminId);
                            request.getSession().setAttribute("message", "Xóa tài khoản thành công");
                        } else {
                            request.getSession().setAttribute("errorMessage", "Cannot delete your own account.");
                        }
                        break;
                    case "recruiter":
                        recruiterDAO.deleteRecruiter(Integer.parseInt(id));
                        request.getSession().setAttribute("message", "Tài khoản của nhà tuyển dụng đã bị xóa bỏ.");
                        break;
                    case "candidate":
                        candidateDAO.deleteCandidate(Integer.parseInt(id));
                        request.getSession().setAttribute("message", "Tài khoản của ứng viên đã bị xóa bỏ.");
                        break;
                }
            }

            // Redirect tab, page, and query parameters
            String redirectUrl = "manageAccount?tab=" + tab + "&page=" + (page != null ? page : "1");
            if (searchQuery != null && !searchQuery.isEmpty()) {
                redirectUrl += "&search_query=" + java.net.URLEncoder.encode(searchQuery, "UTF-8");
            }
            if (status != null && !status.isEmpty()) {
                redirectUrl += "&status=" + status;
            }
            response.sendRedirect(redirectUrl);

        } catch (SQLException e) {
            request.getSession().setAttribute("errorMessage", "Lỗi csdl: " + e.getMessage());
            response.sendRedirect("manageAccount?tab=" + request.getParameter("tab") + "&status=");
        }
    }

    private int parsePageNumber(String param) {
        if (param == null) {
            return 0;
        }
        Matcher matcher = Pattern.compile("\\d+").matcher(param);
        if (matcher.find()) {
            try {
                return Integer.parseInt(matcher.group());
            } catch (NumberFormatException e) {
                return 0;
            }
        }
        return 0;
    }
}