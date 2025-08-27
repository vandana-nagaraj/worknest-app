package com.worknest.controller;

import com.worknest.model.Task;
import com.worknest.model.TaskStatus;
import com.worknest.model.User;
import com.worknest.model.UserRole;
import com.worknest.service.TaskService;
import com.worknest.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.PathVariable;

import javax.servlet.http.HttpSession;
import java.time.LocalDate;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.List;

@Controller
public class AdminController {

	@Autowired
	private UserService userService;

	@Autowired
	private TaskService taskService;

	private boolean isAdmin(HttpSession session) {
		Object role = session.getAttribute("role");
		if (role instanceof UserRole) {
			return role == UserRole.ADMIN;
		}
		if (role instanceof String) {
			return "ADMIN".equals(role);
		}
		return false;
	}

	@GetMapping("/admin")
	public String adminHome(Model model, HttpSession session) {
		if (!isAdmin(session)) return "redirect:/login";
		List<User> users = userService.listUsers();
		model.addAttribute("users", users);
		List<Task> tasks = taskService.listAllTasks();
		Map<String, Long> counts = tasks.stream().collect(Collectors.groupingBy(t -> {
			if (t.isDelayed()) return "DELAYED";
			return t.getStatus().name();
		}, Collectors.counting()));
		model.addAttribute("counts", counts);
		model.addAttribute("allTasks", tasks);
		return "admin";
	}

	@PostMapping("/admin/user/create")
	public String createUser(@RequestParam String username,
	                        @RequestParam String password,
	                        @RequestParam String role,
	                        HttpSession session) {
		if (!isAdmin(session)) return "redirect:/login";
		userService.createUser(username, password, UserRole.valueOf(role));
		return "redirect:/admin";
	}

	@PostMapping("/admin/user/update")
	public String updateUser(@RequestParam Long id,
	                        @RequestParam(required=false) String password,
	                        @RequestParam(required=false) String role,
	                        HttpSession session) {
		if (!isAdmin(session)) return "redirect:/login";
		userService.updateUser(id, password, role == null ? null : UserRole.valueOf(role));
		return "redirect:/admin";
	}

	@PostMapping("/admin/user/delete")
	public String deleteUser(@RequestParam Long id, HttpSession session) {
		if (!isAdmin(session)) return "redirect:/login";
		userService.deleteUser(id);
		return "redirect:/admin";
	}

	@PostMapping("/admin/task/create")
	public String createTask(@RequestParam String title,
	                        @RequestParam String description,
	                        @RequestParam Long assigneeId,
	                        @RequestParam(required=false) String startDate,
	                        @RequestParam(required=false) String dueDate,
	                        HttpSession session) {
		if (!isAdmin(session)) return "redirect:/login";
		LocalDate sd = (startDate == null || startDate.isEmpty()) ? null : LocalDate.parse(startDate);
		LocalDate dd = (dueDate == null || dueDate.isEmpty()) ? null : LocalDate.parse(dueDate);
		taskService.createTask(title, description, assigneeId, sd, dd);
		return "redirect:/admin";
	}

	@GetMapping("/admin/tasks/{id}")
	public String taskDetail(@PathVariable("id") Long id, Model model, HttpSession session) {
		if (!isAdmin(session)) return "redirect:/login";
		Task task = taskService.findById(id);
		if (task == null) return "redirect:/admin";
		model.addAttribute("task", task);
		model.addAttribute("statuses", TaskStatus.values());
		model.addAttribute("users", userService.listUsers());
		return "admin_task";
	}

	@PostMapping("/admin/tasks/{id}/update")
	public String updateTask(@PathVariable("id") Long id,
	                        @RequestParam String title,
	                        @RequestParam String description,
	                        @RequestParam(required=false) Long assigneeId,
	                        @RequestParam(required=false) String startDate,
	                        @RequestParam(required=false) String dueDate,
	                        @RequestParam(required=false) String status,
	                        HttpSession session) {
		if (!isAdmin(session)) return "redirect:/login";
		LocalDate sd = (startDate == null || startDate.isEmpty()) ? null : LocalDate.parse(startDate);
		LocalDate dd = (dueDate == null || dueDate.isEmpty()) ? null : LocalDate.parse(dueDate);
		TaskStatus st = (status == null || status.isEmpty()) ? null : TaskStatus.valueOf(status);
		taskService.updateTask(id, title, description, assigneeId, sd, dd, st);
		return "redirect:/admin/tasks/" + id;
	}

	@PostMapping("/admin/tasks/{id}/delete")
	public String deleteTask(@PathVariable("id") Long id, HttpSession session) {
		if (!isAdmin(session)) return "redirect:/login";
		taskService.deleteTask(id);
		return "redirect:/admin";
	}

	@PostMapping("/admin/tasks/clear")
	public String clearAllTasks(HttpSession session) {
		if (!isAdmin(session)) return "redirect:/login";
		taskService.deleteAllTasks();
		return "redirect:/admin";
	}
}

