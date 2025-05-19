package main.java.com.movieticket.model;

public class Seat {
    private String seatId;
    private String showtimeId;
    private String seatNumber;
    private boolean isBlocked;

    public Seat() {}

    public Seat(String seatId, String showtimeId, String seatNumber, boolean isBlocked) {
        this.seatId = seatId;
        this.showtimeId = showtimeId;
        this.seatNumber = seatNumber;
        this.isBlocked = isBlocked;
    }

    // Getters and setters
    public String getSeatId() { return seatId; }
    public void setSeatId(String seatId) { this.seatId = seatId; }

    public String getShowtimeId() { return showtimeId; }
    public void setShowtimeId(String showtimeId) { this.showtimeId = showtimeId; }

    public String getSeatNumber() { return seatNumber; }
    public void setSeatNumber(String seatNumber) { this.seatNumber = seatNumber; }

    public boolean isBlocked() { return isBlocked; }
    public void setBlocked(boolean blocked) { isBlocked = blocked; }
}
