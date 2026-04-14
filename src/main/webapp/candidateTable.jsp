<%@page import="com.recruitment.model.Candidate"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%
    List<Candidate> candidates = (List<Candidate>) request.getAttribute("candidates");
    int rowCount = 1;
%>
<div class="table-responsive">
    <table class="table table-bordered table-hover">
        <thead>
            <tr>
                <th>Stt</th>
                <th>Họ Tên</th>
                <th>Email</th>
                <th>Số điện thoại</th>
                <th>Trạng thái</th>
                <th>Hành động</th>
            </tr>
        </thead>
        <tbody>
            <% for (Candidate candidate : candidates) { %>
                <tr>
                    <td><%= (rowCount++)+5*(pageNum-1) %></td>
                    <td><%= candidate.getFullName() %></td>
                    <td><%= candidate.getEmail() %></td>
                    <td><%= candidate.getPhone() %></td>
                    <td><%= candidate.isActive() ? "Khả dụng" : "Bị hạn chế" %></td>
                    <td>
                        <form action="manageAccount" method="post" style="display:inline;">
                            <input type="hidden" name="action" value="ban">
                            <input type="hidden" name="id" value="<%= candidate.getCandidateId() %>">
                            <input type="hidden" name="tab" value="candidate">
                            <input type="hidden" name="page" value="<%= pageNum %>">
                            <% if (searchQuery != null && !searchQuery.isEmpty()) { %>
                                <input type="hidden" name="search_query" value="<%= searchQuery %>">
                            <% } %>
                            <button type="submit" class="btn btn-warning btn-sm">
                                <%= candidate.isActive() ? "Hạn chế" : "Gỡ hạn chế" %>
                            </button>
                        </form>
                        <form action="manageAccount" method="post" style="display:inline;">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="id" value="<%= candidate.getCandidateId() %>">
                            <input type="hidden" name="tab" value="candidate">
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
                <a class="page-link" href="manageAccount?tab=candidate&page=<%= i %><% if (searchQuery != null && !searchQuery.isEmpty()) { %>&search_query=<%= java.net.URLEncoder.encode(searchQuery, "UTF-8") %><% } %>
                   <% if (status != null && !status.isEmpty()) { %>&status=<%= java.net.URLEncoder.encode(status, "UTF-8") %><% } %>">
                    <%= i %></a>
            </li>
        <% } %>
    </ul>
</nav>