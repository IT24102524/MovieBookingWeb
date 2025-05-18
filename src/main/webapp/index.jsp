<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<script>
  function checkLoginAndRedirect(url) {
    var loggedIn = <c:choose>
                     <c:when test="${not empty sessionScope.currentUser}">true</c:when>
                     <c:otherwise>false</c:otherwise>
                   </c:choose>;
    if (loggedIn) {
      window.location.href = url;
    } else {
      alert("Please login first!");
      window.location.href = "${pageContext.request.contextPath}/login.jsp";
    }
  }
</script>

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
	<link href="css/index.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Platypi:ital,wght@0,300..800;1,300..800&display=swap" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script src="js/bootstrap.bundle.min.js"></script>

</head>

<body>
<div class="main clearfix position-relative">
 <div class="modal fade" id="exampleModal2" tabindex="-1" aria-labelledby="exampleModalLabel" style="display: none; top:0;" aria-hidden="true">
		  <div class="modal-dialog">
			<div class="modal-content bg-transparent border-0">
			  <div class="modal-header border-0">
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"><i class="fa fa-close"></i></button>
			  </div>
			  <div class="modal-body p-0">
				<div class="search_1">
				   <div class="input-group">
				<input type="text" class="form-control bg-white border-0" placeholder="Search...">
				<span class="input-group-btn">
					<button class="btn btn-primary bg_oran border_1 rounded-0 p-3 px-4" type="button">
						<i class="fa fa-search"></i></button>
				</span>
		</div>
	            </div>
			  </div>
			</div>
		  </div>
		</div>
 <div class="main_1 clearfix position-absolute top-0 w-100">
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
          <a class="nav-link active" aria-current="page" href="index.jsp">Home</a>
        </li>

        <li class="nav-item">
           <a class="nav-link" aria-current="page" href="<c:url value='/movies'/>">Movies</a>
        </li>

		<li class="nav-item">
          <a class="nav-link" href="contact.jsp">Contact Us</a>
        </li>
      </ul>
      <ul class="navbar-nav mb-0 ms-auto">
	       <li class="nav-item">
          <a class="nav-link fs-5 drop_icon" data-bs-target="#exampleModal2" data-bs-toggle="modal" href="#"><i class="fa fa-search"></i></a>
        </li>
		    <li class="nav-item">
          <a class="nav-link fs-5 drop_icon" href="login.jsp"><i class="fa fa-user"></i></a>
        </li>
      </ul>
    </div>
  </div>
</nav>
</section>
 </div>
 <div class="main_2 clearfix">
   <section id="center" class="center_home">
 <div id="carouselExampleCaptions" class="carousel slide" data-bs-ride="carousel">
  <div class="carousel-indicators">
    <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="0" class="active" aria-label="Slide 1"></button>
    <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="1" aria-label="Slide 2" class="" aria-current="true"></button>
    <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="2" aria-label="Slide 3"></button>
  </div>
  <div class="carousel-inner">
    <div class="carousel-item active">
      <img src="img/1.jpg" class="d-block w-100" alt="...">
      <div class="carousel-caption d-md-block">
          <h3 class="col_oran">Thriller Movie</h3>
		  <h1 class="text-white mt-3">The Semper <br> Season 3</h1>
		  <p class="mt-3 text-light w-75">Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry’s standard dummy text ever since the 1500s, when an unknown printer typesetting, remaining essentially unchanged.</p>
		  <ul class="mb-0 mt-4">
		  <li class="d-inline-block"><a class="button" href="#"><i class="fa fa-check-circle me-1 font_14"></i> More Info</a></li>
		   <li class="d-inline-block ms-2"><a class="button_1 " style="cursor:pointer;" onclick="checkLoginAndRedirect('${pageContext.request.contextPath}/movies?action=details&id=movie1')"><i class="fa fa-check-circle me-1 font_14"></i> Get Ticket</a></li>
		</ul>
      </div>
    </div>
    <div class="carousel-item">
      <img src="img/2.jpg" class="d-block w-100" alt="...">
      <div class="carousel-caption d-md-block">
          <h3 class="col_oran">Action Movie</h3>
		  <h1 class="text-white mt-3">The Porta <br> One</h1>
		  <p class="mt-3 text-light w-75">Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry’s standard dummy text ever since the 1500s, when an unknown printer typesetting, remaining essentially unchanged.</p>
		  <ul class="mb-0 mt-4">
		  <li class="d-inline-block"><a class="button" href="#"><i class="fa fa-check-circle me-1 font_14"></i> More Info</a></li>
		   <li class="d-inline-block ms-2"><a class="button_1 " style="cursor:pointer;" onclick="checkLoginAndRedirect('${pageContext.request.contextPath}/movies?action=details&id=movie2')"><i class="fa fa-check-circle me-1 font_14"></i> Get Ticket</a></li>
		</ul>
      </div>
    </div>
    <div class="carousel-item">
      <img src="img/3.jpg" class="d-block w-100" alt="...">
      <div class="carousel-caption d-md-block">
          <h3 class="col_oran">Adventure Movie</h3>
		  <h1 class="text-white mt-3">The Lorem <br> Movie</h1>
		  <p class="mt-3 text-light w-75">Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry’s standard dummy text ever since the 1500s, when an unknown printer typesetting, remaining essentially unchanged.</p>
		  <ul class="mb-0 mt-4">
		  <li class="d-inline-block"><a class="button" href="#"><i class="fa fa-check-circle me-1 font_14"></i> More Info</a></li>
		   <li class="d-inline-block ms-2"><a class="button_1 " style="cursor:pointer;" onclick="checkLoginAndRedirect('${pageContext.request.contextPath}/movies?action=details&id=movie3')"><i class="fa fa-check-circle me-1 font_14"></i> Get Ticket</a></li>
		</ul>
      </div>
    </div>
  </div>
  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Previous</span>
  </button>
  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Next</span>
  </button>
