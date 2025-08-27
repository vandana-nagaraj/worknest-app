package com.worknest.service;

import com.worknest.model.User;
import com.worknest.model.UserRole;

import java.util.List;

public interface UserService {
	User authenticate(String username, String password);
	User createUser(String username, String password, UserRole role);
	User findByUsername(String username);
	List<User> listUsers();
	User findById(Long id);
	void deleteUser(Long id);
	User updateUser(Long id, String password, UserRole role);
}

