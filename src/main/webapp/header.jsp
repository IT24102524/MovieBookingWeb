<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title><c:out value="${pageTitle != null ? pageTitle : 'Movie Ticket App'}" /></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body class="d-flex flex-column min-vh-100">

<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
  <div class="container-fluid">
    <a class="navbar-brand" href="${pageContext.request.contextPath}/index.jsp">MovieTicketApp</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
        aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">

      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <c:choose>
          <c:when test="${not empty sessionScope.currentUser}">
            <!-- Show after login -->
            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/movies">Movies</a></li>
            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/showtimes">Showtimes</a></li>
            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/seats">Seats</a></li>
            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/users">Users</a></li>
            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/reviews">Reviews</a></li>
            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/bookings">Bookings</a></li>
          </c:when>
          <c:otherwise>
            <!-- Before login -->
            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/index.jsp">Home</a></li>
            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/login.jsp">Login</a></li>
            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/users?action=registerForm">Register</a></li>
          </c:otherwise>
        </c:choose>
      </ul>

      <c:if test="${not empty sessionScope.currentUser}">
        <ul class="navbar-nav">
          <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/logout">Logout</a>
          </li>
        </ul>
      </c:if>

    </div>
  </div>
</nav>

<div class="container my-4">
