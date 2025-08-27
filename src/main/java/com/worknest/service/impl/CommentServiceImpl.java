package com.worknest.service.impl;

import com.worknest.model.Comment;
import com.worknest.model.Task;
import com.worknest.model.User;
import com.worknest.repository.CommentRepository;
import com.worknest.repository.TaskRepository;
import com.worknest.repository.UserRepository;
import com.worknest.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class CommentServiceImpl implements CommentService {

	@Autowired
	private CommentRepository commentRepository;

	@Autowired
	private TaskRepository taskRepository;

	@Autowired
	private UserRepository userRepository;

	@Override
	public Comment addComment(Long taskId, Long authorId, String text) {
		Task task = taskRepository.findById(taskId);
		User author = userRepository.findById(authorId);
		Comment c = new Comment();
		c.setTask(task);
		c.setAuthor(author);
		c.setText(text);
		Long id = commentRepository.save(c);
		c.setId(id);
		return c;
	}
}

