package com.worknest.config;

import com.worknest.model.Task;
import com.worknest.model.TaskStatus;
import com.worknest.model.User;
import com.worknest.model.UserRole;
import com.worknest.repository.TaskRepository;
import com.worknest.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;

@Component
public class DataInitializer implements ApplicationListener<ContextRefreshedEvent> {

	@Autowired
	private UserRepository userRepository;
	
	@Autowired
	private TaskRepository taskRepository;

	@Override
	@Transactional
	public void onApplicationEvent(ContextRefreshedEvent event) {
		// Only run for the root application context, not for child contexts
		if (event.getApplicationContext().getParent() == null) {
			initializeData();
		}
	}
	
	@Transactional
	private void initializeData() {
		try {
			// Upsert demo users so credentials are always as expected
			User admin = userRepository.findByUsername("admin");
			if (admin == null) {
				admin = new User();
				admin.setUsername("admin");
				admin.setRole(UserRole.ADMIN);
				admin.setPassword("admin");
				userRepository.save(admin);
			} else {
				admin.setPassword("admin");
				admin.setRole(UserRole.ADMIN);
				userRepository.update(admin);
			}
			
			User user = userRepository.findByUsername("user");
			if (user == null) {
				user = new User();
				user.setUsername("user");
				user.setRole(UserRole.USER);
				user.setPassword("user");
				userRepository.save(user);
			} else {
				user.setPassword("user");
				user.setRole(UserRole.USER);
				userRepository.update(user);
			}
			
			// Do not create sample tasks; leave task list empty by default
		} catch (Exception e) {
			// Log the error but don't fail the application startup
			System.err.println("Failed to initialize data: " + e.getMessage());
		}
	}
	
	private void createSampleTasks(User admin, User user) {
		// Task 1 - Completed task
		Task task1 = new Task();
		task1.setTitle("Complete Project Setup");
		task1.setDescription("Set up the development environment and configure all necessary tools");
		task1.setStatus(TaskStatus.COMPLETED);
		task1.setAssignee(user);
		task1.setStartDate(LocalDate.now().minusDays(5));
		task1.setDueDate(LocalDate.now().minusDays(2));
		taskRepository.save(task1);
		
		// Task 2 - In Progress task
		Task task2 = new Task();
		task2.setTitle("Design User Interface");
		task2.setDescription("Create wireframes and mockups for the new user interface");
		task2.setStatus(TaskStatus.IN_PROGRESS);
		task2.setAssignee(user);
		task2.setStartDate(LocalDate.now().minusDays(3));
		task2.setDueDate(LocalDate.now().plusDays(5));
		taskRepository.save(task2);
		
		// Task 3 - Pending task
		Task task3 = new Task();
		task3.setTitle("Write Documentation");
		task3.setDescription("Create comprehensive documentation for the project");
		task3.setStatus(TaskStatus.PENDING);
		task3.setAssignee(user);
		task3.setStartDate(LocalDate.now().plusDays(1));
		task3.setDueDate(LocalDate.now().plusDays(10));
		taskRepository.save(task3);
		
		// Task 4 - Admin task
		Task task4 = new Task();
		task4.setTitle("Review Code Changes");
		task4.setDescription("Review and approve recent code changes from the development team");
		task4.setStatus(TaskStatus.PENDING);
		task4.setAssignee(admin);
		task4.setStartDate(LocalDate.now());
		task4.setDueDate(LocalDate.now().plusDays(3));
		taskRepository.save(task4);
	}
}

