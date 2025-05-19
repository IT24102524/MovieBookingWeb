package servlet;

import model.Payment;
import dao.PaymentDAO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/payments/*")
public class PaymentServlet extends HttpServlet {
    private PaymentDAO paymentDAO;

    @Override
    public void init() throws ServletException {
        paymentDAO = new PaymentDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getPathInfo();
        if (action == null || action.equals("/")) {
            List<Payment> payments = paymentDAO.getAllPayments();
            request.setAttribute("payments", payments);
            request.getRequestDispatcher("/index.jsp").forward(request, response);
        } else if (action.equals("/edit")) {
            int id = Integer.parseInt(request.getParameter("id"));
            Payment payment = paymentDAO.getAllPayments().stream()
                .filter(p -> p.getId() == id)
                .findFirst()
                .orElse(null);
            request.setAttribute("payment", payment);
            request.getRequestDispatcher("/paymentForm.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getPathInfo();
        if (action.equals("/create")) {
            Payment payment = new Payment();
            payment.setAmount(Double.parseDouble(request.getParameter("amount")));
            payment.setDescription(request.getParameter("description"));
            paymentDAO.createPayment(payment);
            response.sendRedirect(request.getContextPath() + "/payments");
        } else if (action.equals("/update")) {
            int id = Integer.parseInt(request.getParameter("id"));
            Payment payment = new Payment();
            payment.setAmount(Double.parseDouble(request.getParameter("amount")));
            payment.setDescription(request.getParameter("description"));
            paymentDAO.updatePayment(id, payment);
            response.sendRedirect(request.getContextPath() + "/payments");
        } else if (action.equals("/delete")) {
            int id = Integer.parseInt(request.getParameter("id"));
            paymentDAO.deletePayment(id);
            response.sendRedirect(request.getContextPath() + "/payments");
        }
    }
}