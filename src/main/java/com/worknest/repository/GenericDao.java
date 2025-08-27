package com.worknest.repository;

import java.io.Serializable;
import java.util.List;

public interface GenericDao<T, ID extends Serializable> {
	T findById(ID id);
	List<T> findAll();
	ID save(T entity);
	void update(T entity);
	void delete(T entity);
}

