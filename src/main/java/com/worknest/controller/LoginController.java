package com.worknest.controller;

import com.worknest.model.User;
import com.worknest.model.UserRole;
import com.worknest.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;

@Controller
public class LoginController {

	@Autowired
	private UserService userService;

	@GetMapping("/login")
	public String loginForm() {
		System.out.println("LoginController: /login GET endpoint called");
		return "login";
	}

	@GetMapping("/register")
	public String registerForm() {
		System.out.println("LoginController: /register GET endpoint called");
		return "register";
	}

	@PostMapping("/register")
	public String register(@RequestParam String username,
	                      @RequestParam String password,
	                      Model model) {
		// Check by username only
		if (userService.findByUsername(username) != null) {
			model.addAttribute("error", "User already exists");
			return "register";
		}
		userService.createUser(username.trim(), password, UserRole.USER);
		model.addAttribute("success", "Registered successfully. Please login.");
		return "login";
	}

	@PostMapping("/login")
	public String login(@RequestParam String username,
	                   @RequestParam String password,
	                   HttpSession session,
	                   Model model) {
		String uname = username == null ? null : username.trim();
		System.out.println("LoginController: authenticating username='" + uname + "'");
		User user = userService.authenticate(uname, password);
		if (user == null) {
			model.addAttribute("error", "Invalid credentials");
			return "login";
		}
		session.setAttribute("userId", user.getId());
		session.setAttribute("role", user.getRole());
		session.setAttribute("username", user.getUsername());
		
		// Add welcome message
		if (user.getRole() == UserRole.ADMIN) {
			session.setAttribute("welcomeMessage", "Welcome back, Admin! You have full system access.");
		} else {
			session.setAttribute("welcomeMessage", "Welcome back, " + user.getUsername() + "! Here are your tasks.");
		}
		
		return user.getRole() == UserRole.ADMIN ? "redirect:/admin" : "redirect:/dashboard";
	}

	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/login";
	}
	
	@GetMapping("/create-admin")
	@ResponseBody
	public String createAdmin() {
		try {
			User existing = userService.findByUsername("admin");
			if (existing == null) {
				userService.createUser("admin", "admin", UserRole.ADMIN);
				return "Admin user created (admin/admin).";
			} else {
				userService.updateUser(existing.getId(), "admin", UserRole.ADMIN);
				return "Admin user reset to admin/admin.";
			}
		} catch (Exception e) {
			return "Error creating admin: " + e.getMessage();
		}
	}

	@GetMapping("/create-demo-users")
	@ResponseBody
	public String createDemoUsers() {
		try {
			StringBuilder sb = new StringBuilder();
			User admin = userService.findByUsername("admin");
			if (admin == null) {
				admin = userService.createUser("admin", "admin", UserRole.ADMIN);
				sb.append("Admin created. ");
			} else {
				userService.updateUser(admin.getId(), "admin", UserRole.ADMIN);
				sb.append("Admin reset. ");
			}
			User demo = userService.findByUsername("user");
			if (demo == null) {
				userService.createUser("user", "user", UserRole.USER);
				sb.append("User created.");
			} else {
				userService.updateUser(demo.getId(), "user", UserRole.USER);
				sb.append("User reset.");
			}
			return sb.toString();
		} catch (Exception e) {
			return "Error creating demo users: " + e.getMessage();
		}
	}

	@GetMapping("/debug-users")
	@ResponseBody
	public String debugUsers() {
		StringBuilder sb = new StringBuilder("Users: \n");
		for (User u : userService.listUsers()) {
			sb.append(u.getId()).append(" | ").append(u.getUsername()).append(" | ").append(u.getRole()).append("\n");
		}
		return sb.toString();
	}
}

