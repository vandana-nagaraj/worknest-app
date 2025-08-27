package com.worknest.repository.impl;

import com.worknest.repository.GenericDao;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.io.Serializable;
import java.lang.reflect.ParameterizedType;
import java.util.List;

@Repository
public abstract class GenericDaoHibernate<T, ID extends Serializable> implements GenericDao<T, ID> {

	@Autowired
	protected SessionFactory sessionFactory;

	private final Class<T> persistentClass;

	@SuppressWarnings("unchecked")
	public GenericDaoHibernate() {
		this.persistentClass = (Class<T>) ((ParameterizedType) getClass()
				.getGenericSuperclass()).getActualTypeArguments()[0];
	}

	protected Session currentSession() {
		return sessionFactory.getCurrentSession();
	}

	@Override
	public T findById(ID id) {
		return currentSession().get(persistentClass, id);
	}

	@Override
	public List<T> findAll() {
		return currentSession()
			.createQuery("from " + persistentClass.getSimpleName(), persistentClass)
			.list();
	}

	@Override
	public ID save(T entity) {
		return (ID) currentSession().save(entity);
	}

	@Override
	public void update(T entity) {
		currentSession().merge(entity);
	}

	@Override
	public void delete(T entity) {
		currentSession().delete(entity);
	}
}