</div>
</section>
 </div>

</div>

<div class="border_dashed">

</div>


<section id="trend" class="p_3 pt-0">
 <div class="container-xl">
   <div class="row trend_1 text-center mb-4">
      <div class="col-md-12">
	    <span class="fa fa-film col_oran"></span>
		<h6 class="text-muted mt-3">Watch New Movies</h6>
		<h1 class="mb-0 font_50">Movies Now Playing</h1>
	  </div>
   </div>
   <div class="row trend_2">
      <div class="col-md-3 col-sm-6">
       <div class="trend_2i position-relative">
	     <div class="trend_2i1">
	       <img src="img/5.jpg" class="w-100" alt="abc">
	   </div>
	   <div class="trend_2i2 bg_back position-absolute w-100 h-100 top-0 px-4">
	    <h6 class="font_14 text-light">Comedy / 180 Mins </h6>
		<h5><a class="text-white a_tag" href="#">The Fifth Day</a></h5>
		<h6 class="mb-0 mt-3"><a class="button_1 p-2 px-3 font_14" style="cursor:pointer;" onclick="checkLoginAndRedirect('${pageContext.request.contextPath}/movies?action=details&id=movie1')">Get Ticket</a></h6>
	   </div>
	   </div>
	  </div>
	  <div class="col-md-3 col-sm-6">
       <div class="trend_2i position-relative">
	     <div class="trend_2i1">
	       <img src="img/6.jpg" class="w-100" alt="abc">
	   </div>
	   <div class="trend_2i2 bg_back position-absolute w-100 h-100 top-0 px-4">
	    <h6 class="font_14 text-light">Animation / 160 Mins </h6>
		<h5><a class="text-white a_tag" href="#">Black & White</a></h5>
		<h6 class="mb-0 mt-3"><a class="button_1 p-2 px-3 font_14" style="cursor:pointer;" onclick="checkLoginAndRedirect('${pageContext.request.contextPath}/movies?action=details&id=movie2')">Get Ticket</a></h6>
	   </div>
	   </div>
	  </div>
	  <div class="col-md-3 col-sm-6">
       <div class="trend_2i position-relative">
	     <div class="trend_2i1">
	       <img src="img/7.jpg" class="w-100" alt="abc">
	   </div>
	   <div class="trend_2i2 bg_back position-absolute w-100 h-100 top-0 px-4">
	    <h6 class="font_14 text-light">Thriller / 190 Mins </h6>
		<h5><a class="text-white a_tag" href="#">Scariest Game</a></h5>
		<h6 class="mb-0 mt-3"><a class="button_1 p-2 px-3 font_14" style="cursor:pointer;" onclick="checkLoginAndRedirect('${pageContext.request.contextPath}/movies?action=details&id=movie1')">Get Ticket</a></h6>
	   </div>
	   </div>
	  </div>
	  <div class="col-md-3 col-sm-6">
       <div class="trend_2i position-relative">
	     <div class="trend_2i1">
	       <img src="img/8.png" class="w-100" alt="abc">
	   </div>
	   <div class="trend_2i2 bg_back position-absolute w-100 h-100 top-0 px-4">
	    <h6 class="font_14 text-light">Romance / 150 Mins </h6>
		<h5><a class="text-white a_tag" href="#">New Day Dreams</a></h5>
		<h6 class="mb-0 mt-3"><a class="button_1 p-2 px-3 font_14" style="cursor:pointer;" onclick="checkLoginAndRedirect('${pageContext.request.contextPath}/movies?action=details&id=movie1')">Get Ticket</a></h6>
	   </div>
	   </div>
	  </div>
   </div>
 </div>
