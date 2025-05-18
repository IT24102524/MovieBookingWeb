package main.java.com.movieticket.model;

public class Showtime {
    private String showtimeId;
    private String movieId;
    private String date; // YYYY-MM-DD
    private String time; // HH:mm or similar
    private double price;

    public Showtime() {}

    public Showtime(String showtimeId, String movieId, String date, String time, double price) {
        this.showtimeId = showtimeId;
        this.movieId = movieId;
        this.date = date;
        this.time = time;
        this.price = price;
    }

    // Getters and setters
    public String getShowtimeId() { return showtimeId; }
    public void setShowtimeId(String showtimeId) { this.showtimeId = showtimeId; }

    public String getMovieId() { return movieId; }
    public void setMovieId(String movieId) { this.movieId = movieId; }

    public String getDate() { return date; }
    public void setDate(String date) { this.date = date; }

    public String getTime() { return time; }
    public void setTime(String time) { this.time = time; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }
}
