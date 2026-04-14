package com.recruitment.controller;

import com.recruitment.dao.AdminDAO;
import com.recruitment.dao.CandidateDAO;
import com.recruitment.dao.ModeratorDAO;
import com.recruitment.dao.RecruiterDAO;
import com.recruitment.model.Admin;
import com.recruitment.model.Candidate;
import com.recruitment.model.GoogleAccount;
import com.recruitment.model.Moderator;
import com.recruitment.model.Recruiter;
import com.recruitment.utils.GoogleLogin;
import com.recruitment.utils.PasswordUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.UUID;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private final RecruiterDAO recruiterDAO = new RecruiterDAO();
    private final CandidateDAO candidateDAO = new CandidateDAO();
    private final AdminDAO adminDAO = new AdminDAO();
    private final ModeratorDAO moderatorDAO = new ModeratorDAO();

    private static final int SESSION_TIMEOUT_SECONDS = 3 * 60 * 60; // 3 hours

    // #region agent log - login debug
    { System.err.println("[LOGIN_DEBUG] LoginServlet instantiated, DAO status: recruiterDAO=" + recruiterDAO + ", candidateDAO=" + candidateDAO); }
    // #endregion

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Handle Google OAuth callback
        String code = request.getParameter("code");
        if (code != null && !code.isEmpty()) {
            handleGoogleCallback(request, response, code);
            return;
        }

        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("loginId".equals(cookie.getName())) {
                    request.setAttribute("loginId", cookie.getValue());
                }
                if ("password".equals(cookie.getName())) {
                    request.setAttribute("password", cookie.getValue());
                }
                if ("remember".equals(cookie.getName())) {
                    request.setAttribute("remember", cookie.getValue());
                }
            }
        }

        // Determine which JSP to forward to based on a request parameter or URI
        String targetJsp = "login.jsp"; // Default to candidate login
        String requestUri = request.getRequestURI();
        String accountTypeParam = request.getParameter("accountType"); // Check if accountType is passed in URL

        if ("recruiter".equalsIgnoreCase(accountTypeParam) || requestUri.endsWith("RecruiterLogin.jsp")) {
            targetJsp = "RecruiterLogin.jsp";
        } else if (requestUri.endsWith("login.jsp")) {
            targetJsp = "login.jsp";
        }
        // If no specific accountType param and not a direct JSP access,
        // it's likely a general /login access, so default to login.jsp

        request.getRequestDispatcher(targetJsp).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String login = request.getParameter("login");
        String password = request.getParameter("password");
        String remember = request.getParameter("remember");
        String accountType = request.getParameter("accountType"); // Get account type from hidden field
        String error = null;

        // Determine target JSP based on accountType from the form
        String targetJsp = "login.jsp";
        if ("recruiter".equalsIgnoreCase(accountType)) {
            targetJsp = "RecruiterLogin.jsp";
        }

        // Validate input
        if (login == null || login.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            error = "Vui lòng nhập đầy đủ thông tin đăng nhập.";
            request.setAttribute("error", error);
            request.setAttribute("loginId", login); // Keep entered login ID
            request.getRequestDispatcher(targetJsp).forward(request, response); // Forward to correct JSP
            return;
        }

        String hashedPass = PasswordUtil.hashPassword(password);

        try {
            // Check Candidate
            Candidate candidate = candidateDAO.getCandidateByEmail(login);
            if (candidate != null) {
                // Kiểm tra nếu là tài khoản Google
                if (isGoogleAccount(candidate)) {
                    error = "Tài khoản này được tạo bằng Google. Vui lòng đăng nhập bằng Google.";
                } else if (candidate.getPasswordHash().equals(hashedPass)) {
                    if (!candidate.isActive()) {
                        error = "Tài khoản của bạn chưa được kích hoạt. Vui lòng kiểm tra email để kích hoạt.";
                    } else {
                        HttpSession session = request.getSession();
                        session.setMaxInactiveInterval(SESSION_TIMEOUT_SECONDS);
                        session.setAttribute("Candidate", candidate);
                        session.setAttribute("userType", "candidate");
                        session.setAttribute("userId", candidate.getCandidateId());
                        handleRememberMe(response, login, password, remember);
                        response.sendRedirect("HomePage.jsp");
                        return;
                    }
                } else {
                    error = "Mật khẩu không chính xác.";
                }
            }

            // Check Recruiter
            Recruiter recruiter = recruiterDAO.getRecruiterByEmailOrPhone(login);
            if (recruiter != null) {
                if (recruiter.getPasswordHash().equals(hashedPass)) {
                    HttpSession session = request.getSession();
                    session.setMaxInactiveInterval(SESSION_TIMEOUT_SECONDS);
                    session.setAttribute("Recruiter", recruiter);
                    session.setAttribute("userType", "recruiter");
                    session.setAttribute("userId", recruiter.getRecruiterId());
                    handleRememberMe(response, login, password, remember);
                    response.sendRedirect("HomePage.jsp");
                    return;
                } else {
                    error = "Mật khẩu không chính xác.";
                }
            }

            // Check Admin
            Admin admin = adminDAO.getAdminByUsername(login);
            if (admin != null) { // Check if admin exists first
                if (admin.getPasswordHash().equals(hashedPass) && admin.getRole().equalsIgnoreCase("Admin")) {
                    HttpSession session = request.getSession();
                    session.setMaxInactiveInterval(SESSION_TIMEOUT_SECONDS);
                    session.setAttribute("Admin", admin);
                    session.setAttribute("userType", "admin");
                    session.setAttribute("userId", admin.getId());
                    handleRememberMe(response, login, password, remember);
                    response.sendRedirect("HomePage.jsp");
                    return;
                } else if (admin.getPasswordHash().equals(hashedPass) && admin.getRole().equalsIgnoreCase("Moderator")) {
                    HttpSession session = request.getSession();
                    session.setMaxInactiveInterval(SESSION_TIMEOUT_SECONDS);
                    session.setAttribute("Moderator", admin); // Assuming Moderator model is Admin with role "Moderator"
                    session.setAttribute("userType", "moderator");
                    session.setAttribute("userId", admin.getId());
                    handleRememberMe(response, login, password, remember);
                    response.sendRedirect("HomePage.jsp");
                    return;
                } else {
                    error = "Mật khẩu không chính xác."; // Password incorrect for existing admin/moderator
                }
            }

            // If we reach here, no account found or password incorrect for candidate/admin/moderator/recruiter
            boolean accountExists = (candidate != null) || (admin != null) || (recruiter != null);
            if (accountExists && error == null) { // If error is null, it means password was incorrect
                error = "Mật khẩu không chính xác.";
            } else if (!accountExists) {
                error = "Tài khoản không tồn tại!";
            }

        } catch (SQLException ex) {
            error = "Lỗi cơ sở dữ liệu: " + ex.getMessage();
            ex.printStackTrace();
        }

        // Clear remember me cookies on failed login
        clearRememberMeCookies(response);

        // Forward back to the determined login page with error
        request.setAttribute("error", error);
        request.setAttribute("loginId", login); // Keep the entered login ID
        request.getRequestDispatcher(targetJsp).forward(request, response); // Forward to correct JSP
    }

    private boolean isGoogleAccount(Object user) {
        if (user instanceof Candidate) {
            Candidate candidate = (Candidate) user;
            return candidate.getPasswordHash() != null
                    && candidate.getPasswordHash().startsWith("GOOGLE_LOGIN_");
        }
        // Các loại user khác (Recruiter, Admin, Moderator) không hỗ trợ Google login
        return false;
    }

    private void handleGoogleCallback(HttpServletRequest request, HttpServletResponse response, String code)
            throws ServletException, IOException {
        try {
            // Get access token from Google
            String accessToken = GoogleLogin.getToken(code);
            // Get user info from Google
            GoogleAccount googleUser = GoogleLogin.getUserInfo(accessToken);

            if (googleUser == null || googleUser.getEmail() == null) {
                request.setAttribute("error", "Không thể lấy thông tin từ Google. Vui lòng thử lại.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }

            // KIỂM TRA XEM EMAIL ĐÃ TỒN TẠI TRONG CÁC LOẠI USER KHÁC CHƯA
            // Nếu email đã tồn tại như Recruiter, Admin, hoặc Moderator thì từ chối
            try {
                Recruiter existingRecruiter = recruiterDAO.getRecruiterByEmailOrPhone(googleUser.getEmail());
                if (existingRecruiter != null) {
                    request.setAttribute("error", "Email này đã được sử dụng bởi tài khoản nhà tuyển dụng.");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                    return;
                }
                Admin existingAdmin = adminDAO.getAdminByUsername(googleUser.getEmail());
                if (existingAdmin != null) {
                    request.setAttribute("error", "Email này đã được sử dụng bởi tài khoản quản trị/kiểm duyệt.");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                    return;
                }
                // No need to check Moderator separately if AdminDAO handles both roles based on username
                // Moderator existingModerator = moderatorDAO.getModeratorByUsername(googleUser.getEmail());
                // if (existingModerator != null) {
                //     request.setAttribute("error", "Email này đã được sử dụng bởi tài khoản kiểm duyệt.");
                //     request.getRequestDispatcher("login.jsp").forward(request, response);
                //     return;
                // }
            } catch (SQLException e) {
                e.printStackTrace(); // Log error but continue with candidate check
            }

            // Check if candidate already exists in database
            Candidate existingCandidate = candidateDAO.getCandidateByEmail(googleUser.getEmail());
            HttpSession session = request.getSession();

            if (existingCandidate != null) {
                // Candidate exists
                if (!existingCandidate.isActive()) {
                    // Activate account if it was inactive
                    candidateDAO.activateCandidate(existingCandidate.getCandidateId());
                    existingCandidate.setActive(true);
                }
                // Update profile picture if available
                if (googleUser.getPicture() != null && !googleUser.getPicture().isEmpty()) {
                    existingCandidate.setImageUrl(googleUser.getPicture());
                    candidateDAO.updateCandidate(existingCandidate);
                }
                session.setAttribute("Candidate", existingCandidate);
                session.setAttribute("userType", "candidate");
                session.setAttribute("userId", existingCandidate.getCandidateId());
                session.setAttribute("loginMessage", "Đăng nhập thành công với Google!");
            } else {
                // Create new candidate account
                Candidate newCandidate = createCandidateFromGoogle(googleUser);
                try {
                    int candidateId = candidateDAO.insertCandidate(newCandidate);
                    if (candidateId > 0) {
                        newCandidate.setCandidateId(candidateId);
                        session.setAttribute("Candidate", newCandidate);
                        session.setAttribute("userType", "candidate");
                        session.setAttribute("userId", candidateId);
                        session.setAttribute("loginMessage", "Chào mừng bạn đến với CVCenter! Tài khoản Candidate đã được tạo thành công.");
                    } else {
                        request.setAttribute("error", "Không thể tạo tài khoản Candidate. Vui lòng thử lại.");
                        request.getRequestDispatcher("login.jsp").forward(request, response);
                        return;
                    }
                } catch (SQLException e) {
                    request.setAttribute("error", "Lỗi tạo tài khoản Candidate: " + e.getMessage());
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                    return;
                }
            }
            // Redirect to home page
            response.sendRedirect("HomePage.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi đăng nhập Google: " + e.getMessage());
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    /**
     * Tạo Candidate từ thông tin Google
     */
    private Candidate createCandidateFromGoogle(GoogleAccount googleUser) {
        Candidate candidate = new Candidate();
        // Set basic info from Google
        candidate.setEmail(googleUser.getEmail());
        candidate.setFullName(googleUser.getName() != null ? googleUser.getName() : "Google User");
        candidate.setImageUrl(googleUser.getPicture() != null ? googleUser.getPicture() : "default.jpg");
        // Đánh dấu tài khoản Google bằng password đặc biệt
        candidate.setPasswordHash("GOOGLE_LOGIN_" + UUID.randomUUID().toString());
        // Lưu Google ID vào social_media_url
        candidate.setSocialMediaUrl("google:" + googleUser.getId());
        // Set default values
        candidate.setActive(true); // Google accounts are automatically activated
        candidate.setCreatedAt(LocalDateTime.now());
        candidate.setGender("Other");
        candidate.setPhone("N/A");
        candidate.setAddress("N/A");
        candidate.setBirthdate(LocalDate.now());
        return candidate;
    }

    private void handleRememberMe(HttpServletResponse response, String loginId, String password, String remember) {
        if ("on".equalsIgnoreCase(remember)) {
            // Set cookies with proper configuration
            Cookie loginIdCookie = new Cookie("loginId", loginId);
            loginIdCookie.setMaxAge(60 * 60 * 24 * 60); // 60 days
            loginIdCookie.setPath("/"); // Make cookie available to entire application
            loginIdCookie.setHttpOnly(true); // Security: prevent XSS attacks
            Cookie passCookie = new Cookie("password", password);
            passCookie.setMaxAge(60 * 60 * 24 * 60);
            passCookie.setPath("/");
            passCookie.setHttpOnly(true);
            Cookie remCookie = new Cookie("remember", "on");
            remCookie.setMaxAge(60 * 60 * 24 * 60);
            remCookie.setPath("/");
            remCookie.setHttpOnly(true);
            response.addCookie(loginIdCookie);
            response.addCookie(passCookie);
            response.addCookie(remCookie);
        } else {
            // Clear remember me cookies if not checked
            clearRememberMeCookies(response);
        }
    }

    private void clearRememberMeCookies(HttpServletResponse response) {
        // Clear existing remember me cookies
        Cookie loginIdCookie = new Cookie("loginId", "");
        loginIdCookie.setMaxAge(0);
        loginIdCookie.setPath("/");
        Cookie passCookie = new Cookie("password", "");
        passCookie.setMaxAge(0);
        passCookie.setPath("/");
        Cookie remCookie = new Cookie("remember", "");
        remCookie.setMaxAge(0);
        remCookie.setPath("/");
        response.addCookie(loginIdCookie);
        response.addCookie(passCookie);
        response.addCookie(remCookie);
    }

    @Override
    public String getServletInfo() {
        return "Login servlet supports login by email or username with secure password check";
    }
}
