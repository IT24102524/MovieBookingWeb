package main.java.com.movieticket.servlet;

import main.java.com.movieticket.dao.MovieDAO;
import main.java.com.movieticket.model.Movie;
import main.java.com.movieticket.model.Showtime;

import jakarta.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import main.java.com.movieticket.model.User;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@WebServlet("/movies")
public class MovieServlet extends HttpServlet {

    private MovieDAO movieDAO;

    @Override
    public void init() {
        movieDAO = new MovieDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "createForm":
                request.getRequestDispatcher("movies/create_movie.jsp").forward(request, response);
                break;
            case "editForm":
                showEditForm(request, response);
                break;
            case "deleteConfirm":
                showDeleteConfirm(request, response);
                break;
            case "details":
                showDetails(request, response);
                break;
            case "book":
                showBookingForm(request, response);
                break;
            case "list":
            default:
                listMovies(request, response);
                break;
        }
    }

    private void listMovies(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Movie> movies = movieDAO.getAllMovies();
        request.setAttribute("movies", movies);

        HttpSession session = request.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("currentUser") : null;

        if (currentUser != null && "admin".equals(currentUser.getRole())) {
            request.getRequestDispatcher("admin/movies_admin.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("movies/movies_user.jsp").forward(request, response);
        }
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        Movie movie = movieDAO.getMovieById(id);
        if (movie == null) {
            response.sendRedirect("movies");
            return;
        }
        request.setAttribute("movie", movie);
        request.getRequestDispatcher("movies/edit_movie.jsp").forward(request, response);
    }

    private void showDeleteConfirm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        Movie movie = movieDAO.getMovieById(id);
        if (movie == null) {
            response.sendRedirect("movies");
            return;
        }
        request.setAttribute("movie", movie);
        request.getRequestDispatcher("movies/delete_movie_confirm.jsp").forward(request, response);
    }

    private void showDetails(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        Movie movie = movieDAO.getMovieById(id);
        if (movie == null) {
            response.sendRedirect("movies");
            return;
        }
        request.setAttribute("movie", movie);
        request.getRequestDispatcher("movies/detail.jsp").forward(request, response);
    }

    // NEW: show booking form with movie and showtimes
    private void showBookingForm(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String movieId = req.getParameter("id");
        if (movieId == null || movieId.isEmpty()) {
            resp.sendRedirect("movies");
            return;
        }

        Movie movie = movieDAO.getMovieById(movieId);
        if (movie == null) {
            resp.sendRedirect("movies");
            return;
        }

        // IMPORTANT: Sort showtimes by date and time to ensure JSP renders unique dates correctly
        movie.getShowtimes().sort((a, b) -> {
            int dateComp = a.getDate().compareTo(b.getDate());
            if (dateComp != 0) return dateComp;
            return a.getTime().compareTo(b.getTime());
        });

        req.setAttribute("movie", movie);
        req.getRequestDispatcher("bookings/book_ticket.jsp").forward(req, resp);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "create":
                createMovie(request, response);
                break;
            case "update":
                updateMovie(request, response);
                break;
            case "delete":
                deleteMovie(request, response);
                break;
            default:
                response.sendRedirect("movies");
                break;
        }
    }

    private void createMovie(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        Movie movie = extractMovieFromRequest(request);
        boolean created = movieDAO.createMovie(movie);
        if (created) {
            response.sendRedirect("movies?action=adminList");
        } else {
            request.setAttribute("errorMessage", "Failed to create movie.");
            request.getRequestDispatcher("movies/create_movie.jsp").forward(request, response);
        }
    }

    private void updateMovie(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        Movie movie = extractMovieFromRequest(request);
        boolean updated = movieDAO.updateMovie(movie);
        if (updated) {
            response.sendRedirect("movies?action=adminList");
        } else {
            request.setAttribute("errorMessage", "Failed to update movie.");
            request.setAttribute("movie", movie);
            request.getRequestDispatcher("movies/edit_movie.jsp").forward(request, response);
        }
    }

    private Movie extractMovieFromRequest(HttpServletRequest request) {
        String movieId = request.getParameter("movieId");
        String title = request.getParameter("title");
        int duration = Integer.parseInt(request.getParameter("duration"));
        String releaseDate = request.getParameter("releaseDate");
        String posterImage = request.getParameter("posterImage");
        int availableSeats = Integer.parseInt(request.getParameter("availableSeats"));
        double price = Double.parseDouble(request.getParameter("price"));

        String[] showDates = request.getParameterValues("showDate");
        String[] showTimes = request.getParameterValues("showTime");
        List<Showtime> showtimes = new ArrayList<>();
        if (showDates != null && showTimes != null && showDates.length == showTimes.length) {
            for (int i = 0; i < showDates.length; i++) {
                showtimes.add(new Showtime(
                        java.util.UUID.randomUUID().toString(),
                        movieId,
                        showDates[i],
                        showTimes[i],
                        price
                ));
            }
        }

        return new Movie(movieId, title, duration, releaseDate, posterImage, availableSeats, price, showtimes);
    }


    private void deleteMovie(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String movieId = request.getParameter("movieId");
        movieDAO.deleteMovie(movieId);
        response.sendRedirect("movies?action=adminList");
    }
}
