package com.worknest.repository;

import com.worknest.model.Task;
import com.worknest.model.User;

import java.util.List;

public interface TaskRepository extends GenericDao<Task, Long> {
	List<Task> findByAssignee(User assignee);
}