</section>

<section id="choose">
 <div class="choose_m bg_backo pt-5 pb-5">
   <div class="container-xl">
    <div class="choose_1 row">
	  <div class="col-md-6 col-sm-6">
	     <div class="choose_1l">
		   <span class="fa fa-film col_oran"></span>
		<h6 class="text-white-50 mt-3">Documentary</h6>
		<h1 class="font_50 text-white">Movies Now Playing</h1>
		<p class="mt-3 text-white-50">Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry’s standard dummy text ever since the 1500s, when an unknown printer typesetting, remaining essentially unchanged</p>
		<h6 class="mb-0 mt-4"><a class="button_1" href="#">More Info</a></h6>
		 </div>
	  </div>
	  <div class="col-md-6 col-sm-6">
	     <div class="choose_1r text-center mt-5">
		   <h4 class="text-white mb-0">Watch the Trailer <span class="ms-2"><a class="col_oran" href="javascript:void(0);" data-bs-toggle="modal" data-bs-target="#templateVideoModal"><i class="fa fa-play-circle align-middle"></i></a></span></h4>
		 </div>
	  </div>
	</div>
 </div>
 </div>
</section>


<section id="trend_o" class="p_3 px_4">
 <div class="container-fluid">
   <div class="row trend_1 text-center mb-4">
      <div class="col-md-12">
	    <span class="fa fa-film col_oran"></span>
		<h6 class="text-muted mt-3">New Upcoming Movies</h6>
		<h1 class="mb-0 font_50">Movies Coming Soon</h1>
	  </div>
   </div>
   <div class="row trend_2">
      <div class="col-md-3 col-sm-6">
       <div class="trend_2i position-relative">
	     <div class="trend_2i1">
	       <img src="img/21.jpg" class="w-100" alt="abc">
	   </div>
	   <div class="trend_2i2 bg_back position-absolute w-100 h-100 top-0 px-4">
	    <h6 class="font_14 text-light">Comedy / 180 Mins </h6>
		<h5><a class="text-white a_tag" href="#">The Fifth Day</a></h5>
	   </div>
	   </div>
	  </div>
	  <div class="col-md-3 col-sm-6">
       <div class="trend_2i position-relative">
	     <div class="trend_2i1">
	       <img src="img/22.jpg" class="w-100" alt="abc">
	   </div>
	   <div class="trend_2i2 bg_back position-absolute w-100 h-100 top-0 px-4">
	    <h6 class="font_14 text-light">Animation / 160 Mins </h6>
		<h5><a class="text-white a_tag" href="#">Black &amp; White</a></h5>
	   </div>
	   </div>
	  </div>
	  <div class="col-md-3 col-sm-6">
       <div class="trend_2i position-relative">
	     <div class="trend_2i1">
	       <img src="img/23.jpg" class="w-100" alt="abc">
	   </div>
	   <div class="trend_2i2 bg_back position-absolute w-100 h-100 top-0 px-4">
	    <h6 class="font_14 text-light">Thriller / 190 Mins </h6>
		<h5><a class="text-white a_tag" href="#">Scariest Game</a></h5>
	   </div>
	   </div>
	  </div>
	  <div class="col-md-3 col-sm-6">
       <div class="trend_2i position-relative">
	     <div class="trend_2i1">
	       <img src="img/24.png" class="w-100" alt="abc">
	   </div>
	   <div class="trend_2i2 bg_back position-absolute w-100 h-100 top-0 px-4">
	    <h6 class="font_14 text-light">Romance / 150 Mins </h6>
		<h5><a class="text-white a_tag" href="#">New Day Dreams</a></h5>
	   </div>
	   </div>
	  </div>
   </div>
 </div>
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

</body>


</html>