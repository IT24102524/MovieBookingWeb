package main.java.com.movieticket.model;

public class Review {
    private String reviewId;
    private String movieId;
    private String userId;
    private String username; // optional, display user name
    private int rating; // 1 to 5
    private String comment;

    public Review() {}

    public Review(String reviewId, String movieId, String userId, String username, int rating, String comment) {
        this.reviewId = reviewId;
        this.movieId = movieId;
        this.userId = userId;
        this.username = username;
        this.rating = rating;
        this.comment = comment;
    }

    // getters and setters
    public String getReviewId() { return reviewId; }
    public void setReviewId(String reviewId) { this.reviewId = reviewId; }
    public String getMovieId() { return movieId; }
    public void setMovieId(String movieId) { this.movieId = movieId; }
    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public int getRating() { return rating; }
    public void setRating(int rating) { this.rating = rating; }
    public String getComment() { return comment; }
    public void setComment(String comment) { this.comment = comment; }
}
