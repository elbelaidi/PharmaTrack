package com.pharmacy.dao;

import java.util.List;
import java.util.Optional;

/**
 * Generic DAO interface that defines common CRUD operations.
 *
 * @param <T> The entity type
 * @param <ID> The ID type
 */
public interface GenericDAO<T, ID> {
    
    /**
     * Save an entity to the database.
     *
     * @param entity The entity to save
     * @return The saved entity with its ID populated
     */
    T save(T entity);
    
    /**
     * Update an existing entity in the database.
     *
     * @param entity The entity to update
     * @return The updated entity
     */
    T update(T entity);
    
    /**
     * Find an entity by its ID.
     *
     * @param id The ID of the entity to find
     * @return An Optional containing the entity if found, or empty if not found
     */
    Optional<T> findById(ID id);
    
    /**
     * Find all entities.
     *
     * @return A list of all entities
     */
    List<T> findAll();
    
    /**
     * Delete an entity by its ID.
     *
     * @param id The ID of the entity to delete
     * @return true if the entity was deleted, false otherwise
     */
    boolean deleteById(ID id);
    
    /**
     * Delete an entity.
     *
     * @param entity The entity to delete
     * @return true if the entity was deleted, false otherwise
     */
    boolean delete(T entity);
    
    /**
     * Check if an entity with the given ID exists.
     *
     * @param id The ID to check
     * @return true if an entity with the given ID exists, false otherwise
     */
    boolean existsById(ID id);
    
    /**
     * Count the number of entities.
     *
     * @return The number of entities
     */
    long count();
}