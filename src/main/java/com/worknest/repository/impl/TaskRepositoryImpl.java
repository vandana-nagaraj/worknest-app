package com.worknest.repository.impl;

import com.worknest.model.Task;
import com.worknest.model.User;
import com.worknest.repository.TaskRepository;
import org.hibernate.query.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class TaskRepositoryImpl extends GenericDaoHibernate<Task, Long> implements TaskRepository {
	@Override
	public List<Task> findByAssignee(User assignee) {
		Query<Task> q = currentSession().createQuery("from Task t where t.assignee = :assignee order by t.createdAt desc", Task.class);
		q.setParameter("assignee", assignee);
		return q.list();
	}
}

