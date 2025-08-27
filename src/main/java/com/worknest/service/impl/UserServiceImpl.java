package com.worknest.service.impl;

import com.worknest.model.User;
import com.worknest.model.UserRole;
import com.worknest.repository.UserRepository;
import com.worknest.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class UserServiceImpl implements UserService {

	@Autowired
	private UserRepository userRepository;

	@Override
	public User authenticate(String username, String password) {
		User user = userRepository.findByUsername(username);
		if (user != null && user.getPassword().equals(password)) {
			return user;
		}
		return null;
	}

	@Override
	public User createUser(String username, String password, UserRole role) {
		User u = new User();
		u.setUsername(username);
		u.setPassword(password);
		u.setRole(role);
		Long id = userRepository.save(u);
		u.setId(id);
		return u;
	}

	@Override
	public User findByUsername(String username) {
		return userRepository.findByUsername(username);
	}

	@Override
	public List<User> listUsers() {
		return userRepository.findAll();
	}

	@Override
	public User findById(Long id) {
		return userRepository.findById(id);
	}

	@Override
	public void deleteUser(Long id) {
		User u = userRepository.findById(id);
		if (u != null) {
			userRepository.delete(u);
		}
	}

	@Override
	public User updateUser(Long id, String password, UserRole role) {
		User u = userRepository.findById(id);
		if (u == null) return null;
		if (password != null && !password.isEmpty()) u.setPassword(password);
		if (role != null) u.setRole(role);
		userRepository.update(u);
		return u;
	}
}

