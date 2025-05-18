package main.java.com.movieticket.servlet;

import jakarta.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import main.java.com.movieticket.dao.MovieDAO;
import main.java.com.movieticket.model.Movie;

import java.io.*;
import java.time.LocalDateTime;
import java.util.*;

@WebServlet("/bookings")
public class BookingServlet extends HttpServlet {

    // Absolute path to bookings file — update as per your environment
    private static final String BOOKINGS_FILE = "/Users/mohamedrazeen/IdeaProjects/MovieTicketReservation/src/main/data/bookings.txt";

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        System.out.println("BookingServlet: action = " + action);

        if ("selectSeats".equals(action)) {
            handleSelectSeats(req, resp);
        } else if ("confirmSeats".equals(action)) {
            handleConfirmSeats(req, resp);
        } else if ("finalizeBooking".equals(action)) {
            handleFinalizeBooking(req, resp);
        } else if ("updateBooking".equals(action)) {
            handleUpdateBooking(req, resp);
        } else {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action: " + action);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Admin access control example (optional)
        HttpSession session = req.getSession(false);
        if (session == null || !"admin".equals(session.getAttribute("role"))) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied.");
            return;
        }

        String action = req.getParameter("action");
        String bookingId = req.getParameter("bookingId");

        if ("deleteBooking".equals(action) && bookingId != null) {
            deleteBooking(bookingId);
            resp.sendRedirect(req.getContextPath() + "/bookings");
            return;
        } else if ("editBooking".equals(action) && bookingId != null) {
            BookingRecord booking = getBookingById(bookingId);
            if (booking == null) {
                resp.sendRedirect(req.getContextPath() + "/bookings");
                return;
            }
            req.setAttribute("booking", booking);
            req.getRequestDispatcher("/bookings/edit_booking.jsp").forward(req, resp);
            return;
        }

