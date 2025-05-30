package main.java.com.movieticket.dao;

import main.java.com.movieticket.model.Booking;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO {

    private static final String DATA_FILE = "/Users/mohamedrazeen/IdeaProjects/MovieTicketReservation/src/main/data/bookings.txt";;
    private static final String DELIMITER = "\\|";

    public List<Booking> getAllBookings() {
        List<Booking> bookings = new ArrayList<>();
        try (BufferedReader br = new BufferedReader(new FileReader(DATA_FILE))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] fields = line.split(DELIMITER);
                if (fields.length >= 6) {
                    Booking b = new Booking(fields[0], fields[1], fields[2], fields[3], fields[4], Boolean.parseBoolean(fields[5]));
                    bookings.add(b);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return bookings;
    }

    public boolean createBooking(Booking booking) {
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(DATA_FILE, true))) {
            bw.write(formatBooking(booking));
            bw.newLine();
            return true;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateBooking(Booking updatedBooking) {
        List<Booking> bookings = getAllBookings();
        boolean found = false;
        for (int i = 0; i < bookings.size(); i++) {
            if (bookings.get(i).getBookingId().equals(updatedBooking.getBookingId())) {
                bookings.set(i, updatedBooking);
                found = true;
                break;
            }
        }
        if (!found) return false;
        return rewriteFile(bookings);
    }

    public boolean deleteBooking(String bookingId) {
        List<Booking> bookings = getAllBookings();
        boolean removed = bookings.removeIf(b -> b.getBookingId().equals(bookingId));
        if (!removed) return false;
        return rewriteFile(bookings);
    }

    private boolean rewriteFile(List<Booking> bookings) {
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(DATA_FILE, false))) {
            for (Booking b : bookings) {
                bw.write(formatBooking(b));
                bw.newLine();
            }
            return true;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    private String formatBooking(Booking b) {
        return b.getBookingId() + "|" + b.getUserId() + "|" + b.getShowtimeId() + "|" + b.getSeatId() + "|" + b.getBookingDate() + "|" + b.isPaid();
    }

    public Booking getBookingById(String bookingId) {
        for (Booking b : getAllBookings()) {
            if (b.getBookingId().equals(bookingId)) return b;
        }
        return null;
    }
}
