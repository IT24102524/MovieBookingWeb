package main.java.com.movieticket.dao;

import main.java.com.movieticket.model.Seat;

import java.io.*;
import java.util.*;

public class SeatDAO {

    private static final String DATA_FILE = "F:\\SLIIT\\Y1S2\\OOP\\Assignment\\MovieReservation\\MovieReservation\\src\\main\\data/seats.txt";
    private static final String DELIMITER = "\\|";

    public List<Seat> getAllSeats() {
        List<Seat> seats = new ArrayList<>();
        try (BufferedReader br = new BufferedReader(new FileReader(DATA_FILE))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] fields = line.split(DELIMITER);
                if (fields.length >= 4) {
                    Seat seat = new Seat(fields[0], fields[1], fields[2], Boolean.parseBoolean(fields[3]));
                    seats.add(seat);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return seats;
    }

    public List<Seat> getSeatsByShowtime(String showtimeId) {
        List<Seat> filtered = new ArrayList<>();
        for (Seat seat : getAllSeats()) {
            if (seat.getShowtimeId().equals(showtimeId)) filtered.add(seat);
        }
        return filtered;
    }

    public boolean createSeat(Seat seat) {
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(DATA_FILE, true))) {
            bw.write(formatSeat(seat));
            bw.newLine();
            return true;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateSeat(Seat updatedSeat) {
        List<Seat> seats = getAllSeats();
        boolean found = false;
        for (int i = 0; i < seats.size(); i++) {
            if (seats.get(i).getSeatId().equals(updatedSeat.getSeatId())) {
                seats.set(i, updatedSeat);
                found = true;
                break;
            }
        }
        if (!found) return false;
        return rewriteFile(seats);
    }

    public boolean deleteSeat(String seatId) {
        List<Seat> seats = getAllSeats();
        boolean removed = seats.removeIf(s -> s.getSeatId().equals(seatId));
        if (!removed) return false;
        return rewriteFile(seats);
    }

    private boolean rewriteFile(List<Seat> seats) {
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(DATA_FILE, false))) {
            for (Seat s : seats) {
                bw.write(formatSeat(s));
                bw.newLine();
            }
            return true;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    private String formatSeat(Seat seat) {
        return seat.getSeatId() + "|" + seat.getShowtimeId() + "|" + seat.getSeatNumber() + "|" + seat.isBlocked();
    }

    public Seat getSeatById(String seatId) {
        for (Seat s : getAllSeats()) {
            if (s.getSeatId().equals(seatId)) return s;
        }
        return null;
    }

    private static final String RESERVED_SEATS_FILE = "F:\\SLIIT\\Y1S2\\OOP\\Assignment\\MovieReservation\\MovieReservation\\src\\main\\data/reserved_seats.txt";

    private List<String> getReservedSeats(String movieId, String showDate, String showtime) {
        List<String> reserved = new ArrayList<>();
        try (BufferedReader br = new BufferedReader(new FileReader(RESERVED_SEATS_FILE))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] parts = line.split("\\|");
                if (parts.length == 4 && parts[0].equals(movieId) && parts[1].equals(showDate) && parts[2].equals(showtime)) {
                    if (!parts[3].isEmpty()) {
                        reserved.addAll(Arrays.asList(parts[3].split(",")));
                    }
                    break;
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return reserved;
    }

    private void saveReservedSeats(String movieId, String showDate, String showtime, List<String> seatsToSave) {
        Map<String, List<String>> allReserved = new HashMap<>();

        // Load all reserved seats into map (key = movieId|showDate|showtime)
        try (BufferedReader br = new BufferedReader(new FileReader(RESERVED_SEATS_FILE))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] parts = line.split("\\|");
                if (parts.length == 4) {
                    String key = parts[0] + "|" + parts[1] + "|" + parts[2];
                    List<String> seats = parts[3].isEmpty() ? new ArrayList<>() : new ArrayList<>(Arrays.asList(parts[3].split(",")));
                    allReserved.put(key, seats);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        // Update or add new entry for current movie-show-date
        String currentKey = movieId + "|" + showDate + "|" + showtime;
        allReserved.put(currentKey, seatsToSave);

        // Rewrite entire file with updated reserved seats
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(RESERVED_SEATS_FILE, false))) {
            for (Map.Entry<String, List<String>> entry : allReserved.entrySet()) {
                String key = entry.getKey();
                List<String> seats = entry.getValue();
                bw.write(key + "|" + String.join(",", seats));
                bw.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }


}