        // Default: show booking list
        List<BookingRecord> bookings = readAllBookings();
        req.setAttribute("bookings", bookings);
        req.getRequestDispatcher("/admin/manage_bookings.jsp").forward(req, resp);
    }

    // BookingRecord inner class for booking management
    public static class BookingRecord {
        public String bookingId;
        public String movieId;
        public String showDate;
        public String showtime;
        public String seats;
        public String foodItems;
        public String totalPrice;
        public String timestamp;

        // Getters to use EL in JSP
        public String getBookingId() { return bookingId; }
        public String getMovieId() { return movieId; }
        public String getShowDate() { return showDate; }
        public String getShowtime() { return showtime; }
        public String getSeats() { return seats; }
        public String getFoodItems() { return foodItems; }
        public String getTotalPrice() { return totalPrice; }
        public String getTimestamp() { return timestamp; }
    }

    // Reads all bookings from file
    private List<BookingRecord> readAllBookings() {
        List<BookingRecord> bookings = new ArrayList<>();
        File file = new File(BOOKINGS_FILE);
        if (!file.exists()) {
            return bookings;
        }
        try (BufferedReader br = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] parts = line.split("\\|");
                if (parts.length >= 8) {
                    BookingRecord brd = new BookingRecord();
                    brd.bookingId = parts[0];
                    brd.movieId = parts[1];
                    brd.showDate = parts[2];
                    brd.showtime = parts[3];
                    brd.seats = parts[4];
                    brd.foodItems = parts[5];
                    brd.totalPrice = parts[6];
                    brd.timestamp = parts[7];
                    bookings.add(brd);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return bookings;
    }

    private BookingRecord getBookingById(String bookingId) {
        List<BookingRecord> bookings = readAllBookings();
        for (BookingRecord b : bookings) {
            if (b.bookingId.equals(bookingId)) {
                return b;
            }
        }
        return null;
    }

    private void deleteBooking(String bookingId) throws IOException {
        List<BookingRecord> bookings = readAllBookings();
        bookings.removeIf(b -> b.bookingId.equals(bookingId));
        rewriteBookingsFile(bookings);
    }

    private void handleUpdateBooking(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String bookingId = req.getParameter("bookingId");
        String movieId = req.getParameter("movieId");
        String showDate = req.getParameter("showDate");
        String showtime = req.getParameter("showtime");
        String seats = req.getParameter("seats");
        String foodItems = req.getParameter("foodItems");
        String totalPrice = req.getParameter("totalPrice");

        if (bookingId == null || bookingId.isEmpty()) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Booking ID is required");
            return;
        }

        updateBooking(bookingId, movieId, showDate, showtime, seats, foodItems, totalPrice);

        // Redirect back to manage bookings page after update
        resp.sendRedirect(req.getContextPath() + "/bookings");
    }

    // Update booking record in file
    private void updateBooking(String bookingId, String movieId, String showDate, String showtime,
                               String seats, String foodItems, String totalPrice) throws IOException {
        List<BookingRecord> bookings = readAllBookings();
        for (BookingRecord b : bookings) {
            if (b.bookingId.equals(bookingId)) {
                b.movieId = movieId;
                b.showDate = showDate;
                b.showtime = showtime;
                b.seats = seats;
                b.foodItems = foodItems;
                b.totalPrice = totalPrice;
                b.timestamp = LocalDateTime.now().toString();
                break;
            }
        }
        rewriteBookingsFile(bookings);
    }

    // Rewrite all bookings back to file
    private void rewriteBookingsFile(List<BookingRecord> bookings) throws IOException {
        File bookingsFile = new File(BOOKINGS_FILE);
        bookingsFile.getParentFile().mkdirs();

        try (BufferedWriter bw = new BufferedWriter(new FileWriter(bookingsFile, false))) {
            for (BookingRecord b : bookings) {
                String line = String.join("|",
                        b.bookingId,
                        b.movieId,
                        b.showDate,
                        b.showtime,
                        b.seats,
                        b.foodItems,
                        b.totalPrice,
                        b.timestamp
                );
                bw.write(line);
                bw.newLine();
            }
        }
    }

    private void handleSelectSeats(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String movieId = req.getParameter("movieId");
        String showDate = req.getParameter("showDate");
        String showtime = req.getParameter("showtime");
        String seatsStr = req.getParameter("seats");
        int seats = 1;
        try {
            seats = Integer.parseInt(seatsStr);
        } catch (NumberFormatException e) {
            // default 1
        }

        List<String> reservedSeats = getReservedSeats(movieId, showDate, showtime);

        req.setAttribute("movieId", movieId);
        req.setAttribute("showDate", showDate);
        req.setAttribute("showtime", showtime);
        req.setAttribute("seats", seats);
        req.setAttribute("reservedSeats", reservedSeats);

        req.getRequestDispatcher("/seats/select_seats.jsp").forward(req, resp);
    }

    private void handleConfirmSeats(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String movieId = req.getParameter("movieId");

        MovieDAO movieDAO = new MovieDAO();
        Movie movie = movieDAO.getMovieById(movieId);

        double ticketPrice = (movie != null) ? movie.getPrice() : 0.0;

        String bookingId = UUID.randomUUID().toString();

        HttpSession session = req.getSession();
        String showDate = req.getParameter("showDate");
        String showtime = req.getParameter("showtime");
        String[] selectedSeats = req.getParameter("selectedSeats").split(",");

        PendingBooking booking = new PendingBooking(bookingId, movieId, showDate, showtime, selectedSeats, ticketPrice);
        session.setAttribute("pendingBooking", booking);

        resp.sendRedirect(req.getContextPath() + "/bookings/bookingConfirmation.jsp");
    }

    private void handleFinalizeBooking(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null) {
            resp.sendRedirect(req.getContextPath() + "/movies");
            return;
        }

        PendingBooking booking = (PendingBooking) session.getAttribute("pendingBooking");
        if (booking == null) {
            resp.sendRedirect(req.getContextPath() + "/movies");
            return;
        }

        String[] foodItems = req.getParameterValues("foodItem");

        double ticketPrice = booking.getTicketPrice();

        Map<String, Double> foodPrices = Map.of(
                "popcorn", 600.0,
                "coke", 350.0,
                "nachos", 700.0
        );

        double totalPrice = ticketPrice * booking.getSelectedSeats().length;
        if (foodItems != null) {
            for (String food : foodItems) {
                totalPrice += foodPrices.getOrDefault(food, 0.0);
            }
        }

        saveBookingToFile(booking, foodItems, totalPrice);

        String receiptContent = generateReceiptContent(booking, foodItems, totalPrice);

        String filePath = getServletContext().getRealPath("/WEB-INF/data/receipts/");
        File receiptsDir = new File(filePath);
        if (!receiptsDir.exists()) receiptsDir.mkdirs();

        String receiptFileName = "receipt_" + UUID.randomUUID().toString() + ".txt";
        File receiptFile = new File(receiptsDir, receiptFileName);

        try (BufferedWriter bw = new BufferedWriter(new FileWriter(receiptFile))) {
            bw.write(receiptContent);
            bw.newLine();
        } catch (IOException e) {
            e.printStackTrace();
            req.setAttribute("error", "Failed to generate receipt. Please try again.");
            req.getRequestDispatcher("/bookings/bookingConfirmation.jsp").forward(req, resp);
            return;
        }

        session.removeAttribute("pendingBooking");

        req.setAttribute("receiptFile", receiptFile.getName());
        req.setAttribute("movieId", booking.getMovieId());
        req.setAttribute("showDate", booking.getShowDate());
        req.setAttribute("showtime", booking.getShowtime());
        req.setAttribute("seats", booking.getSelectedSeats());
        req.setAttribute("foodItems", foodItems);
        req.setAttribute("totalPrice", totalPrice);
        req.setAttribute("ticketPrice", ticketPrice);
        req.setAttribute("bookingId", booking.getBookingId());

        req.getRequestDispatcher("/bookings/receipt.jsp").forward(req, resp);
    }

    private List<String> getReservedSeats(String movieId, String showDate, String showtime) {
        List<String> reservedSeats = new ArrayList<>();

        try {
            List<String> lines = java.nio.file.Files.readAllLines(java.nio.file.Paths.get(BOOKINGS_FILE));
            for (String line : lines) {
                String[] parts = line.split("\\|");
                if (parts.length >= 5) {
                    String bookedMovieId = parts[1];
                    String bookedDate = parts[2];
                    String bookedShowtime = parts[3];
                    String seatsStr = parts[4];

                    if (movieId.equals(bookedMovieId) && showDate.equals(bookedDate) && showtime.equals(bookedShowtime)) {
                        String[] seats = seatsStr.split(",");
                        for (String seat : seats) {
                            reservedSeats.add(seat.trim());
                        }
                    }
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        return reservedSeats;
    }

    private void saveBookingToFile(PendingBooking booking, String[] foodItems, double totalPrice) throws IOException {
        String bookingLine = String.join("|",
                booking.getBookingId(),
                booking.getMovieId(),
                booking.getShowDate(),
                booking.getShowtime(),
                String.join(",", booking.getSelectedSeats()),
                foodItems != null ? String.join(",", foodItems) : "",
                String.valueOf(totalPrice),
                LocalDateTime.now().toString()
        );

        File bookingsFile = new File(BOOKINGS_FILE);
        bookingsFile.getParentFile().mkdirs();

        try (BufferedWriter bw = new BufferedWriter(new FileWriter(bookingsFile, true))) {
            bw.write(bookingLine);
            bw.newLine();
        }
    }

    private String generateReceiptContent(PendingBooking booking, String[] foodItems, double totalPrice) {
        StringBuilder receipt = new StringBuilder();
        receipt.append("Booking Confirmation\n");
        receipt.append("Booking ID: ").append(booking.getBookingId()).append("\n");
        receipt.append("Movie ID: ").append(booking.getMovieId()).append("\n");
        receipt.append("Date: ").append(booking.getShowDate()).append("\n");
        receipt.append("Showtime: ").append(booking.getShowtime()).append("\n");
        receipt.append("Seats: ").append(String.join(", ", booking.getSelectedSeats())).append("\n");
        if (foodItems != null && foodItems.length > 0) {
            receipt.append("Food Items: ").append(String.join(", ", foodItems)).append("\n");
        }
        receipt.append("Total Price: $").append(totalPrice).append("\n");
        receipt.append("Thank you for booking! Please pay at the theater.\n");
        return receipt.toString();
    }

    public static class PendingBooking {
        private String bookingId;
        private String movieId;
        private String showDate;
        private String showtime;
        private String[] selectedSeats;
        private double ticketPrice;

        public PendingBooking(String bookingId, String movieId, String showDate, String showtime, String[] selectedSeats, double ticketPrice) {
            this.bookingId = bookingId;
            this.movieId = movieId;
            this.showDate = showDate;
            this.showtime = showtime;
            this.selectedSeats = selectedSeats;
            this.ticketPrice = ticketPrice;
        }

        public String getBookingId() { return bookingId; }
        public String getMovieId() { return movieId; }
        public String getShowDate() { return showDate; }
        public String getShowtime() { return showtime; }
        public String[] getSelectedSeats() { return selectedSeats; }
        public double getTicketPrice() { return ticketPrice; }
    }
}
