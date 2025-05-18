<%@ page import="java.util.List" %>
<%@ page import="main.java.com.movieticket.model.Movie" %>
<%
    if (session == null || session.getAttribute("currentUser") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>



<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>Movies</title>


<style>
  /* Navbar Styles */
  body {
    margin: 0;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background: #fff;
    color: #000;
  }
  .navbar {
    background-color: #130800;
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 0.5rem 2rem;
    font-weight: 600;
  }
  .navbar .logo {
    color: #f2711c;
    font-size: 1.5rem;
    font-weight: bold;
    text-decoration: none;
  }
  .navbar ul {
    list-style: none;
    display: flex;
    gap: 1.5rem;
    margin: 0;
    padding: 0;
  }
  .navbar ul li {
    position: relative;
  }
  .navbar ul li a {
    color: white;
    text-decoration: none;
    padding: 0.5rem 0;
    display: block;
    transition: color 0.3s ease;
  }
  .navbar ul li a:hover,
  .navbar ul li a.active,
  .navbar ul li:hover > a {
    color: #f2711c;
  }
  .navbar ul li ul.dropdown {
    position: absolute;
    top: 100%;
    left: 0;
    background-color: #130800;
    display: none;
    min-width: 150px;
    padding: 0.5rem 0;
    border-radius: 0 0 6px 6px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.8);
  }
  .navbar ul li:hover ul.dropdown {
    display: block;
  }
  .navbar ul li ul.dropdown li {
    padding: 0;
  }
  .navbar ul li ul.dropdown li a {
    padding: 0.5rem 1rem;
    white-space: nowrap;
  }
  .navbar-icons {
    display: flex;
    gap: 1rem;
  }
  .navbar-icons a {
    color: white;
    font-size: 1.2rem;
    text-decoration: none;
    cursor: pointer;
  }
  .navbar-icons a:hover {
    color: #f2711c;
  }

  /* Movie cards grid styling */
  .movies-row {
    display: flex;
    flex-wrap: wrap;
    gap: 1.5rem;
    padding: 2rem;
    max-width: 1200px;
    margin: 0 auto;
  }
  .movie-card {
    position: relative;
    background-color: #222;
    color: white;
    border-radius: 8px;
    overflow: hidden;
    flex: 1 1 calc(25% - 1.5rem); /* 4 cards per row with gap */
    max-width: calc(25% - 1.5rem);
    box-shadow: 0 4px 8px rgba(0,0,0,0.6);
    display: flex;
    flex-direction: column;
  }
  .movie-card img {
    width: 100%;
    height: 300px;
    object-fit: cover;
    display: block;
  }
  .movie-info {
    position: absolute;
    bottom: 0;
    left: 0;
    right: 0;
    padding: 15px;
    background: rgba(0, 0, 0, 0.6);
    display: flex;
    flex-direction: column;
  }
  .movie-info small {
    font-size: 0.85rem;
    margin-bottom: 5px;
  }
  .movie-info h5 {
    margin: 0;
    font-weight: bold;
    font-size: 1.25rem;
  }
  .movie-info h5 a {
    color: white;
    text-decoration: none;
  }
  .movie-info h5 a:hover {
    text-decoration: underline;
  }
  .get-ticket-btn {
    margin-top: 10px;
    align-self: flex-start;
    padding: 5px 10px;
    background-color: white;
    color: black;
    font-weight: 600;
    border: none;
    border-radius: 3px;
    text-decoration: none;
  }
  .get-ticket-btn:hover {
    background-color: #e0e0e0;
  }

  /* Responsive adjustments */
  @media (max-width: 991px) {
    .movie-card {
      flex: 1 1 calc(33.33% - 1.5rem);
      max-width: calc(33.33% - 1.5rem);
    }
  }
  @media (max-width: 767px) {
    .movie-card {
      flex: 1 1 calc(50% - 1.5rem);
      max-width: calc(50% - 1.5rem);
    }
  }
  @media (max-width: 480px) {
    .movie-card {
      flex: 1 1 100%;
      max-width: 100%;
    }
  }

  /* Pagination styles */
  .pagination {
    display: flex;
    justify-content: center;
    padding-left: 0;
    list-style: none;
    margin-top: 2rem;
    gap: 0.5rem;
  }
  .pagination li {
    cursor: pointer;
  }
  .pagination a {
    padding: 6px 12px;
    border: 1px solid #ddd;
    color: #f2711c;
    text-decoration: none;
    border-radius: 4px;
  }
  .pagination .active a {
    background-color: #f2711c;
    color: white;
    border-color: #f2711c;
  }
  .pagination .disabled a {
    color: #6c757d;
    pointer-events: none;
    cursor: default;
  }

  /* Footer Styles */
  footer {
    background-color: #130800;
    color: #cfcfcf;
    padding: 2rem 1rem;
    font-size: 0.9rem;
  }
  footer .footer-container {
    max-width: 1200px;
    margin: 0 auto;
    display: flex;
    flex-wrap: wrap;
    justify-content: space-between;
    gap: 2rem;
  }
  footer .footer-section {
    flex: 1 1 200px;
    min-width: 180px;
  }
  footer .footer-section h3 {
    color: #f2711c;
    margin-bottom: 1rem;
    font-weight: 700;
  }
  footer .footer-section ul {
    list-style: none;
    padding: 0;
    margin: 0;
  }
  footer .footer-section ul li {
    margin-bottom: 0.5rem;
  }
  footer .footer-section ul li a {
    color: #cfcfcf;
    text-decoration: none;
    transition: color 0.3s ease;
  }
  footer .footer-section ul li a:hover {
    color: #f2711c;
  }
  footer .newsletter input[type="email"] {
    padding: 0.5rem;
    width: 100%;
    border: none;
    border-radius: 4px;
    margin-bottom: 0.5rem;
  }
  footer .newsletter input[type="checkbox"] {
    margin-right: 0.5rem;
  }
  footer .btn-get-ticket {
    background-color: #f2711c;
    border: none;
    padding: 0.6rem 1rem;
    color: white;
    font-weight: 600;
    cursor: pointer;
    border-radius: 4px;
  }
  footer .btn-get-ticket:hover {
    background-color: #d35e00;
  }
  footer .footer-bottom {
    text-align: center;
    padding-top: 1rem;
    border-top: 1px solid #3c1f00;
    font-size: 0.8rem;
  }
  footer .social-icons {
    margin-top: 1rem;
  }
  footer .social-icons a {
    color: #cfcfcf;
    margin-right: 0.8rem;
    font-size: 1.2rem;
    text-decoration: none;
    transition: color 0.3s ease;
  }
  footer .social-icons a:hover {
    color: #f2711c;
  }

  /* Responsive footer */
  @media (max-width: 768px) {
    footer .footer-container {
      flex-direction: column;
      align-items: flex-start;
    }
  }
