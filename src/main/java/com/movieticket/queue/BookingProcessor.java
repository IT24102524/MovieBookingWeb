package main.java.com.movieticket.queue;

import main.java.com.movieticket.dao.BookingDAO;
import main.java.com.movieticket.model.Booking;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * A processor for handling booking requests from the queue.
 * This class runs in a separate thread and continuously processes booking requests.
 */
public class BookingProcessor {
    
    private static final Logger LOGGER = Logger.getLogger(BookingProcessor.class.getName());
    private static BookingProcessor instance;
    private final BookingQueue bookingQueue;
    private final BookingDAO bookingDAO;
    private final ExecutorService executorService;
    private boolean isRunning;
    
    /**
     * Private constructor for singleton pattern
     */
    private BookingProcessor() {
        this.bookingQueue = BookingQueue.getInstance();
        this.bookingDAO = new BookingDAO();
        this.executorService = Executors.newSingleThreadExecutor();
        this.isRunning = false;
    }
    
    /**
     * Get the singleton instance of BookingProcessor
     * @return BookingProcessor instance
     */
    public static synchronized BookingProcessor getInstance() {
        if (instance == null) {
            instance = new BookingProcessor();
        }
        return instance;
    }
    
    /**
     * Start processing booking requests from the queue
     */
    public void start() {
        if (!isRunning) {
            isRunning = true;
            executorService.submit(this::processBookings);
            LOGGER.info("Booking processor started");
        }
    }
    
    /**
     * Stop processing booking requests
     */
    public void stop() {
        isRunning = false;
        executorService.shutdown();
        LOGGER.info("Booking processor stopped");
    }
    
    /**
     * Process booking requests from the queue
     */
    private void processBookings() {
        while (isRunning) {
            try {
                // Get the next booking from the queue
                Booking booking = bookingQueue.dequeueBooking();
                
                if (booking != null) {
                    LOGGER.info("Processing booking: " + booking.getBookingId());
                    
                    // Process the booking
                    boolean success = bookingDAO.createBooking(booking);
                    
                    if (success) {
                        LOGGER.info("Booking processed successfully: " + booking.getBookingId());
                    } else {
                        LOGGER.warning("Failed to process booking: " + booking.getBookingId());
                    }
                } else {
                    // No bookings in the queue, sleep for a while
                    Thread.sleep(1000);
                }
            } catch (Exception e) {
                LOGGER.log(Level.SEVERE, "Error processing booking", e);
            }
        }
    }
    
    /**
     * Check if the processor is currently running
     * @return true if the processor is running, false otherwise
     */
    public boolean isRunning() {
        return isRunning;
    }
}