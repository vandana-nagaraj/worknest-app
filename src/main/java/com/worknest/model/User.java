package com.worknest.model;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "users")
public class User {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@Column(nullable = false, unique = true)
	private String username;

	@Column(nullable = false)
	private String password;

	@Enumerated(EnumType.STRING)
	@Column(nullable = false)
	private UserRole role;

	@OneToMany(mappedBy = "assignee", cascade = CascadeType.ALL, orphanRemoval = false)
	private Set<Task> assignedTasks = new HashSet<>();

	@OneToMany(mappedBy = "author", cascade = CascadeType.ALL, orphanRemoval = true)
	private Set<Comment> comments = new HashSet<>();

	public Long getId() { return id; }
	public void setId(Long id) { this.id = id; }

	public String getUsername() { return username; }
	public void setUsername(String username) { this.username = username; }

	public String getPassword() { return password; }
	public void setPassword(String password) { this.password = password; }

	public UserRole getRole() { return role; }
	public void setRole(UserRole role) { this.role = role; }

	public Set<Task> getAssignedTasks() { return assignedTasks; }
	public void setAssignedTasks(Set<Task> assignedTasks) { this.assignedTasks = assignedTasks; }

	public Set<Comment> getComments() { return comments; }
	public void setComments(Set<Comment> comments) { this.comments = comments; }
}

