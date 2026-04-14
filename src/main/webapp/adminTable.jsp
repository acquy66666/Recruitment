<%@page import="com.recruitment.model.Admin"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%
    List<Admin> admins = (List<Admin>) request.getAttribute("admins");
    int rowCount = 1;
%>
<div class="table-responsive">
    <table class="table table-bordered table-hover">
        <thead>
            <tr>
                <th>Stt</th>
                <th>Tên tài khoản</th>
                <th>Vai trò</th>
                <th>Trạng thái</th>
                <th>Hành động</th>
            </tr>
        </thead>
        <tbody>
            <% for (Admin admin : admins) { %>
                <tr>
                    <td><%= (rowCount++)+5*(pageNum-1) %></td>
                    <td><%= admin.getUsername() %></td>
                    <td><%= admin.getRole() %></td>
                    <td><%= admin.isActive() ? "Khả dụng" : "Bị hạn chế"%></td>
                    <td>
                        <form action="manageAccount" method="post" style="display:inline;">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="id" value="<%= admin.getId() %>">
                            <input type="hidden" name="tab" value="admin">
                            <input type="hidden" name="page" value="<%= pageNum %>">
                            <% if (searchQuery != null && !searchQuery.isEmpty()) { %>
                                <input type="hidden" name="search_query" value="<%= searchQuery %>">
                            <% } %>
                        </form>
                        <form action="manageAccount" method="post" style="display:inline;">
                            <input type="hidden" name="action" value="ban">
                            <input type="hidden" name="id" value="<%= admin.getId() %>">
                            <input type="hidden" name="tab" value="admin">
                            <input type="hidden" name="page" value="<%= pageNum %>">
                            <% if (searchQuery != null && !searchQuery.isEmpty()) { %>
                                <input type="hidden" name="search_query" value="<%= searchQuery %>">
                            <% } %>
                            <% if (status != null && !status.isEmpty()) { %>
                                <input type="hidden" name="status" value="<%= status %>">
                            <% } %>
                            <%if (!admin.getRole().equalsIgnoreCase("Admin")) {%>
                            <button type="submit" class="btn btn-warning btn-sm">
                                <%= admin.isActive() ? "Hạn chế" : "Gỡ hạn chế" %>
                            </button>
                            <% } %>
                        </form>
                        <form action="manageAccount" method="post" style="display:inline;">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="id" value="<%= admin.getId() %>">
                            <input type="hidden" name="tab" value="admin">
                            <input type="hidden" name="page" value="<%= pageNum %>">
                            <% if (searchQuery != null && !searchQuery.isEmpty()) { %>
                                <input type="hidden" name="search_query" value="<%= searchQuery %>">
                            <% } %>
                            <%if (!admin.getRole().equalsIgnoreCase("Admin")) {%>
                            <button type="submit" class="btn btn-danger btn-sm">Xóa</button>
                            <% } %>
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
                <a class="page-link" href="manageAccount?tab=admin&page=<%= i %><% if (searchQuery != null && !searchQuery.isEmpty()) { %>&search_query=<%= java.net.URLEncoder.encode(searchQuery, "UTF-8") %><% } %>
                   <% if (status != null && !status.isEmpty()) { %>&status=<%= java.net.URLEncoder.encode(status, "UTF-8") %><% } %>">
                    <%= i %></a>
            </li>
        <% } %>
    </ul>
</nav>