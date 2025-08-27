package com.worknest.service;

import com.worknest.model.Comment;

public interface CommentService {
	Comment addComment(Long taskId, Long authorId, String text);
}

