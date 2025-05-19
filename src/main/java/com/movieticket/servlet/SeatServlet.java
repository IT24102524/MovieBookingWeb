package main.java.com.movieticket.servlet;

import main.java.com.movieticket.dao.SeatDAO;
import main.java.com.movieticket.model.Seat;

import jakarta.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/seats")
public class SeatServlet extends HttpServlet {
    private SeatDAO dao;

    @Override
    public void init() {
        dao = new SeatDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "createForm":
                req.getRequestDispatcher("seats/create_seat_layout.jsp").forward(req, resp);
                break;
            case "editForm":
                String id = req.getParameter("id");
                Seat seat = dao.getSeatById(id);
                if (seat == null) resp.sendRedirect("seats");
                else {
                    req.setAttribute("seat", seat);
                    req.getRequestDispatcher("seats/edit_seat.jsp").forward(req, resp);
                }
                break;
            case "deleteConfirm":
                String delId = req.getParameter("id");
                Seat ds = dao.getSeatById(delId);
                if (ds == null) resp.sendRedirect("seats");
                else {
                    req.setAttribute("seat", ds);
                    req.getRequestDispatcher("seats/delete_seat_confirm.jsp").forward(req, resp);
                }
                break;
            case "list":
            default:
                List<Seat> seats = dao.getAllSeats();
                req.setAttribute("seats", seats);
                req.getRequestDispatcher("seats/seats.jsp").forward(req, resp);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "create":
                createSeat(req, resp);
                break;
            case "update":
                updateSeat(req, resp);
                break;
            case "delete":
                deleteSeat(req, resp);
                break;
            default:
                resp.sendRedirect("seats");
                break;
        }
    }

    private void createSeat(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String seatId = req.getParameter("seatId");
        String showtimeId = req.getParameter("showtimeId");
        String seatNumber = req.getParameter("seatNumber");
        boolean isBlocked = Boolean.parseBoolean(req.getParameter("isBlocked"));

        Seat seat = new Seat(seatId, showtimeId, seatNumber, isBlocked);
        dao.createSeat(seat);
        resp.sendRedirect("seats");
    }

    private void updateSeat(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String seatId = req.getParameter("seatId");
        String showtimeId = req.getParameter("showtimeId");
        String seatNumber = req.getParameter("seatNumber");
        boolean isBlocked = Boolean.parseBoolean(req.getParameter("isBlocked"));

        Seat seat = new Seat(seatId, showtimeId, seatNumber, isBlocked);
        dao.updateSeat(seat);
        resp.sendRedirect("seats");
    }

    private void deleteSeat(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String seatId = req.getParameter("seatId");
        dao.deleteSeat(seatId);
        resp.sendRedirect("seats");
    }
}
