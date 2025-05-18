package main.java.com.movieticket.servlet;

import jakarta.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import main.java.com.movieticket.dao.ReviewDAO;
import main.java.com.movieticket.model.Review;

import java.io.IOException;
import java.util.List;
import java.util.UUID;

@WebServlet("/reviews")
public class ReviewServlet extends HttpServlet {

    private ReviewDAO reviewDAO;

    @Override
    public void init() {
        reviewDAO = new ReviewDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String movieId = req.getParameter("movieId");
        if (movieId == null || movieId.isEmpty()) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Movie ID required");
            return;
        }

        List<Review> reviews = reviewDAO.getReviewsByMovieId(movieId);
        req.setAttribute("reviews", reviews);
        req.setAttribute("movieId", movieId);
        req.getRequestDispatcher("/reviews/reviews.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("add".equals(action)) {
            handleAddReview(req, resp);
        } else {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
        }
    }

    private void handleAddReview(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("currentUser") == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        String movieId = req.getParameter("movieId");
        String ratingStr = req.getParameter("rating");
        String comment = req.getParameter("comment");
        if (movieId == null || ratingStr == null || comment == null) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing parameters");
            return;
        }

        int rating = 0;
        try {
            rating = Integer.parseInt(ratingStr);
        } catch (NumberFormatException ignored) {}

        if (rating < 1 || rating > 5) {
            req.setAttribute("error", "Rating must be between 1 and 5");
            doGet(req, resp);
            return;
        }

        main.java.com.movieticket.model.User user = (main.java.com.movieticket.model.User) session.getAttribute("currentUser");

        Review review = new Review(UUID.randomUUID().toString(), movieId, user.getUserId(), user.getName(), rating, comment);

        boolean success = reviewDAO.addReview(review);
        if (success) {
            resp.sendRedirect(req.getContextPath() + "/reviews?movieId=" + movieId);
        } else {
            req.setAttribute("error", "Failed to add review. Please try again.");
            doGet(req, resp);
        }
    }
}
