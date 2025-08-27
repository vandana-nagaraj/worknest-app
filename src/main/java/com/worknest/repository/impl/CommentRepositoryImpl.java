package com.worknest.repository.impl;

import com.worknest.model.Comment;
import com.worknest.repository.CommentRepository;
import org.springframework.stereotype.Repository;

@Repository
public class CommentRepositoryImpl extends GenericDaoHibernate<Comment, Long> implements CommentRepository {
}

