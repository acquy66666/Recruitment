package com.recruitment.controller.recruiter;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.recruitment.dao.CandidateDAO;
import com.recruitment.dto.CandidateApplicationDTO;
import com.recruitment.model.Candidate;
import com.recruitment.model.Recruiter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet(name = "SearchCandidateServlet", urlPatterns = {"/SearchCandidateServlet"})
public class SearchCandidateServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    public SearchCandidateServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Recruiter recruiter = (Recruiter) session.getAttribute("Recruiter");

        if (recruiter == null) {
            response.sendRedirect("login");
            return;
        }
        
        int recruiterId = recruiter.getRecruiterId();

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        PrintWriter out = response.getWriter();
        ObjectMapper mapper = new ObjectMapper();
        mapper.registerModule(new JavaTimeModule()); // Support for Java 8 time types
        Gson gson = new Gson();

        try {
            System.out.println("SearchCandidateServlet: Processing GET request at " + new java.util.Date());

            String email = request.getParameter("email");
            System.out.println("SearchCandidateServlet: Received email parameter: " + email);

            if (email == null || email.trim().isEmpty()) {
                System.out.println("SearchCandidateServlet: Email parameter is null or empty");
                JsonObject errorResponse = new JsonObject();
                errorResponse.addProperty("success", false);
                errorResponse.addProperty("message", "Email parameter is required");
                String errorJson = gson.toJson(errorResponse);
                System.out.println("SearchCandidateServlet: Sending error response: " + errorJson);
                out.print(errorJson);
                return;
            }

            System.out.println("SearchCandidateServlet: Searching candidates for email: " + email.trim());
            CandidateDAO candidateDAO = new CandidateDAO();
            List<CandidateApplicationDTO> candidates = candidateDAO.searchCandidatesByEmailAndRecruiter(email, recruiterId);
            System.out.println("SearchCandidateServlet: Found " + candidates.size() + " candidates");

            JsonObject jsonResponse = new JsonObject();
            jsonResponse.addProperty("success", true);
            String candidatesJson = mapper.writeValueAsString(candidates);
            System.out.println("SearchCandidateServlet: Jackson-serialized candidates: " + candidatesJson);
            jsonResponse.add("candidates", JsonParser.parseString(candidatesJson));

            String responseJson = gson.toJson(jsonResponse);
            System.out.println("SearchCandidateServlet: Sending response: " + responseJson);
            out.print(responseJson);

        } catch (Exception e) {
            System.err.println("SearchCandidateServlet: Error occurred: " + e.getMessage());
            e.printStackTrace();
            JsonObject errorResponse = new JsonObject();
            errorResponse.addProperty("success", false);
            errorResponse.addProperty("message", "Internal server error: " + e.getMessage());
            String errorJson = gson.toJson(errorResponse);
            System.out.println("SearchCandidateServlet: Sending error response: " + errorJson);
            out.print(errorJson);
        } finally {
            System.out.println("SearchCandidateServlet: Closing response writer");
            out.flush();
            out.close();
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("SearchCandidateServlet: Processing POST request at " + new java.util.Date());
        doGet(request, response);
    }
}
