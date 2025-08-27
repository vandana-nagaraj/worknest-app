package com.worknest.controller;

import com.worknest.model.Task;
import com.worknest.model.TaskStatus;
import com.worknest.service.CommentService;
import com.worknest.service.TaskService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class TaskController {

	@Autowired
	private TaskService taskService;

	@Autowired
	private CommentService commentService;

	private Long currentUserId(HttpSession session) {
		Object uid = session.getAttribute("userId");
		return uid == null ? null : (Long) uid;
	}

	@GetMapping("/tasks")
	public String myTasks(Model model, HttpSession session) {
		Long uid = currentUserId(session);
		System.out.println("TaskController: myTasks called, uid=" + uid);
		if (uid == null) return "redirect:/login";
		List<Task> tasks = taskService.listTasksForAssignee(uid);
		System.out.println("TaskController: found " + tasks.size() + " tasks for user " + uid);
		for (Task t : tasks) {
			System.out.println("TaskController: Task ID=" + t.getId() + ", Title=" + t.getTitle() + ", Assignee=" + (t.getAssignee() != null ? t.getAssignee().getId() : "null"));
		}
		model.addAttribute("tasks", tasks);
		model.addAttribute("statuses", TaskStatus.values());
		return "tasks";
	}

	@PostMapping("/tasks/{id}/status")
	public String updateStatus(@PathVariable("id") Long id,
	                          @RequestParam("status") String status,
	                          HttpSession session,
	                          RedirectAttributes redirectAttributes) {
		System.out.println("TaskController: updateStatus called for taskId=" + id + ", status=" + status);
		Long uid = currentUserId(session);
		System.out.println("TaskController: currentUserId from session=" + uid);
		if (uid == null) {
		    redirectAttributes.addFlashAttribute("errorMessage", "You must be logged in to update task status.");
		    return "redirect:/login";
		}
		Task task = taskService.findById(id);
		System.out.println("TaskController: found task=" + (task != null ? task.getTitle() : "null"));
		if (task == null) {
			System.out.println("TaskController: updateStatus task not found id=" + id);
			session.setAttribute("errorMessage", "Task not found.");
			return "redirect:/tasks";
		}
		Long assigneeId = task.getAssignee() != null ? task.getAssignee().getId() : null;
		System.out.println("TaskController: task assigneeId=" + assigneeId + ", comparing with uid=" + uid);
		if (assigneeId == null || !uid.equals(assigneeId)) {
			System.out.println("TaskController: updateStatus rejected. uid=" + uid + ", assigneeId=" + assigneeId + ", taskId=" + id);
			session.setAttribute("errorMessage", "You can only update your own tasks.");
			return "redirect:/tasks";
		}
		TaskStatus newStatus;
		try {
			newStatus = TaskStatus.valueOf(status);
			System.out.println("TaskController: parsed status=" + newStatus);
		} catch (IllegalArgumentException ex) {
			System.out.println("TaskController: invalid status '" + status + "'");
			session.setAttribute("errorMessage", "Invalid status.");
			return "redirect:/tasks";
		}
		if (newStatus == TaskStatus.DELAYED) {
			session.setAttribute("errorMessage", "Cannot set status to DELAYED manually.");
			return "redirect:/tasks";
		}
		try {
		    System.out.println("TaskController: calling taskService.updateStatus for taskId: " + id + ", new status: " + newStatus);
		    taskService.updateStatus(id, newStatus);
		    System.out.println("TaskController: status update completed successfully");
		    redirectAttributes.addFlashAttribute("successMessage", "Task status updated successfully!");
		} catch (Exception e) {
		    System.err.println("Error updating task status: " + e.getMessage());
		    e.printStackTrace();
		    redirectAttributes.addFlashAttribute("errorMessage", "Failed to update task status: " + e.getMessage());
		}
		return "redirect:/tasks";
	}

	@PostMapping("/tasks/{id}/comments")
	public String addComment(@PathVariable("id") Long id,
	                        @RequestParam("text") String text,
	                        HttpSession session) {
		Long uid = currentUserId(session);
		if (uid == null) return "redirect:/login";
		Task task = taskService.findById(id);
		if (task == null || task.getAssignee() == null || !uid.equals(task.getAssignee().getId())) {
			return "redirect:/tasks";
		}
		commentService.addComment(id, uid, text);
		return "redirect:/tasks";
	}
}