</style>

<!-- Add fontawesome CDN for social icons -->
<link
  rel="stylesheet"
  href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
/>

<body>

<!-- Navbar -->
<nav class="navbar">
  <a href="/" class="logo">CineApp</a>
  <ul>
    <li><a href="index.jsp" >Home</a></li>
    <li>
      <a href="#" class="active">Movies</a>
    </li>
    <li><a href="contact.jsp" >Contact Us</a></li>
  </ul>
  <div class="navbar-icons">
    <a href="/search"><i class="fas fa-search"></i></a>
    <a href="/user"><i class="fas fa-user"></i></a>
  </div>
</nav>

<!-- Page Content -->
<h1 class="mb-4" style="text-align:center; margin-top:2rem;">Movies</h1>

<div class="movies-row">
<%
    List<Movie> movies = (List<Movie>) request.getAttribute("movies");
    if (movies != null && !movies.isEmpty()) {
        for (Movie m : movies) {
%>
    <div class="movie-card">
      <img src="<%= (m.getPosterImage() != null && !m.getPosterImage().isEmpty()) ? "images/" + m.getPosterImage() : "images/placeholder.jpg" %>"
           alt="<%= m.getTitle() %> poster" />
      <div class="movie-info">
        <small><%= m.getDuration() %> Mins</small>
        <h5><a href="movies?action=details&id=<%= m.getMovieId() %>"><%= m.getTitle() %></a></h5>
        <a href="movies?action=details&id=<%= m.getMovieId() %>" class="get-ticket-btn">Get Ticket</a>
        </div>
    </div>
<%
        }
    } else {
%>
    <p style="color:#000; text-align:center;">No movies found.</p>
<%
    }
%>
</div>

<nav aria-label="Page navigation">
  <ul class="pagination">
    <li class="page-item disabled"><a class="page-link" href="#" tabindex="-1">&laquo;</a></li>
    <li class="page-item active"><a class="page-link" href="#">1</a></li>
    <li class="page-item"><a class="page-link" href="#">2</a></li>
    <li class="page-item"><a class="page-link" href="#">3</a></li>
    <li class="page-item"><a class="page-link" href="#">&raquo;</a></li>
  </ul>
</nav>

<script>
  // Sort movie cards by release date ascending
  document.addEventListener("DOMContentLoaded", () => {
    const container = document.querySelector('.movies-row');
    if (!container) return;

    // Get all movie cards as an array
    const cards = Array.from(container.children);

    // Extract release date from a data attribute (we'll add this attribute next)
    cards.sort((a, b) => {
      const dateA = a.getAttribute('data-release-date');
      const dateB = b.getAttribute('data-release-date');
      return dateA.localeCompare(dateB);
    });

    // Clear current cards
    container.innerHTML = '';

    // Append sorted cards
    cards.forEach(card => container.appendChild(card));
  });
</script>


<!-- Footer -->
<footer>
  <div class="footer-container">
    <div class="footer-section">
      <h3>CineApp</h3>
      <p>Buy movie tickets easily</p>
      <button class="btn-get-ticket">Get Your Ticket</button>
    </div>
    <div class="footer-section">
      <h3>Links</h3>
      <ul>
        <li><a href="${pageContext.request.contextPath}/index.jsp">Home</a></li>
        <li><a href="${pageContext.request.contextPath}/index.jsp">Dashboard</a></li>
        <li><a href="${pageContext.request.contextPath}/user">My account</a></li>
        <li><a href="${pageContext.request.contextPath}/user">User</a></li>
        <li><a href="${pageContext.request.contextPath}/contact">Contact Us</a></li>
        <li><a href="${pageContext.request.contextPath}/movies">New Movies</a></li>
      </ul>
    </div>
    <div class="footer-section newsletter">
      <h3>Links</h3>
            <ul>
              <li><a href="${pageContext.request.contextPath}/movies">Movies</a></li>
              <li><a href="${pageContext.request.contextPath}/user">Profile</a></li>
            </ul>
    </div>
  </div>
  <div class="footer-bottom">
       © 2025 CineApp. All Rights Reserved | Design by  <a href="#" target="_blank" style="color:#f2711c; text-decoration:none;">PGNO 225</a>
    </div>
</footer>

</body>
</html>
