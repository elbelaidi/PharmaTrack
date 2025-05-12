package com.pharmacy.model;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Represents an order in the pharmacy system.
 */
public class Order {
    private Long id;
    private User customer;
    private List<OrderItem> orderItems;
    private Date orderDate;
    private OrderStatus status;
    private BigDecimal totalAmount;
    private PaymentMethod paymentMethod;
    private PaymentStatus paymentStatus;
    private String deliveryAddress;
    private Date deliveryDate;
    private String trackingNumber;
    private String notes;
    private Date createdAt;
    private Date updatedAt;

    // Enum for order status
    public enum OrderStatus {
        PENDING,
        PROCESSING,
        SHIPPED,
        DELIVERED,
        CANCELLED
    }

    // Enum for payment method
    public enum PaymentMethod {
        CREDIT_CARD,
        DEBIT_CARD,
        CASH_ON_DELIVERY,
        INSURANCE,
        BANK_TRANSFER
    }

    // Enum for payment status
    public enum PaymentStatus {
        PENDING,
        PAID,
        FAILED,
        REFUNDED
    }

    // Default constructor
    public Order() {
        this.orderItems = new ArrayList<>();
        this.orderDate = new Date();
        this.status = OrderStatus.PENDING;
        this.paymentStatus = PaymentStatus.PENDING;
        this.totalAmount = BigDecimal.ZERO;
        this.createdAt = new Date();
        this.updatedAt = new Date();
    }

    // Parameterized constructor
    public Order(User customer, PaymentMethod paymentMethod, String deliveryAddress, String notes) {
        this.customer = customer;
        this.orderItems = new ArrayList<>();
        this.orderDate = new Date();
        this.status = OrderStatus.PENDING;
        this.totalAmount = BigDecimal.ZERO;
        this.paymentMethod = paymentMethod;
        this.paymentStatus = PaymentStatus.PENDING;
        this.deliveryAddress = deliveryAddress;
        this.notes = notes;
        this.createdAt = new Date();
        this.updatedAt = new Date();
    }

    // Inner class for order items
    public static class OrderItem {
        private Long id;
        private Medicine medicine;
        private int quantity;
        private BigDecimal unitPrice;
        private BigDecimal subtotal;
        private Prescription prescription; // Optional, for prescription medicines

        // Default constructor
        public OrderItem() {
            this.unitPrice = BigDecimal.ZERO;
            this.subtotal = BigDecimal.ZERO;
        }

        // Parameterized constructor
        public OrderItem(Medicine medicine, int quantity, BigDecimal unitPrice) {
            this.medicine = medicine;
            this.quantity = quantity;
            this.unitPrice = unitPrice;
            this.subtotal = unitPrice.multiply(BigDecimal.valueOf(quantity));
        }

        // Parameterized constructor with prescription
        public OrderItem(Medicine medicine, int quantity, BigDecimal unitPrice, Prescription prescription) {
            this.medicine = medicine;
            this.quantity = quantity;
            this.unitPrice = unitPrice;
            this.subtotal = unitPrice.multiply(BigDecimal.valueOf(quantity));
            this.prescription = prescription;
        }

        // Calculate subtotal
        public void calculateSubtotal() {
            this.subtotal = this.unitPrice.multiply(BigDecimal.valueOf(this.quantity));
        }

        // Getters and Setters
        public Long getId() {
            return id;
        }

        public void setId(Long id) {
            this.id = id;
        }

        public Medicine getMedicine() {
            return medicine;
        }

        public void setMedicine(Medicine medicine) {
            this.medicine = medicine;
        }

        public int getQuantity() {
            return quantity;
        }

        public void setQuantity(int quantity) {
            this.quantity = quantity;
            calculateSubtotal();
        }

        public BigDecimal getUnitPrice() {
            return unitPrice;
        }

        public void setUnitPrice(BigDecimal unitPrice) {
            this.unitPrice = unitPrice;
            calculateSubtotal();
        }

        public BigDecimal getSubtotal() {
            return subtotal;
        }

        public void setSubtotal(BigDecimal subtotal) {
            this.subtotal = subtotal;
        }

        public Prescription getPrescription() {
            return prescription;
        }

        public void setPrescription(Prescription prescription) {
            this.prescription = prescription;
        }

        @Override
        public String toString() {
            return "OrderItem{" +
                    "id=" + id +
                    ", medicine=" + (medicine != null ? medicine.getName() : "null") +
                    ", quantity=" + quantity +
                    ", unitPrice=" + unitPrice +
                    ", subtotal=" + subtotal +
                    ", prescription=" + (prescription != null ? prescription.getId() : "null") +
                    '}';
        }
    }

    // Methods to add and remove order items
    public void addOrderItem(OrderItem item) {
        this.orderItems.add(item);
        calculateTotalAmount();
    }

    public void removeOrderItem(OrderItem item) {
        this.orderItems.remove(item);
        calculateTotalAmount();
    }

    // Calculate total amount
    public void calculateTotalAmount() {
        this.totalAmount = BigDecimal.ZERO;
        for (OrderItem item : this.orderItems) {
            this.totalAmount = this.totalAmount.add(item.getSubtotal());
        }
    }

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public User getCustomer() {
        return customer;
    }

    public void setCustomer(User customer) {
        this.customer = customer;
    }

    public List<OrderItem> getOrderItems() {
        return orderItems;
    }

    public void setOrderItems(List<OrderItem> orderItems) {
        this.orderItems = orderItems;
        calculateTotalAmount();
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public OrderStatus getStatus() {
        return status;
    }

    public void setStatus(OrderStatus status) {
        this.status = status;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }

    public PaymentMethod getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(PaymentMethod paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public PaymentStatus getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(PaymentStatus paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public String getDeliveryAddress() {
        return deliveryAddress;
    }

    public void setDeliveryAddress(String deliveryAddress) {
        this.deliveryAddress = deliveryAddress;
    }

    public Date getDeliveryDate() {
        return deliveryDate;
    }

    public void setDeliveryDate(Date deliveryDate) {
        this.deliveryDate = deliveryDate;
    }

    public String getTrackingNumber() {
        return trackingNumber;
    }

    public void setTrackingNumber(String trackingNumber) {
        this.trackingNumber = trackingNumber;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public Date getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
    }

    @Override
    public String toString() {
        return "Order{" +
                "id=" + id +
                ", customer=" + (customer != null ? customer.getUsername() : "null") +
                ", orderItems=" + orderItems +
                ", orderDate=" + orderDate +
                ", status=" + status +
                ", totalAmount=" + totalAmount +
                ", paymentMethod=" + paymentMethod +
                ", paymentStatus=" + paymentStatus +
                ", deliveryAddress='" + deliveryAddress + '\'' +
                ", deliveryDate=" + deliveryDate +
                ", trackingNumber='" + trackingNumber + '\'' +
                ", notes='" + notes + '\'' +
                ", createdAt=" + createdAt +
                ", updatedAt=" + updatedAt +
                '}';
    }
}