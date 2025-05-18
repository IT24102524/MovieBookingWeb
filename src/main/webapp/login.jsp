<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    if (session != null && session.getAttribute("currentUser") != null) {
        response.sendRedirect(request.getContextPath() + "/users/profile.jsp");
        return;
    }
%>

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

  /* Login container */
  .login-container {
    max-width: 400px;
    height: 57%;
    margin: 50px auto 80px;
    background: #f9f9f9;
    padding: 30px 40px;
    border-radius: 8px;
    box-shadow: 0 0 30px rgb(0 0 0 / 0.1);
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
  }
  .login-title {
    font-weight: 900;
    font-size: 2.5rem;
    margin-bottom: 10px;
  }
  .breadcrumb {
    font-weight: 600;
    color: #b55406;
    margin-bottom: 1rem;
  }
  .breadcrumb a {
    color: #b55406;
    text-decoration: none;
  }
  .breadcrumb a:hover {
    text-decoration: underline;
  }
  .alert {
    background-color: #f8d7da;
    color: #842029;
    padding: 0.75rem 1rem;
    border-radius: 4px;
    margin-bottom: 1rem;
    text-align: center;
    font-weight: 600;
  }
  form label {
    font-weight: 600;
    display: block;
    margin-bottom: 0.3rem;
    margin-top: 1rem;
  }
  form input[type="text"],
  form input[type="password"] {
    width: 100%;
    padding: 8px 10px;
    border: 1px solid #ccc;
    border-radius: 4px;
    font-size: 1rem;
    box-sizing: border-box;
  }
  .invalid-feedback {
    color: #b55406;
    font-size: 0.9rem;
    margin-top: 0.3rem;
    display: none;
  }
  .was-validated input:invalid + .invalid-feedback {
    display: block;
  }
  .form-check {
    display: flex;
    align-items: center;
    margin-top: 1rem;
  }
  .form-check input[type="checkbox"] {
    margin-right: 0.5rem;
  }
  .forgot-password {
    margin-left: auto;
    font-size: 0.9rem;
    color: #b55406;
    text-decoration: none;
    cursor: pointer;
  }
  .forgot-password:hover {
    text-decoration: underline;
  }
  .btn-login {
    background-color: #b55406;
    border: none;
    font-weight: 700;
    padding: 12px;
    width: 100%;
    margin-top: 1.5rem;
    color: #fff;
    cursor: pointer;
    border-radius: 4px;
    font-size: 1.1rem;
    transition: background-color 0.3s ease;
  }
  .btn-login:hover {
    background-color: #933e02;
  }
  .text-center.mt-4 {
    margin-top: 1.5rem;
    font-size: 1rem;
  }
  .register-link {
    font-weight: 700;
    color: #b55406;
    text-decoration: none;
  }
  .register-link:hover {
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

<!-- Login Form -->
<div class="login-container">
  <div class="text-center mb-4">
    <h1 class="login-title">Login</h1>
  </div>

  <c:if test="${param.error == 'true'}">
    <div class="alert" role="alert">
      Invalid username or password. Please try again.
    </div>
  </c:if>

  <form action="${pageContext.request.contextPath}/login" method="post" novalidate>
    <label for="username">Username</label>
    <input
      type="text"
      id="username"
      name="username"
      placeholder="Username"
      required
    />
    <div class="invalid-feedback">Please enter your username.</div>

    <label for="password">Password</label>
    <input
      type="password"
      id="password"
      name="password"
      placeholder="Password"
      required
    />
    <div class="invalid-feedback">Please enter your password.</div>

    <div class="form-check">
      <input type="checkbox" id="rememberMe" name="rememberMe" />
      <label for="rememberMe">Remember Me</label>
      <a href="#" class="forgot-password">Forgot Password?</a>
    </div>

    <button type="submit" class="btn-login">LOGIN</button>
  </form>

  <p class="text-center mt-4">
    Don't have an account?
    <a
      href="${pageContext.request.contextPath}/users?action=registerForm"
      class="register-link"
      >Create One</a
    >
  </p>
</div>

<!-- Footer -->
<footer>
  <div class="footer-bottom">
     © 2025 CineApp. All Rights Reserved | Design by  <a href="#" target="_blank" style="color:#f2711c; text-decoration:none;">PGNO 225</a>
  </div>
</footer>

<script>
  (() => {
    'use strict';
    const form = document.querySelector('form');
    form.addEventListener('submit', e => {
      if (!form.checkValidity()) {
        e.preventDefault();
        e.stopPropagation();
      }
      form.classList.add('was-validated');
    }, false);
  })();
</script>
