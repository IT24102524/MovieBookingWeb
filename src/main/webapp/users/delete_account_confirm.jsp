<%@ page import="main.java.com.movieticket.model.User" %>
<%
    User user = (User) request.getAttribute("user");
%>



<h1 class="mb-4 text-danger">Confirm Account Deletion</h1>

<div class="alert alert-danger" role="alert">
    Are you sure you want to delete user "<strong><%= user.getName() %></strong>"?
</div>

<form action="users" method="post">
    <input type="hidden" name="action" value="delete" />
    <input type="hidden" name="userId" value="<%= user.getUserId() %>" />
    <button type="submit" class="btn btn-danger">Yes, Delete</button>
    <a href="${pageContext.request.contextPath}/users/profile.jsp" class="btn btn-secondary ms-2">Cancel</a>
</form>


