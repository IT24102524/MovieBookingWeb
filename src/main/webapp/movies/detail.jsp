<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="main.java.com.movieticket.model.Movie" %>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Movie Theme</title>
	<link href="css/bootstrap.min.css" rel="stylesheet" >
	<link href="css/font-awesome.min.css" rel="stylesheet" >
	<link href="css/global.css" rel="stylesheet">
	<link href="css/list.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Platypi:ital,wght@0,300..800;1,300..800&display=swap" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script src="js/bootstrap.bundle.min.js"></script>

</head>
<body>

<%
    Movie movie = (Movie) request.getAttribute("movie");
    if (movie == null) {
%>
    <p>Movie not found.</p>
<%
    } else {
%>


<div class="main_o main">
 <div class="main_o1 bg_back">
   <section id="header">
<nav class="navbar navbar-expand-md navbar-light px_4" id="navbar_sticky">
  <div class="container-fluid">
    <a class="navbar-brand  p-0 fw-bold text-white" href="index.html"><i class="fa fa-modx col_oran"></i> CineApp </a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
	   <ul class="navbar-nav mb-0 ms-auto">
	    
        <li class="nav-item">
          <a class="nav-link" aria-current="page" href="index.html">Home</a>
        </li>
		 
		<li class="nav-item">
          <a class="nav-link" href="about.html">About Us</a>
        </li>
		
		<li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle active" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            Movies
          </a>
          <ul class="dropdown-menu drop_1" aria-labelledby="navbarDropdown">
            <li><a class="dropdown-item" href="movies.html"><i class="fa fa-chevron-right font_12 me-1"></i> Movies</a></li>
            <li><a class="dropdown-item border-0" href="detail.jsp"><i class="fa fa-chevron-right font_12 me-1"></i> Movie Details</a></li>
          </ul>
        </li>
		
		<li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            Blogs
          </a>
          <ul class="dropdown-menu drop_1" aria-labelledby="navbarDropdown">
            <li><a class="dropdown-item" href="blog.html"><i class="fa fa-chevron-right font_12 me-1"></i> Blogs</a></li>
            <li><a class="dropdown-item border-0" href="blog_detail.html"><i class="fa fa-chevron-right font_12 me-1"></i> Blog Details</a></li>
          </ul>
        </li>
		
		<li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            Pages
          </a>
          <ul class="dropdown-menu drop_1" aria-labelledby="navbarDropdown">
		    <li><a class="dropdown-item" href="faq.html"><i class="fa fa-chevron-right font_12 me-1"></i> Faqs</a></li>
            <li><a class="dropdown-item" href="login.html"><i class="fa fa-chevron-right font_12 me-1"></i> Login</a></li>
            <li><a class="dropdown-item" href="register.html"><i class="fa fa-chevron-right font_12 me-1"></i> Register</a></li>
			<li><a class="dropdown-item border-0" href="ticket.html"><i class="fa fa-chevron-right font_12 me-1"></i> Ticket</a></li>
          </ul>
        </li>
			
		<li class="nav-item">
          <a class="nav-link" href="contact.html">Contact Us</a>
        </li>
      </ul>
      <ul class="navbar-nav mb-0 ms-auto">
	       <li class="nav-item">
          <a class="nav-link fs-5 drop_icon" data-bs-target="#exampleModal2" data-bs-toggle="modal" href="#"><i class="fa fa-search"></i></a>
        </li>
		    <li class="nav-item">
          <a class="nav-link fs-5 drop_icon" href="#"><i class="fa fa-user"></i></a>
        </li>
      </ul>
    </div>
  </div>
</nav>
</section>
   <section id="center" class="centre_o  pt-5 pb-5">
 <div class="container-xl">
  <div class="row centre_o1 text-center">
    <div class="col-md-12">
      <h1 class="text-white font_60">Movie Details</h1>
	  <h5 class="mb-0 mt-3 fw-normal col_oran"><a class="text-light" href="#">Home</a> <span class="mx-2 text-muted">/</span> Movie Details</h5>
   </div>
  </div>
 </div>
</section>
 </div>
</div>

<div class="border_dashed">

</div>

<%
    }
