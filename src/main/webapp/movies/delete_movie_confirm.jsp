<%@ page import="main.java.com.movieticket.model.Movie" %>
<%
    Movie movie = (Movie) request.getAttribute("movie");
%>


<h1 class="mb-4 text-danger">Delete Movie Confirmation</h1>

<div class="alert alert-danger" role="alert">
    Are you sure you want to delete the movie "<strong><%= movie.getTitle() %></strong>"?
</div>

<form action="movies" method="post">
    <input type="hidden" name="action" value="delete" />
    <input type="hidden" name="movieId" value="<%= movie.getMovieId() %>" />
    <button type="submit" class="btn btn-danger">Yes, Delete</button>
    <a href="movies" class="btn btn-secondary ms-2">Cancel</a>
</form>
