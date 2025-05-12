package com.pharmacy.model;

import java.sql.Timestamp;

/**
 * Represents a user in the pharmacy system.
 * Users can be administrators, pharmacists, or customers.
 */
public class User {
    private Long id;
    private String username;
    private String password;
    private String fullName;
    private String email;
    private String role;
    private String phoneNumber;
    private boolean active;
    private Timestamp createdAt;
    private Timestamp lastLogin;

    // Enum for user roles
    public enum UserRole {
        ADMIN,
        PHARMACIST,
        CUSTOMER
    }

    // Default constructor
    public User() {
        this.createdAt = new Timestamp(System.currentTimeMillis());
        this.lastLogin = new Timestamp(System.currentTimeMillis());
    }

    // Parameterized constructor
    public User(String username, String password, String email, String firstName, String lastName, 
                String phoneNumber, String address, java.util.Date dateOfBirth, UserRole role) {
        this.username = username;
        this.password = password;
        this.email = email;
        this.fullName = firstName + " " + lastName;
        this.phoneNumber = phoneNumber;
        this.role = role.name();
        this.active = true;
        this.createdAt = new Timestamp(System.currentTimeMillis());
        this.lastLogin = new Timestamp(System.currentTimeMillis());
    }

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getLastLogin() {
        return lastLogin;
    }

    public void setLastLogin(Timestamp lastLogin) {
        this.lastLogin = lastLogin;
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", email='" + email + '\'' +
                ", fullName='" + fullName + '\'' +
                ", phoneNumber='" + phoneNumber + '\'' +
                ", role=" + role +
                ", active=" + active +
                ", createdAt=" + createdAt +
                ", lastLogin=" + lastLogin +
                '}';
    }
}