<%@ page import="main.java.com.movieticket.model.Seat" %>
<%
    Seat seat = (Seat) request.getAttribute("seat");
%>

<%@ include file="../header.jsp" %>

<h1 class="mb-4 text-danger">Delete Seat Confirmation</h1>

<div class="alert alert-danger" role="alert">
    Are you sure you want to delete seat "<strong><%= seat.getSeatNumber() %></strong>"?
</div>

<form action="seats" method="post">
    <input type="hidden" name="action" value="delete" />
    <input type="hidden" name="seatId" value="<%= seat.getSeatId() %>" />
    <button type="submit" class="btn btn-danger">Yes, Delete</button>
    <a href="seats" class="btn btn-secondary ms-2">Cancel</a>
</form>

<%@ include file="../footer.jsp" %>
