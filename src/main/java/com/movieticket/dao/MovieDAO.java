package main.java.com.movieticket.dao;

import main.java.com.movieticket.model.Movie;
import main.java.com.movieticket.model.Showtime;

import java.io.*;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

public class MovieDAO {

    private static final String DATA_FILE = "F:\\SLIIT\\Y1S2\\OOP\\Assignment\\MovieReservation\\MovieReservation\\src\\main\\data/movies.txt";
    private static final String DELIMITER = "\\|";

    // Read all movies with showtimes and return sorted by releaseDate
    public List<Movie> getAllMovies() {
        List<Movie> movies = new ArrayList<>();

        try (BufferedReader br = new BufferedReader(new FileReader(DATA_FILE))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] fields = line.split(DELIMITER);
                if (fields.length >= 7) { // at least 7 fields (price is 7th)
                    String showtimesStr = (fields.length > 7) ? fields[7] : "";

                    Movie movie = new Movie(
                            fields[0], // movieId
                            fields[1], // title
                            Integer.parseInt(fields[2]), // duration
                            fields[3], // releaseDate
                            fields[4], // posterImage
                            Integer.parseInt(fields[5]), // availableSeats
                            Double.parseDouble(fields[6]), // price
                            deserializeShowtimes(showtimesStr, fields[0]) // showtimes list
                    );
                    movies.add(movie);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        // Call insertion sort here to sort movies by release date ascending
        insertionSortByReleaseDate(movies);

        return movies;
    }

    // Create a movie (append)
    public boolean createMovie(Movie movie) {
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(DATA_FILE, true))) {
            bw.write(formatMovie(movie));
            bw.newLine();
            return true;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Update movie by rewriting entire file
    public boolean updateMovie(Movie updatedMovie) {
        List<Movie> movies = getAllMovies();
        boolean found = false;

        for (int i = 0; i < movies.size(); i++) {
            if (movies.get(i).getMovieId().equals(updatedMovie.getMovieId())) {
                movies.set(i, updatedMovie);
                found = true;
                break;
            }
        }

        if (!found) return false;

        return rewriteFile(movies);
    }

    // Delete movie by ID
    public boolean deleteMovie(String movieId) {
        List<Movie> movies = getAllMovies();
        boolean removed = movies.removeIf(m -> m.getMovieId().equals(movieId));
        if (!removed) return false;

        return rewriteFile(movies);
    }

    // Rewrite entire file with movies list
    private boolean rewriteFile(List<Movie> movies) {
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(DATA_FILE, false))) {
            for (Movie m : movies) {
                bw.write(formatMovie(m));
                bw.newLine();
            }
            return true;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Serialize showtimes to string: date,time;date,time;...
    private String serializeShowtimes(List<Showtime> showtimes) {
        if (showtimes == null || showtimes.isEmpty()) return "";
        StringBuilder sb = new StringBuilder();
        for (Showtime st : showtimes) {
            sb.append(st.getDate())
                    .append(",")
                    .append(st.getTime())
                    .append(";");
        }
        sb.deleteCharAt(sb.length() - 1); // remove trailing semicolon
        return sb.toString();
    }

    // Deserialize showtimes string to List<Showtime>
    private List<Showtime> deserializeShowtimes(String showtimesStr, String movieId) {
        List<Showtime> showtimes = new ArrayList<>();
        if (showtimesStr == null || showtimesStr.isEmpty()) return showtimes;

        String[] parts = showtimesStr.split(";");
        for (String part : parts) {
            String[] dt = part.split(",");
            if (dt.length == 2) {
                // Showtime constructor: (id, movieId, date, time, price)
                showtimes.add(new Showtime(UUID.randomUUID().toString(), movieId, dt[0], dt[1], 0.0));
            }
        }
        return showtimes;
    }

    // Format Movie as line to write to file including serialized showtimes
    private String formatMovie(Movie movie) {
        return movie.getMovieId() + "|" +
                movie.getTitle() + "|" +
                movie.getDuration() + "|" +
                movie.getReleaseDate() + "|" +
                movie.getPosterImage() + "|" +
                movie.getAvailableSeats() + "|" +
                movie.getPrice() + "|" +
                serializeShowtimes(movie.getShowtimes());
    }

    // Insertion sort movies by releaseDate ascending
    private void insertionSortByReleaseDate(List<Movie> movies) {
        for (int i = 1; i < movies.size(); i++) {
            Movie key = movies.get(i);
            int j = i - 1;
            while (j >= 0 && movies.get(j).getReleaseDate().compareTo(key.getReleaseDate()) > 0) {
                movies.set(j + 1, movies.get(j));
                j--;
            }
            movies.set(j + 1, key);
        }
    }

    // Get movie by ID
    public Movie getMovieById(String movieId) {
        List<Movie> movies = getAllMovies();
        for (Movie m : movies) {
            if (m.getMovieId().equals(movieId)) {
                return m;
            }
        }
        return null;
    }
}
