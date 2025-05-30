package com.pharmacy.dao;

import java.util.List;

public interface BaseDAO<T> {
    T findById(Long id);
    List<T> findAll();
    T save(T entity);
    T update(T entity);
    void delete(Long id);
} 