%>

<section id="detail" class="p_3">
 <div class="container-xl">
    <div class="detail_1 row">
	  <div class="col-md-6">
	    <div class="detail_1l">
		  <h2><%= movie.getTitle() %></h2>
		  <h6 class="mb-0 text-muted">Thriller / <%= movie.getDuration() %> Minutes</h6>
		</div>
	  </div>
	  <div class="col-md-6">
	    <div class="detail_1r text-end">
		  <h6 class="mb-0"><a class="button_2" href="movies?action=book&id=${movie.movieId}">Get Ticket</a></h6>
		  <h6 class="mt-2"><a class="button_2" href="${pageContext.request.contextPath}/reviews?movieId=${movie.movieId}">Add a Review</a></h6>


		</div>
	  </div>
	</div>
	<div class="detail_2 row mt-4">
	  <div class="col-md-4">
	    <div class="detail_2l">
	      <div class="grid clearfix">
				  <figure class="effect-jazz mb-0">
				  <a href="#">
                    <img src="<%= (movie.getPosterImage() != null && !movie.getPosterImage().isEmpty()) ? "images/" + movie.getPosterImage() : "images/placeholder.jpg" %>" height="530" class="w-100" alt="<%= movie.getTitle() %> poster" />
                  </a>
				  </figure>
			  </div>
		</div>
	  </div>
	  <div class="col-md-8">
	    <div class="detail_2r  position-relative">
	       <div class="detail_2l">
             <div class="grid clearfix">
               <figure class="effect-jazz mb-0">
                 <a href="#">
                   <img src="<%= (movie.getPosterImage() != null && !movie.getPosterImage().isEmpty()) ? "images/" + movie.getPosterImage() : "images/placeholder.jpg" %>" height="530" class="w-100" alt="<%= movie.getTitle() %> poster" />
                 </a>
               </figure>
           </div>
           </div>
		   <div class="detail_2ri1 position-absolute top-0 text-center bg_back w-100 h-100">
		     <span class="lh-1"><a class="col_oran"  href="javascript:void(0);" data-bs-toggle="modal" data-bs-target="#templateVideoModal"><i class="fa fa-play-circle align-middle"></i></a></span>
			 <h4 class="mb-0 mt-3"><a class="text-white" href="#">Watch the Trailer</a></h4>
		   </div>
		</div>
	  </div>
	</div>
	<div class="detail_3 row mt-4">
	  <div class="col-md-4">
	    <div class="detail_3l">
	       <h6 class="mb-3 text-muted"><span class="fw-bold text-black me-4">Release Date:</span>
<%= movie.getReleaseDate() %></h6>
 <h6 class="mb-3 text-muted"><span class="fw-bold text-black me-4">Available Seats:</span>
<%= movie.getAvailableSeats() %></h6>
<h2 class="mb-3 text-muted"><span class="fw-bold text-black me-4">Price:</span>
Rs. <%= String.format("%.2f", movie.getPrice()) %></h2>
		</div>
	  </div>
	  <div class="col-md-4">
	    <div class="detail_3l">
 <h6 class="mb-3 text-muted"><span class="fw-bold text-black me-4">Time:</span>
<%= movie.getDuration() %></h6>
		</div>
	  </div>
	  <div class="col-md-4">
	    <div class="detail_3l">
	    
		</div>
	  </div>
	</div><hr>
</section>

<section id="footer_b" class="pt-3 pb-3 bg-dark">
 <div class="container-xl">
  <div class="footer_b1 row text-center">
    <div class="col-md-12">
	  <p class="mb-0 text-white-50"> © 2025 CineApp. All Rights Reserved | Design by <a class="col_oran fw-bold" href="#">PGNO 225</a></p>
	</div>
  </div>
 </div>
</section>

<script src="js/common.js"></script>

</script>

<script src="js/common.js"></script>
</body>


</html>