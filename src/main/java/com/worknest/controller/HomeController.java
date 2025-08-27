package com.worknest.controller;

import com.worknest.model.Task;
import com.worknest.model.User;
import com.worknest.service.TaskService;
import com.worknest.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class HomeController {

    @Autowired
    private TaskService taskService;

    	@Autowired
	private UserService userService;

	@GetMapping("/")
	public String home() {
		System.out.println("HomeController: / endpoint called");
		return "index";
	}
	
	@GetMapping("/health")
	@ResponseBody
	public String health() {
		System.out.println("HomeController: /health endpoint called");
		return "Application is running! All systems operational.";
	}

	@GetMapping("/dashboard")
	public String dashboard(Model model, HttpSession session) {
		System.out.println("HomeController: /dashboard endpoint called");
		// Check if user is logged in
		Long userId = (Long) session.getAttribute("userId");
		Object roleObj = session.getAttribute("role");
		String userRole = roleObj != null ? roleObj.toString() : null;
		String username = (String) session.getAttribute("username");

		if (userId != null) {
			// User is logged in - show dashboard
			model.addAttribute("isLoggedIn", true);
			model.addAttribute("username", username);
			model.addAttribute("userRole", userRole);
			
			// Get user's recent tasks
			List<Task> recentTasks = taskService.listTasksForAssignee(userId);
			if (recentTasks.size() > 5) {
				recentTasks = recentTasks.subList(0, 5); // Show only 5 most recent
			}
			model.addAttribute("recentTasks", recentTasks);
			
			// Get task statistics
			long totalTasks = taskService.listTasksForAssignee(userId).size();
			long completedTasks = taskService.listTasksForAssignee(userId).stream()
					.filter(task -> task.getStatus().toString().equals("COMPLETED"))
					.count();
			long pendingTasks = totalTasks - completedTasks;
			
			model.addAttribute("totalTasks", totalTasks);
			model.addAttribute("completedTasks", completedTasks);
			model.addAttribute("pendingTasks", pendingTasks);
			
			return "dashboard";
		} else {
			// User is not logged in - redirect to login
			return "redirect:/login";
		}
	}

    
}
