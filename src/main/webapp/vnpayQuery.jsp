<%-- 
    Document   : vnpayQuery
    Created on : Jun 19, 2025, 6:44:04 PM
    Author     : HP
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>VNPay Query Result</title>
</head>
<body>
    <h2>VNPay Transaction Query Result</h2>
    <form action="${pageContext.request.contextPath}/vnpayquery" method="post">
        <label for="vnpTxnRef">Transaction Reference:</label><br>
        <input type="text" id="vnpTxnRef" name="vnp_TxnRef" value="TXN12345678"><br><br>
        <label for="orderId">Order ID:</label><br>
        <input type="text" id="orderId" name="orderId" value=""><br><br>
        <input type="submit" value="Submit">
    </form>
    <%-- Display response if available (e.g., after form submission redirect) --%>
    <% if (request.getAttribute("responseJson") != null) { %>
        <pre><%= request.getAttribute("responseJson") %></pre>
    <% } %>
</body>
</html>