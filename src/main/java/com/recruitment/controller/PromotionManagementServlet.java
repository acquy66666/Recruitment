package com.recruitment.controller;

import com.recruitment.dao.PromotionDAO;
import com.recruitment.model.Promotion;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "PromotionManagementServlet", urlPatterns = {"/managePromotions"})
public class PromotionManagementServlet extends HttpServlet {

    private PromotionDAO promotionDAO;
    private static final String[] ALLOWED_STATUSES = {"", "active", "inactive"};
    private static final String[] ALLOWED_DATE_FILTERS = {"", "ongoing", "upcoming", "expired"};
    private static final String[] ALLOWED_SORT_OPTIONS = {"created_at_desc", "discount_asc", "discount_desc", "quantity_asc", "quantity_desc"};
    private List<String> ALLOWED_TYPES; // Move to instance variable

    @Override
    public void init() throws ServletException {
        promotionDAO = new PromotionDAO();
        try {
            ALLOWED_TYPES = promotionDAO.getAllPromotionType();
            if (ALLOWED_TYPES == null) {
                ALLOWED_TYPES = new ArrayList<>(); // empty if list is null
            }
        } catch (SQLException e) {
            throw new ServletException("Failed to initialize promotion types: " + e.getMessage(), e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Check if admin is logged in
        if (request.getSession().getAttribute("Admin") == null) {
            response.sendRedirect("login");
            return;
        }

        try {
            // Validate parameters
            String search = request.getParameter("search") != null ? request.getParameter("search").trim().replaceAll("\\s+", " ") : "";
            if (search.length() > 100 || search.contains(";") || search.contains("--")) {
                search = "";
            }

            String type = request.getParameter("type") != null ? request.getParameter("type") : "";
            boolean isValidType = type.isEmpty() || ALLOWED_TYPES.contains(type);

            String status = request.getParameter("status") != null ? request.getParameter("status") : "";
            boolean isValidStatus = false;
            for (String allowedStatus : ALLOWED_STATUSES) {
                if (allowedStatus.equals(status)) {
                    isValidStatus = true;
                    break;
                }
            }

            String dateFilter = request.getParameter("dateFilter") != null ? request.getParameter("dateFilter") : "";
            boolean isValidDateFilter = false;
            for (String allowedDateFilter : ALLOWED_DATE_FILTERS) {
                if (allowedDateFilter.equals(dateFilter)) {
                    isValidDateFilter = true;
                    break;
                }
            }

            String sortBy = request.getParameter("sortBy") != null ? request.getParameter("sortBy") : "created_at_desc";
            boolean isValidSortBy = false;
            for (String allowedSort : ALLOWED_SORT_OPTIONS) {
                if (allowedSort.equals(sortBy)) {
                    isValidSortBy = true;
                    break;
                }
            }

            int page = parsePageNumber(request.getParameter("page"));

            // Redirect if any parameter is invalid
            if (!isValidType || !isValidStatus || !isValidDateFilter || !isValidSortBy || page < 1) {
                response.sendRedirect("managePromotions?type=&status=&dateFilter=&sortBy=created_at_desc&page=1");
                return;
            }

            // Get promotions and total pages from DAO
            List<Promotion> promotions = promotionDAO.getFilteredPromotions(search, type, status, dateFilter, sortBy, page);
            int totalPages = promotionDAO.getTotalPages(search, type, status, dateFilter);
            List<String> pTypes = promotionDAO.getAllPromotionType(); // For JSP dropdown

            // Set attributes for JSP
            request.setAttribute("promotions", promotions);
            request.setAttribute("allTypes", pTypes);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("currentPage", page);
            request.setAttribute("search", search);
            request.setAttribute("type", type);
            request.setAttribute("status", status);
            request.setAttribute("dateFilter", dateFilter);
            request.setAttribute("sortBy", sortBy);

            // Forward to JSP
            request.getRequestDispatcher("promotionManagement.jsp").forward(request, response);

        } catch (SQLException e) {
            System.err.println("Database error: " + e.getMessage());
            request.setAttribute("errorMessage", "A database error occurred. Please try again later.");
            request.getRequestDispatcher("promotionManagement.jsp").forward(request, response);
        } catch (ServletException | IOException e) {
            System.err.println("Unexpected error: " + e.getMessage());
            response.sendRedirect("managePromotions?type=&status=&dateFilter=&sortBy=created_at_desc&page=1");
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
            if ("delete".equals(action)) {
                int promotionId = Integer.parseInt(request.getParameter("promotionId"));
                promotionDAO.deletePromotion(promotionId);
                request.setAttribute("successMessage", "Promotion deleted successfully.");
            } else if ("toggleStatus".equals(action)) {
                int promotionId = Integer.parseInt(request.getParameter("promotionId"));
                boolean isActive = Boolean.parseBoolean(request.getParameter("isActive"));
                promotionDAO.setPromotionActive(promotionId, isActive);
                request.setAttribute("successMessage", "Promotion status updated successfully.");
            }

            // Reconstruct query string with form parameters
            String search = request.getParameter("search") != null ? request.getParameter("search").trim() : "";
            String type = request.getParameter("type") != null ? request.getParameter("type") : "";
            String status = request.getParameter("status") != null ? request.getParameter("status") : "";
            String dateFilter = request.getParameter("dateFilter") != null ? request.getParameter("dateFilter") : "";
            String sortBy = request.getParameter("sortBy") != null ? request.getParameter("sortBy") : "created_at_desc";
            String page = request.getParameter("page") != null ? request.getParameter("page") : "1";

            // Validate parameters for redirect
            boolean isValidType = type.isEmpty() || ALLOWED_TYPES.contains(type);
            boolean isValidStatus = false;
            for (String allowedStatus : ALLOWED_STATUSES) {
                if (allowedStatus.equals(status)) {
                    isValidStatus = true;
                    break;
                }
            }

            boolean isValidDateFilter = false;
            for (String allowedDateFilter : ALLOWED_DATE_FILTERS) {
                if (allowedDateFilter.equals(dateFilter)) {
                    isValidDateFilter = true;
                    break;
                }
            }

            boolean isValidSortBy = false;
            for (String allowedSort : ALLOWED_SORT_OPTIONS) {
                if (allowedSort.equals(sortBy)) {
                    isValidSortBy = true;
                    break;
                }
            }

            int pageNum = parsePageNumber(page);

            // Use default values if parameters are invalid
            if (!isValidType) {
                type = "";
            }
            if (!isValidStatus) {
                status = "";
            }
            if (!isValidDateFilter) {
                dateFilter = "";
            }
            if (!isValidSortBy) {
                sortBy = "created_at_desc";
            }
            if (pageNum < 1) {
                pageNum = 1;
            }

            // Build redirect URL
            String redirectUrl = String.format("managePromotions?search=%s&type=%s&status=%s&dateFilter=%s&sortBy=%s&page=%d",
                    java.net.URLEncoder.encode(search, "UTF-8"),
                    java.net.URLEncoder.encode(type, "UTF-8"),
                    java.net.URLEncoder.encode(status, "UTF-8"),
                    java.net.URLEncoder.encode(dateFilter, "UTF-8"),
                    java.net.URLEncoder.encode(sortBy, "UTF-8"),
                    pageNum);
            response.sendRedirect(redirectUrl);

        } catch (SQLException e) {
            System.err.println("Database error: " + e.getMessage());
            request.setAttribute("errorMessage", "A database error occurred. Please try again later.");
            request.getRequestDispatcher("promotionManagement.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            System.err.println("Invalid input format: " + e.getMessage());
            response.sendRedirect("managePromotions?type=&status=&dateFilter=&sortBy=created_at_desc&page=1");
        } catch (IOException e) {
            System.err.println("Unexpected error: " + e.getMessage());
            response.sendRedirect("managePromotions?type=&status=&dateFilter=&sortBy=created_at_desc&page=1");
        }
    }

    private int parsePageNumber(String pageStr) {
        if (pageStr == null || pageStr.isEmpty()) {
            return 1;
        }
        try {
            int page = Integer.parseInt(pageStr);
            return page > 0 ? page : 1;
        } catch (NumberFormatException e) {
            return 1;
        }
    }
}