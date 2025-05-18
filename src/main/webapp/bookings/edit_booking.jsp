<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>Edit Booking</title>

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
    max-width: 480px;
    margin: 60px auto 80px;
    background: #f9f9f9;
    padding: 30px 40px;
    border-radius: 10px;
    box-shadow: 0 0 25px rgba(0,0,0,0.1);
  }

  h2 {
    font-weight: 900;
    font-size: 2rem;
    color: #130800;
    margin-bottom: 30px;
    text-align: center;
  }

  form label {
    display: block;
    margin-bottom: 15px;
    font-weight: 600;
    color: #130800;
  }

  form input[type="text"],
  form input[type="date"],
  form input[type="number"] {
    width: 100%;
    padding: 10px 12px;
    margin-top: 6px;
    border: 1.5px solid #ccc;
    border-radius: 6px;
    font-size: 1rem;
    transition: border-color 0.3s ease;
  }
  form input[type="text"]:focus,
  form input[type="date"]:focus,
  form input[type="number"]:focus {
    outline: none;
    border-color: #f2711c;
  }

  form button {
    background-color: #f2711c;
    color: white;
    font-weight: 700;
    font-size: 1.1rem;
    padding: 14px 0;
    border: none;
    border-radius: 8px;
    width: 100%;
    cursor: pointer;
    transition: background-color 0.3s ease;
    margin-top: 20px;
  }
  form button:hover {
    background-color: #d35e00;
  }

  .btn-cancel {
    display: block;
    margin: 15px auto 0;
    text-align: center;
    font-weight: 600;
    color: #f2711c;
    text-decoration: none;
    font-size: 1rem;
  }
  .btn-cancel:hover {
    text-decoration: underline;
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
    <li><a href="${pageContext.request.contextPath}/">Home</a></li>
    
    <li class="nav-item">
               <a class="nav-link" aria-current="page" href="${pageContext.request.contextPath}/movies">Movies</a>
    </li>
    
    
    <li><a href="${pageContext.request.contextPath}/contact">Contact Us</a></li>
  </ul>
  <div class="navbar-icons">
    <a href="${pageContext.request.contextPath}/search"><i class="fas fa-search"></i></a>
    <a href="${pageContext.request.contextPath}/user"><i class="fas fa-user"></i></a>
  </div>
</nav>

<!-- Content -->
<div class="container">
  <h2>Edit Booking</h2>

  <form action="${pageContext.request.contextPath}/bookings" method="post">
    <input type="hidden" name="action" value="updateBooking" />
    <input type="hidden" name="bookingId" value="${booking.bookingId}" />

    <label for="movieId">Movie ID:
      <input type="text" id="movieId" name="movieId" value="${booking.movieId}" required />
    </label>

    <label for="showDate">Show Date:
      <input type="date" id="showDate" name="showDate" value="${booking.showDate}" required />
    </label>

    <label for="showtime">Showtime:
      <input type="text" id="showtime" name="showtime" value="${booking.showtime}" required />
    </label>

    <label for="seats">Seats:
      <input type="text" id="seats" name="seats" value="${booking.seats}" required />
    </label>

    <label for="foodItems">Food Items:
      <input type="text" id="foodItems" name="foodItems" value="${booking.foodItems}" />
    </label>

    <label for="totalPrice">Total Price:
      <input type="number" step="0.01" id="totalPrice" name="totalPrice" value="${booking.totalPrice}" required />
    </label>

    <button type="submit">Update Booking</button>
    <a href="${pageContext.request.contextPath}/bookings" class="btn-cancel">Cancel</a>
  </form>
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
