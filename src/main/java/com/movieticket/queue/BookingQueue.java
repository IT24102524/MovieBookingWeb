package main.java.com.movieticket.queue;

import main.java.com.movieticket.model.Booking;
import java.util.LinkedList;
import java.util.Queue;
import java.util.concurrent.ConcurrentLinkedQueue;

/**
 * A queue implementation for handling booking requests.
 * This class provides methods to enqueue booking requests and process them in FIFO order.
 * It uses a thread-safe ConcurrentLinkedQueue to handle concurrent booking requests.
 */
public class BookingQueue {
    
    // Singleton instance
    private static BookingQueue instance;
    
    // Thread-safe queue implementation for concurrent access
    private final Queue<Booking> bookingQueue;
    
    // Private constructor for singleton pattern
    private BookingQueue() {
        this.bookingQueue = new ConcurrentLinkedQueue<>();
    }
    
    /**
     * Get the singleton instance of BookingQueue
     * @return BookingQueue instance
     */
    public static synchronized BookingQueue getInstance() {
        if (instance == null) {
            instance = new BookingQueue();
        }
        return instance;
    }
    
    /**
     * Add a booking request to the queue
     * @param booking The booking to be added to the queue
     * @return true if the booking was added successfully
     */
    public boolean enqueueBooking(Booking booking) {
        if (booking == null) {
            return false;
        }
        return bookingQueue.offer(booking);
    }
    
    /**
     * Process and remove the next booking from the queue
     * @return The next booking in the queue, or null if the queue is empty
     */
    public Booking dequeueBooking() {
        return bookingQueue.poll();
    }
    
    /**
     * View the next booking in the queue without removing it
     * @return The next booking in the queue, or null if the queue is empty
     */
    public Booking peekBooking() {
        return bookingQueue.peek();
    }
    
    /**
     * Check if the booking queue is empty
     * @return true if the queue is empty, false otherwise
     */
    public boolean isEmpty() {
        return bookingQueue.isEmpty();
    }
    
    /**
     * Get the current size of the booking queue
     * @return The number of bookings in the queue
     */
    public int size() {
        return bookingQueue.size();
    }
    
    /**
     * Clear all bookings from the queue
     */
    public void clear() {
        bookingQueue.clear();
    }
}