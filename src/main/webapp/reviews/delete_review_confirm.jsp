<%@ page import="main.java.com.movieticket.model.Review" %>
<%
    Review review = (Review) request.getAttribute("review");
%>

<%@ include file="../header.jsp" %>

<h1 class="mb-4 text-danger">Delete Review Confirmation</h1>

<div class="alert alert-danger" role="alert">
    Are you sure you want to delete review "<strong><%= review.getReviewId() %></strong>"?
</div>

<form action="reviews" method="post">
    <input type="hidden" name="action" value="delete" />
    <input type="hidden" name="reviewId" value="<%= review.getReviewId() %>" />
    <button type="submit" class="btn btn-danger">Yes, Delete</button>
    <a href="reviews" class="btn btn-secondary ms-2">Cancel</a>
</form>

<%@ include file="../footer.jsp" %>
