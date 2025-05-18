<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>Manage Movies</title>

<style>
  /* Navbar Styles matching Movie Theme */
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

  /* Container */
  .container {
    max-width: 960px;
    margin: 50px auto 80px;
    padding: 0 20px;
  }

  h2 {
    font-weight: 900;
    font-size: 2.5rem;
    color: #130800;
    margin-bottom: 30px;
    text-align: center;
  }

  /* Add Movie Button */
  .btn-add-movie {
    background-color: #f2711c;
    color: white;
    padding: 12px 24px;
    font-weight: 700;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    font-size: 1rem;
    margin-bottom: 20px;
    display: inline-block;
    transition: background-color 0.3s ease;
    text-decoration: none;
  }
  .btn-add-movie:hover {
    background-color: #d35e00;
  }

  /* Table Styles */
  table {
    width: 100%;
    border-collapse: collapse;
    font-size: 1rem;
  }
  thead {
    background-color: #130800;
    color: #f2711c;
  }
  thead th {
    padding: 12px 15px;
    font-weight: 700;
    text-align: left;
  }
  tbody tr:nth-child(even) {
    background-color: #f9f9f9;
  }
  tbody td {
    padding: 12px 15px;
    border-bottom: 1px solid #ddd;
    color: #130800;
  }

  /* Action buttons */
  .btn-primary, .btn-danger {
    padding: 6px 14px;
    font-weight: 600;
    border-radius: 5px;
    border: none;
    cursor: pointer;
    font-size: 0.9rem;
    text-decoration: none;
    color: white;
    display: inline-block;
    transition: background-color 0.3s ease;
  }
  .btn-primary {
    background-color: #f2711c;
  }
  .btn-primary:hover {
    background-color: #d35e00;
  }
  .btn-danger {
    background-color: #b55406;
    margin-left: 8px;
  }
  .btn-danger:hover {
    background-color: #933e02;
  }

  /* No movies message */
  .no-movies {
    text-align: center;
    padding: 40px 0;
    font-weight: 600;
    color: #555;
  }

  /* Responsive */
  @media (max-width: 768px) {
    table, thead, tbody, th, td, tr {
      display: block;
    }
    thead tr {
      display: none;
    }
    tbody tr {
      margin-bottom: 1rem;
      border-bottom: 2px solid #f2711c;
      padding-bottom: 10px;
    }
    tbody td {
      padding-left: 50%;
      position: relative;
      text-align: left;
      border: none;
      border-bottom: 1px solid #ddd;
    }
    tbody td::before {
      position: absolute;
      top: 12px;
      left: 15px;
      width: 45%;
      white-space: nowrap;
      font-weight: 700;
      color: #f2711c;
      content: attr(data-label);
    }
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
  footer.footer-bottom {
    text-align: center;
    padding-top: 1rem;
    border-top: 1px solid #3c1f00;
    font-size: 0.8rem;
    background-color: #fff; /* Optional */
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
  @media (max-width: 768px) {
    footer .footer-container {
      flex-direction: column;
      align-items: flex-start;
    }
  }
</style>

<!-- FontAwesome for icons -->
<link
  rel="stylesheet"
  href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
/>

</head>
<body>

<!-- Navbar -->
<nav class="navbar">
  <a href="${pageContext.request.contextPath}/" class="logo">CineApp</a>
  <ul>
    <li><a href="${pageContext.request.contextPath}/" >Home</a></li>

    <li class="nav-item">
                   <a class="nav-link" aria-current="page" href="${pageContext.request.contextPath}/admin/dashboard.jsp">Dashboard</a>
        </li>

    <li class="nav-item">
               <a class="nav-link" aria-current="page" href="${pageContext.request.contextPath}/movies">Movies</a>
    </li>
    
    
    <li><a href="${pageContext.request.contextPath}/contact.jsp" >Contact Us</a></li>
  </ul>
  <div class="navbar-icons">
    <a href="${pageContext.request.contextPath}/search"><i class="fas fa-search"></i></a>
    <a href="<c:url value='/users' />"><i class="fas fa-user"></i></a>
  </div>
</nav>

<!-- Page Content -->
<div class="container">
  <h2>Manage Movies</h2>

  <a href="movies?action=createForm" class="btn-add-movie">Add New Movie</a>

  <c:choose>
    <c:when test="${not empty movies}">
      <table>
        <thead>
          <tr>
            <th>Movie ID</th>
            <th>Title</th>
            <th>Duration (mins)</th>
            <th>Release Date</th>
            <th>Available Seats</th>
            <th>Price (USD)</th>
            <th>Actions</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="movie" items="${movies}">
            <tr>
              <td data-label="Movie ID">${movie.movieId}</td>
              <td data-label="Title">${movie.title}</td>
              <td data-label="Duration">${movie.duration}</td>
              <td data-label="Release Date">${movie.releaseDate}</td>
              <td data-label="Available Seats">${movie.availableSeats}</td>
              <td data-label="Price">${movie.price}</td>
              <td data-label="Actions">
                <a href="movies?action=editForm&id=${movie.movieId}" class="btn-primary">Edit</a>
                <a href="movies?action=deleteConfirm&id=${movie.movieId}" class="btn-danger" onclick="return confirm('Are you sure you want to delete this movie?');">Delete</a>
              </td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </c:when>
    <c:otherwise>
      <div class="no-movies">No movies found.</div>
    </c:otherwise>
  </c:choose>
</div>

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
