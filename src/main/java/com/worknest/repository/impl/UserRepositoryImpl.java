package com.worknest.repository.impl;

import com.worknest.model.User;
import com.worknest.repository.UserRepository;
import org.hibernate.query.Query;
import org.springframework.stereotype.Repository;

@Repository
public class UserRepositoryImpl extends GenericDaoHibernate<User, Long> implements UserRepository {
	@Override
	public User findByUsername(String username) {
		Query<User> q = currentSession().createQuery("from User u where u.username = :username", User.class);
		q.setParameter("username", username);
		return q.uniqueResult();
	}
}

