<%@ page import="java.util.List" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    String movieId = (String) request.getAttribute("movieId");
    String showDate = (String) request.getAttribute("showDate");
    String showtime = (String) request.getAttribute("showtime");
    Integer maxSelection = (Integer) request.getAttribute("seats");
    if (maxSelection == null) maxSelection = 1;

    List<String> reservedSeats = (List<String>) request.getAttribute("reservedSeats");
    if (reservedSeats == null) reservedSeats = new java.util.ArrayList<>();
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>Select Seats</title>

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
    margin: 50px auto 80px;
    background: #f9f9f9;
    padding: 30px 40px;
    border-radius: 10px;
    box-shadow: 0 0 25px rgba(0,0,0,0.1);
    text-align: center;
  }
  h2 {
    font-weight: 900;
    font-size: 2rem;
    color: #130800;
    margin-bottom: 25px;
  }
  p {
    font-weight: 600;
    color: #333;
    margin: 5px 0;
  }

  /* Seat Map */
  #seat-map {
    max-width: 350px;
    margin: 25px auto 15px;
  }
  .seat-row {
    text-align: center;
    margin-bottom: 12px;
  }
  .seat {
    display: inline-block;
    width: 36px;
    height: 36px;
    margin: 5px 6px;
    border: 2px solid #444;
    border-radius: 6px;
    line-height: 36px;
    cursor: pointer;
    font-weight: 600;
    user-select: none;
    background-color: white;
    color: black;
    transition: background-color 0.3s ease, color 0.3s ease;
  }
  .seat.available:hover {
    background-color: #f2711c;
    color: white;
  }
  .seat.selected {
    background-color: #007bff;
    border-color: #007bff;
    color: white;
  }
  .seat.reserved, .seat.disabled {
    background-color: #dc3545;
    border-color: #dc3545;
    color: white;
    cursor: not-allowed;
    opacity: 0.7;
  }

  /* Screen label */
  #screen {
    font-weight: bold;
    color: #130800;
    font-size: 1.1rem;
    margin-top: 30px;
  }

  /* Legend */
  #legend {
    display: flex;
    justify-content: center;
    gap: 25px;
    margin-bottom: 25px;
    font-weight: 600;
    color: #333;
  }
  #legend div {
    display: flex;
    align-items: center;
    gap: 6px;
  }
  #legend div div {
    width: 22px;
    height: 22px;
    border-radius: 4px;
    border: 1px solid #444;
  }
  #legend .selected { background-color: #007bff; border-color: #007bff; }
  #legend .available { background-color: white; }
  #legend .reserved { background-color: #dc3545; border-color: #dc3545; }
  #legend .unavailable { background-color: pink; }

  /* Selection info */
  #selection-info {
    font-weight: 700;
    margin-bottom: 20px;
    color: #130800;
  }

  /* Button */
  button.btn-success {
    background-color: #f2711c;
    border: none;
    padding: 14px 0;
    width: 100%;
    font-weight: 700;
    border-radius: 6px;
    color: white;
    cursor: pointer;
    font-size: 1.1rem;
    transition: background-color 0.3s ease;
  }
  button.btn-success:hover {
    background-color: #d35e00;
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

<!-- FontAwesome -->
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

<!-- Seat Selection -->
<div class="container">
  <h2>Select Your Seats</h2>
  <p><strong>Movie ID:</strong> <%= movieId %></p>
  <p><strong>Date:</strong> <%= showDate %></p>
  <p><strong>Showtime:</strong> <%= showtime %></p>
  <p><strong>Number of Seats to Select:</strong> <%= maxSelection %></p>

  <form action="${pageContext.request.contextPath}/bookings" method="post" novalidate>
    <input type="hidden" name="action" value="confirmSeats" />
    <input type="hidden" name="movieId" value="<%= movieId %>" />
    <input type="hidden" name="showDate" value="<%= showDate %>" />
    <input type="hidden" name="showtime" value="<%= showtime %>" />
    <input type="hidden" name="seats" value="<%= maxSelection %>" />
    <input type="hidden" name="selectedSeats" id="selectedSeats" />

    <div id="seat-map">
      <!-- Example Row J -->
      <div class="seat-row" data-row="J">
        <% for (int i = 1; i <= 5; i++) {
             String seatId = "J" + i;
             String seatClass = reservedSeats.contains(seatId) ? "reserved disabled" : "available";
        %>
          <div class="seat <%= seatClass %>" data-seat="<%= seatId %>"><%= seatId %></div>
        <% } %>
      </div>
      <!-- Example Row I -->
      <div class="seat-row" data-row="I">
        <% for (int i = 1; i <= 5; i++) {
             String seatId = "I" + i;
             String seatClass = reservedSeats.contains(seatId) ? "reserved disabled" : "available";
        %>
          <div class="seat <%= seatClass %>" data-seat="<%= seatId %>"><%= seatId %></div>
        <% } %>
      </div>
      <!-- Add more rows as needed -->
    </div>

    <div id="screen">SCREEN</div>

    <div id="legend">
      <div><div class="selected"></div>Selected</div>
      <div><div class="available"></div>Available</div>
      <div><div class="reserved"></div>Reserved</div>
      <div><div class="unavailable"></div>Unavailable</div>
    </div>

    <div id="selection-info">0 ticket(s) selected. Please select attendees.</div>

    <button type="submit" class="btn btn-success">Confirm Seats & Book</button>
  </form>
</div>

<script>
  const maxSelection = <%= maxSelection %>;
  let selectedSeats = [];

  document.querySelectorAll('.seat.available').forEach(seat => {
    seat.addEventListener('click', () => {
      const seatId = seat.getAttribute('data-seat');

      if (selectedSeats.includes(seatId)) {
        selectedSeats = selectedSeats.filter(s => s !== seatId);
        seat.classList.remove('selected');
      } else {
        if (selectedSeats.length >= maxSelection) {
          alert('You can select a maximum of ' + maxSelection + ' seats.');
          return;
        }
        selectedSeats.push(seatId);
        seat.classList.add('selected');
      }

      updateSelectionInfo();
    });
  });

  function updateSelectionInfo() {
    document.getElementById('selection-info').textContent =
      selectedSeats.length + ' ticket(s) selected. Please select attendees.';
  }

  const form = document.querySelector('form');
  form.addEventListener('submit', (e) => {
    if (selectedSeats.length !== maxSelection) {
      e.preventDefault();
      alert(`Please select exactly ${maxSelection} seat(s).`);
      return false;
    }
    document.getElementById('selectedSeats').value = selectedSeats.join(',');
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
