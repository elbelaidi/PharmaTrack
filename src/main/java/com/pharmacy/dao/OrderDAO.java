package com.pharmacy.dao;

import com.pharmacy.model.Order;
import com.pharmacy.model.User;
import java.util.Date;
import java.util.List;

/**
 * DAO interface for Order entity.
 */
public interface OrderDAO extends GenericDAO<Order, Long> {
    
    /**
     * Find orders by customer.
     *
     * @param customer The customer to search for
     * @return A list of orders for the specified customer
     */
    List<Order> findByCustomer(User customer);
    
    /**
     * Find orders by customer ID.
     *
     * @param customerId The ID of the customer to search for
     * @return A list of orders for the specified customer
     */
    List<Order> findByCustomerId(Long customerId);
    
    /**
     * Find orders by status.
     *
     * @param status The status to search for
     * @return A list of orders with the specified status
     */
    List<Order> findByStatus(Order.OrderStatus status);
    
    /**
     * Find orders by payment method.
     *
     * @param paymentMethod The payment method to search for
     * @return A list of orders with the specified payment method
     */
    List<Order> findByPaymentMethod(Order.PaymentMethod paymentMethod);
    
    /**
     * Find orders by payment status.
     *
     * @param paymentStatus The payment status to search for
     * @return A list of orders with the specified payment status
     */
    List<Order> findByPaymentStatus(Order.PaymentStatus paymentStatus);
    
    /**
     * Find orders created between two dates.
     *
     * @param startDate The start date
     * @param endDate The end date
     * @return A list of orders created between the specified dates
     */
    List<Order> findByOrderDateBetween(Date startDate, Date endDate);
    
    /**
     * Find orders containing a specific medicine.
     *
     * @param medicineId The ID of the medicine to search for
     * @return A list of orders containing the specified medicine
     */
    List<Order> findByMedicineId(Long medicineId);
    
    /**
     * Find orders with a total amount greater than or equal to a specified value.
     *
     * @param amount The amount to compare against
     * @return A list of orders with a total amount greater than or equal to the specified value
     */
    List<Order> findByTotalAmountGreaterThanEqual(double amount);
    
    /**
     * Update the status of an order.
     *
     * @param id The ID of the order
     * @param status The new status
     * @return true if the status was updated, false otherwise
     */
    boolean updateStatus(Long id, Order.OrderStatus status);
    
    /**
     * Update the payment status of an order.
     *
     * @param id The ID of the order
     * @param paymentStatus The new payment status
     * @return true if the payment status was updated, false otherwise
     */
    boolean updatePaymentStatus(Long id, Order.PaymentStatus paymentStatus);
}