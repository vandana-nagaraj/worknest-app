package com.worknest.service.impl;

import com.worknest.model.Task;
import com.worknest.model.TaskStatus;
import com.worknest.model.User;
import com.worknest.repository.TaskRepository;
import com.worknest.repository.UserRepository;
import com.worknest.service.TaskService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.time.LocalDate;

@Service
@Transactional
public class TaskServiceImpl implements TaskService {

	@Autowired
	private TaskRepository taskRepository;

	@Autowired
	private UserRepository userRepository;

	@Override
	public Task createTask(String title, String description, Long assigneeId, LocalDate startDate, LocalDate dueDate) {
		User assignee = userRepository.findById(assigneeId);
		Task t = new Task();
		t.setTitle(title);
		t.setDescription(description);
		t.setAssignee(assignee);
		t.setStartDate(startDate);
		t.setDueDate(dueDate);
		Long id = taskRepository.save(t);
		t.setId(id);
		return t;
	}

	@Override
	public List<Task> listTasksForAssignee(Long userId) {
		User u = userRepository.findById(userId);
		return taskRepository.findByAssignee(u);
	}

	@Override
	public Task updateStatus(Long taskId, TaskStatus status) {
		Task t = taskRepository.findById(taskId);
		t.setStatus(status);
		taskRepository.update(t);
		return t;
	}

	@Override
	public Task findById(Long id) {
		return taskRepository.findById(id);
	}

	@Override
	public List<Task> listAllTasks() {
		return taskRepository.findAll();
	}

	@Override
	public Task updateTask(Long taskId, String title, String description, Long assigneeId, LocalDate startDate, LocalDate dueDate, TaskStatus status) {
		Task t = taskRepository.findById(taskId);
		if (t == null) {
			return null;
		}
		if (title != null && !title.trim().isEmpty()) t.setTitle(title);
		if (description != null) t.setDescription(description);
		if (assigneeId != null) {
			User newAssignee = userRepository.findById(assigneeId);
			t.setAssignee(newAssignee);
		}
		t.setStartDate(startDate);
		t.setDueDate(dueDate);
		if (status != null) t.setStatus(status);
		taskRepository.update(t);
		return t;
	}

	@Override
	public void deleteTask(Long taskId) {
		Task t = taskRepository.findById(taskId);
		if (t != null) {
			taskRepository.delete(t);
		}
	}

	@Override
	public void deleteAllTasks() {
		for (Task t : taskRepository.findAll()) {
			taskRepository.delete(t);
		}
	}
}

