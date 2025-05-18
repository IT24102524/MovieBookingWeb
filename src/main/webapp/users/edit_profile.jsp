<%@ page import="main.java.com.movieticket.model.User" %>
<%
    User user = (User) request.getAttribute("user");
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>Edit Profile</title>

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

  /* Form container */
  .edit-profile-container {
    max-width: 500px;
    background: #f9f9f9;
    margin: 50px auto 80px;
    padding: 30px 40px;
    border-radius: 10px;
    box-shadow: 0 0 25px rgba(0,0,0,0.1);
  }
  .edit-profile-container h1 {
    font-weight: 900;
    font-size: 2.5rem;
    margin-bottom: 30px;
    color: #130800;
    text-align: center;
  }

  /* Form styles */
  form label {
    font-weight: 600;
    color: #130800;
  }
  form input[type="text"],
  form input[type="email"],
  form input[type="password"] {
    width: 100%;
    padding: 10px 12px;
    margin-top: 6px;
    margin-bottom: 15px;
    border: 1px solid #ccc;
    border-radius: 6px;
    font-size: 1rem;
    transition: border-color 0.3s ease;
  }
  form input[type="text"]:focus,
  form input[type="email"]:focus,
  form input[type="password"]:focus {
    border-color: #f2711c;
    outline: none;
  }
  .form-text {
    font-size: 0.9rem;
    color: #666;
    margin-top: -12px;
    margin-bottom: 15px;
  }
  .btn-submit {
    background-color: #f2711c;
    color: white;
    border: none;
    padding: 14px 0;
    width: 100%;
    font-weight: 700;
    border-radius: 6px;
    cursor: pointer;
    font-size: 1.1rem;
    transition: background-color 0.3s ease;
  }
  .btn-submit:hover {
    background-color: #d35e00;
  }
  .btn-cancel {
    display: inline-block;
    margin-top: 15px;
    color: #130800;
    text-decoration: none;
    font-weight: 600;
    text-align: center;
  }
  .btn-cancel:hover {
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

<!-- FontAwesome CDN -->
<link
  rel="stylesheet"
  href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
/>

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

<!-- Edit Profile Form -->
<div class="edit-profile-container">
  <h1>Edit Profile</h1>
  <form action="${pageContext.request.contextPath}/users" method="post" class="needs-validation" novalidate>
      <input type="hidden" name="action" value="update" />

      <label for="userId">User ID</label>
      <input id="userId" name="userId" type="text" value="<%= user.getUserId() %>" readonly />

      <label for="name">Name</label>
      <input id="name" name="name" type="text" value="<%= user.getName() %>" required />
      <div class="invalid-feedback">Please enter Name.</div>

      <label for="email">Email</label>
      <input id="email" name="email" type="email" value="<%= user.getEmail() %>" required />
      <div class="invalid-feedback">Please enter Email.</div>

      <label for="password">Password</label>
      <input id="password" name="password" type="password" placeholder="Enter new password to change" />
      <div class="form-text">Leave blank to keep current password.</div>

      <label for="role">Role</label>
      <input id="role" name="role" type="text" value="<%= user.getRole() %>" readonly />

      <button type="submit" class="btn-submit">Update Profile</button>
  </form>
  <a href="${pageContext.request.contextPath}/users/profile.jsp" class="btn-cancel">Cancel</a>
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

<script>
  (() => {
    'use strict';
    const forms = document.querySelectorAll('.needs-validation');
    Array.from(forms).forEach(form => {
      form.addEventListener('submit', e => {
        if (!form.checkValidity()) {
          e.preventDefault();
          e.stopPropagation();
        }
        form.classList.add('was-validated');
      }, false);
    });
  })();
</script>

</body>
</html>
