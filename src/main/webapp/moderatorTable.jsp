<%@page import="com.recruitment.model.Moderator"%>
<%@page import="java.util.List"%>
<%
    List<Moderator> moderators = (List<Moderator>) request.getAttribute("moderators");
    int rowCount = 1;
%>
<div class="table-responsive">
    <table class="table table-bordered table-hover">
        <thead>
            <tr>
                <th>No.</th>
                <th>Username</th>
                <th>Role</th>
                <th>Active</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <% for (Moderator moderator : moderators) { %>
                <tr>
                    <td><%= (rowCount++)+5*(pageNum-1) %></td>
                    <td><%= moderator.getUsername() %></td>
                    <td>Moderator</td>
                    <td><%= moderator.isActive() ? "Yes" : "No" %></td>
                    <td>
                        <form action="manageAccount" method="post" style="display:inline;">
                            <input type="hidden" name="action" value="ban">
                            <input type="hidden" name="id" value="<%= moderator.getModeratorsId() %>">
                            <input type="hidden" name="tab" value="moderator">
                            <input type="hidden" name="page" value="<%= pageNum %>">
                            <% if (searchQuery != null && !searchQuery.isEmpty()) { %>
                                <input type="hidden" name="search_query" value="<%= searchQuery %>">
                            <% } %>
                            <button type="submit" class="btn btn-warning btn-sm">
                                <%= moderator.isActive() ? "Ban" : "Unban" %>
                            </button>
                        </form>
                        <form action="manageAccount" method="post" style="display:inline;">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="id" value="<%= moderator.getModeratorsId() %>">
                            <input type="hidden" name="tab" value="moderator">
                            <input type="hidden" name="page" value="<%= pageNum %>">
                            <% if (searchQuery != null && !searchQuery.isEmpty()) { %>
                                <input type="hidden" name="search_query" value="<%= searchQuery %>">
                            <% } %>
                            <button type="submit" class="btn btn-danger btn-sm">Delete</button>
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
                <a class="page-link" href="manageAccount?tab=moderator&page=<%= i %><% if (searchQuery != null && !searchQuery.isEmpty()) { %>&search_query=<%= java.net.URLEncoder.encode(searchQuery, "UTF-8") %><% } %>"><%= i %></a>
            </li>
        <% } %>
    </ul>
</nav>