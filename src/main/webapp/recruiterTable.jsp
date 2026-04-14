<%@page import="com.recruitment.model.Recruiter"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%
    List<Recruiter> recruiters = (List<Recruiter>) request.getAttribute("recruiters");
    int rowCount = 1;
%>
<div class="table-responsive">
    <table class="table table-bordered table-hover">
        <thead>
            <tr>
                <th>Stt</th>
                <th>Họ và tên</th>
                <th>Email</th>
                <th>Số điện thoại</th>
                <th>Tên Doanh nghiệp</th>
                <th>Trạng thái</th>
                <th>Hành động</th>
            </tr>
        </thead>
        <tbody>
            <% for (Recruiter recruiter : recruiters) { %>
                <tr>
                    <td><%=(rowCount++)+5*(pageNum-1)%></td>
                    <td><%= recruiter.getFullName() %></td>
                    <td><%= recruiter.getEmail() %></td>
                    <td><%= recruiter.getPhone() %></td>
                    <td><%= recruiter.getCompanyName() %></td>
                    <td><%= recruiter.isIsActive() ? "Khả dụng" : "Bị hạn chế" %></td>
                    <td>
                        <form action="manageAccount" method="post" style="display:inline;">
                            <input type="hidden" name="action" value="ban">
                            <input type="hidden" name="id" value="<%= recruiter.getRecruiterId() %>">
                            <input type="hidden" name="tab" value="recruiter">
                            <input type="hidden" name="page" value="<%= pageNum %>">
                            <% if (searchQuery != null && !searchQuery.isEmpty()) { %>
                                <input type="hidden" name="search_query" value="<%= searchQuery %>">
                            <% } %>
                            <% if (status != null && !status.isEmpty()) { %>
                                <input type="hidden" name="status" value="<%= status %>">
                            <% } %>
                            <button type="submit" class="btn btn-warning btn-sm">
                                <%= recruiter.isIsActive() ? "Hạn chế" : "Gỡ hạn chế" %>
                            </button>
                        </form>
                        <form action="manageAccount" method="post" style="display:inline;">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="id" value="<%= recruiter.getRecruiterId() %>">
                            <input type="hidden" name="tab" value="recruiter">
                            <input type="hidden" name="page" value="<%= pageNum %>">
                            <% if (searchQuery != null && !searchQuery.isEmpty()) { %>
                                <input type="hidden" name="search_query" value="<%= searchQuery %>">
                            <% } %>
                            <button type="submit" class="btn btn-danger btn-sm">Xóa</button>
                        </form>
                    </td>
                </tr>
            <% } %>
        </tbody>
    </table>
</div>
<!-- Pagination -->
<nav>
    <ul class="pagination">
        <% for (int i = 1; i <= totalPages; i++) { %>
            <li class="page-item <%= i == pageNum ? "active" : "" %>">
                <a class="page-link" href="manageAccount?tab=recruiter&page=<%= i %>
                   <% if (searchQuery != null && !searchQuery.isEmpty()) { %>&search_query=<%= java.net.URLEncoder.encode(searchQuery.trim(), "UTF-8") %><% } %>
                   <% if (status != null && !status.isEmpty()) { %>&status=<%= java.net.URLEncoder.encode(status.trim(), "UTF-8") %><% } %>">
                    <%= i %></a>
            </li>
        <% } %>
    </ul>
</nav>