package main.java.com.movieticket.model;

public class Booking {
    private String bookingId;
    private String userId;
    private String showtimeId;
    private String seatId;
    private String bookingDate;  // YYYY-MM-DD
    private boolean isPaid;

    public Booking() {}

    public Booking(String bookingId, String userId, String showtimeId, String seatId, String bookingDate, boolean isPaid) {
        this.bookingId = bookingId;
        this.userId = userId;
        this.showtimeId = showtimeId;
        this.seatId = seatId;
        this.bookingDate = bookingDate;
        this.isPaid = isPaid;
    }

    // Getters and setters
    public String getBookingId() { return bookingId; }
    public void setBookingId(String bookingId) { this.bookingId = bookingId; }

    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }

    public String getShowtimeId() { return showtimeId; }
    public void setShowtimeId(String showtimeId) { this.showtimeId = showtimeId; }

    public String getSeatId() { return seatId; }
    public void setSeatId(String seatId) { this.seatId = seatId; }

    public String getBookingDate() { return bookingDate; }
    public void setBookingDate(String bookingDate) { this.bookingDate = bookingDate; }

    public boolean isPaid() { return isPaid; }
    public void setPaid(boolean paid) { isPaid = paid; }
}
