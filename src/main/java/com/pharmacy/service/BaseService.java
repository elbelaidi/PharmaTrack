package com.pharmacy.service;

import java.util.List;

public interface BaseService<T> {
    T findById(Long id);
    List<T> findAll();
    T save(T entity);
    T update(T entity);
    void delete(Long id);
} 