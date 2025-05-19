# Booking Queue Implementation

This package contains a queue implementation for handling booking requests in the Movie Ticket Reservation system. The queue provides a way to handle concurrent booking requests and process them asynchronously.

## Components

### BookingQueue

The `BookingQueue` class implements a queue data structure for storing booking requests. It uses a thread-safe `ConcurrentLinkedQueue` to handle concurrent access from multiple threads. The class follows the Singleton pattern to ensure only one instance of the queue exists throughout the application.

Key methods:
- `getInstance()`: Get the singleton instance of the queue
- `enqueueBooking(Booking)`: Add a booking request to the queue
- `dequeueBooking()`: Remove and return the next booking from the queue
- `peekBooking()`: View the next booking without removing it
- `isEmpty()`: Check if the queue is empty
- `size()`: Get the number of bookings in the queue
- `clear()`: Remove all bookings from the queue

### BookingProcessor

The `BookingProcessor` class is responsible for processing booking requests from the queue. It runs in a separate thread and continuously checks for new booking requests. When a request is found, it uses the `BookingDAO` to create the booking in the system.

Key methods:
- `getInstance()`: Get the singleton instance of the processor
- `start()`: Start processing booking requests
- `stop()`: Stop processing booking requests
- `isRunning()`: Check if the processor is running

## Integration with BookingServlet

The `BookingServlet` has been modified to use the booking queue for handling booking requests. When a user finalizes a booking, the servlet creates a `Booking` object and adds it to the queue instead of directly saving it to the file. The `BookingProcessor` then processes the booking asynchronously.

## Usage Example

```java
// Get the booking queue instance
BookingQueue bookingQueue = BookingQueue.getInstance();

// Get the booking processor instance
BookingProcessor bookingProcessor = BookingProcessor.getInstance();

// Start the booking processor
bookingProcessor.start();

// Create a booking
Booking booking = new Booking();
booking.setBookingId("booking-1");
booking.setUserId("user-1");
booking.setShowtimeId("showtime-1");
booking.setSeatId("seat-1");
booking.setBookingDate("2023-05-15");
booking.setPaid(false);

// Add the booking to the queue
boolean enqueued = bookingQueue.enqueueBooking(booking);

// Stop the booking processor when done
bookingProcessor.stop();
```

See the `BookingQueueTest` class for a complete example of how to use the booking queue.

## Benefits

- **Asynchronous Processing**: Booking requests are processed in the background, allowing the user interface to remain responsive.
- **Concurrency Handling**: The queue can handle multiple booking requests concurrently without conflicts.
- **Scalability**: The queue can be easily scaled to handle a large number of booking requests.
- **Fault Tolerance**: If a booking request fails, it doesn't affect other requests in the queue.