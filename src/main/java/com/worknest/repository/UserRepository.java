package com.worknest.repository;

import com.worknest.model.User;

public interface UserRepository extends GenericDao<User, Long> {
	User findByUsername(String username);
}

