<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>Reviews</title>

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

  /* Reviews container */
  .reviews-container {
    max-width: 700px;
    margin: 40px auto 80px;
    padding: 0 20px;
  }
  h2 {
    text-align: center;
    font-weight: 900;
    font-size: 2.5rem;
    margin-bottom: 30px;
    color: #130800;
  }
  .alert-danger {
    background-color: #f8d7da;
    color: #842029;
    border-radius: 6px;
    padding: 15px;
    margin-bottom: 25px;
    text-align: center;
  }

  /* Review list styles */
  .review-list {
    list-style: none;
    padding: 0;
    margin-bottom: 40px;
  }
  .review-item {
    border-bottom: 1px solid #ddd;
    padding: 15px 0;
  }
  .review-item:last-child {
    border-bottom: none;
  }
  .review-item strong {
    color: #f2711c;
    font-weight: 700;
  }
  .rating {
    color: #ff9900;
    font-weight: 700;
    margin-left: 8px;
  }
  .review-comment {
    margin-top: 8px;
    font-size: 1rem;
    color: #333;
  }

  /* Review form */
  form {
    background: #f9f9f9;
    padding: 25px 30px;
    border-radius: 10px;
    box-shadow: 0 0 25px rgba(0,0,0,0.1);
  }
  form label {
    font-weight: 600;
    color: #130800;
    display: block;
    margin-bottom: 8px;
  }
  select, textarea {
    width: 100%;
    padding: 10px 12px;
    margin-bottom: 20px;
    border-radius: 6px;
    border: 1px solid #ccc;
    font-size: 1rem;
    resize: vertical;
    transition: border-color 0.3s ease;
  }
  select:focus, textarea:focus {
    outline: none;
    border-color: #f2711c;
  }
  button.btn-primary {
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
  button.btn-primary:hover {
    background-color: #d35e00;
  }
  p.login-prompt {
    text-align: center;
    font-size: 1rem;
    margin-top: 25px;
  }
  p.login-prompt a {
    color: #f2711c;
    font-weight: 700;
    text-decoration: none;
  }
  p.login-prompt a:hover {
    text-decoration: underline;
  }

  /* Footer Styles matching Movie Theme */
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
    <li><a href="${pageContext.request.contextPath}/" >Home</a></li>
    
    <li class="nav-item">
               <a class="nav-link" aria-current="page" href="${pageContext.request.contextPath}/movies">Movies</a>
    </li>
    
    
    <li><a href="${pageContext.request.contextPath}/contact" >Contact Us</a></li>
  </ul>
  <div class="navbar-icons">
    <a href="${pageContext.request.contextPath}/search"><i class="fas fa-search"></i></a>
    <a href="${pageContext.request.contextPath}/user"><i class="fas fa-user"></i></a>
  </div>
</nav>

<div class="reviews-container">
  <h2>Reviews</h2>

  <c:if test="${not empty error}">
    <div class="alert alert-danger">${error}</div>
  </c:if>

  <c:if test="${empty reviews}">
    <p>No reviews yet. Be the first to review!</p>
  </c:if>

  <c:if test="${not empty reviews}">
    <ul class="review-list">
      <c:forEach var="review" items="${reviews}">
        <li class="review-item">
          <strong>${review.username}</strong> -
          <span class="rating">${review.rating} / 5</span>
          <p class="review-comment">${review.comment}</p>
        </li>
      </c:forEach>
    </ul>
  </c:if>

  <c:if test="${sessionScope.currentUser != null}">
    <h3>Add a Review</h3>
    <form action="${pageContext.request.contextPath}/reviews" method="post" novalidate>
      <input type="hidden" name="action" value="add" />
      <input type="hidden" name="movieId" value="${movieId}" />
      <label for="rating">Rating:</label>
      <select name="rating" id="rating" required>
        <option value="">-- Select Rating --</option>
        <option value="5">5 - Excellent</option>
        <option value="4">4 - Very good</option>
        <option value="3">3 - Good</option>
        <option value="2">2 - Fair</option>
        <option value="1">1 - Poor</option>
      </select>
      <label for="comment">Comment:</label><br>
      <textarea name="comment" id="comment" rows="4" cols="50" required></textarea>
      <button type="submit" class="btn btn-primary">Submit Review</button>
    </form>
  </c:if>

  <c:if test="${sessionScope.currentUser == null}">
    <p class="login-prompt"><a href="${pageContext.request.contextPath}/login.jsp">Log in</a> to add a review.</p>
  </c:if>
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
