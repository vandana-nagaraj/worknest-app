package com.worknest.service;

import com.worknest.model.Task;
import com.worknest.model.TaskStatus;

import java.util.List;
import java.time.LocalDate;

public interface TaskService {
	Task createTask(String title, String description, Long assigneeId, LocalDate startDate, LocalDate dueDate);
	List<Task> listTasksForAssignee(Long userId);
	Task updateStatus(Long taskId, TaskStatus status);
	Task findById(Long id);
	List<Task> listAllTasks();
	Task updateTask(Long taskId, String title, String description, Long assigneeId, LocalDate startDate, LocalDate dueDate, TaskStatus status);
	void deleteTask(Long taskId);
	void deleteAllTasks();
}

