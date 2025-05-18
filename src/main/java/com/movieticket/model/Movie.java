package main.java.com.movieticket.model;

import java.util.ArrayList;
import java.util.List;

public class Movie {
    private String movieId;
    private String title;
    private int duration; // in minutes
    private String releaseDate; // format: YYYY-MM-DD
    private String posterImage; // filename
    private int availableSeats;
    private double price;
    private List<Showtime> showtimes;

    public Movie() {
        this.showtimes = new ArrayList<>();
    }

    public Movie(String movieId, String title, int duration, String releaseDate,
                 String posterImage, int availableSeats, double price) {
        this.movieId = movieId;
        this.title = title;
        this.duration = duration;
        this.releaseDate = releaseDate;
        this.posterImage = posterImage;
        this.availableSeats = availableSeats;
        this.price = price;
        this.showtimes = new ArrayList<>();
    }

    public Movie(String movieId, String title, int duration, String releaseDate,
                 String posterImage, int availableSeats, double price, List<Showtime> showtimes) {
        this.movieId = movieId;
        this.title = title;
        this.duration = duration;
        this.releaseDate = releaseDate;
        this.posterImage = posterImage;
        this.availableSeats = availableSeats;
        this.price = price;
        this.showtimes = showtimes;
    }

    // Getters and setters
    public String getMovieId() { return movieId; }
    public void setMovieId(String movieId) { this.movieId = movieId; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public int getDuration() { return duration; }
    public void setDuration(int duration) { this.duration = duration; }

    public String getReleaseDate() { return releaseDate; }
    public void setReleaseDate(String releaseDate) { this.releaseDate = releaseDate; }

    public String getPosterImage() { return posterImage; }
    public void setPosterImage(String posterImage) { this.posterImage = posterImage; }

    public int getAvailableSeats() { return availableSeats; }
    public void setAvailableSeats(int availableSeats) { this.availableSeats = availableSeats; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public List<Showtime> getShowtimes() { return showtimes; }
    public void setShowtimes(List<Showtime> showtimes) { this.showtimes = showtimes; }
}
