<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="container-fluid">
    <!-- Welcome Section -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="card bg-primary text-white">
                <div class="card-body">
                    <h2 class="card-title">
                        <i class="bi bi-house-heart-fill me-2"></i>
                                                 Welcome back, <%= request.getAttribute("username") %>!
                    </h2>
                    <p class="card-text">Here's your task overview for today.</p>
                </div>
            </div>
        </div>
    </div>

    <!-- Statistics Cards -->
    <div class="row mb-4">
        <div class="col-md-4">
            <div class="card border-0 shadow-sm">
                <div class="card-body text-center">
                    <i class="bi bi-list-task text-primary" style="font-size: 2.5rem;"></i>
                                         <h3 class="mt-2"><%= request.getAttribute("totalTasks") %></h3>
                    <p class="text-muted mb-0">Total Tasks</p>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card border-0 shadow-sm">
                <div class="card-body text-center">
                    <i class="bi bi-clock text-warning" style="font-size: 2.5rem;"></i>
                                         <h3 class="mt-2"><%= request.getAttribute("pendingTasks") %></h3>
                    <p class="text-muted mb-0">Pending Tasks</p>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card border-0 shadow-sm">
                <div class="card-body text-center">
                    <i class="bi bi-check-circle text-success" style="font-size: 2.5rem;"></i>
                                         <h3 class="mt-2"><%= request.getAttribute("completedTasks") %></h3>
                    <p class="text-muted mb-0">Completed Tasks</p>
                </div>
            </div>
        </div>
    </div>

    <!-- Recent Tasks -->
    <div class="row">
        <div class="col-12">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-white">
                    <h5 class="mb-0">
                        <i class="bi bi-clock-history me-2"></i>
                        Recent Tasks
                    </h5>
                </div>
                <div class="card-body">
                    <% if (request.getAttribute("recentTasks") != null && ((java.util.List)request.getAttribute("recentTasks")).size() > 0) { %>
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>Title</th>
                                        <th>Description</th>
                                        <th>Status</th>
                                        <th>Due Date</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% 
                                    java.util.List<com.worknest.model.Task> recentTasks = (java.util.List<com.worknest.model.Task>)request.getAttribute("recentTasks");
                                    for (com.worknest.model.Task task : recentTasks) { 
                                    %>
                                        <tr>
                                            <td><%= task.getTitle() %></td>
                                            <td><%= task.getDescription() %></td>
                                            <td>
                                                <span class="badge bg-<%= task.getStatus().toString().equals("COMPLETED") ? "success" : task.getStatus().toString().equals("IN_PROGRESS") ? "warning" : "secondary" %>">
                                                    <%= task.getStatus() %>
                                                </span>
                                            </td>
                                            <td><%= task.getDueDate() %></td>
                                            <td>
                                                <a href="<%= request.getContextPath() %>/tasks" class="btn btn-sm btn-outline-primary">
                                                    <i class="bi bi-eye"></i> View
                                                </a>
                                            </td>
                                        </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                    <% } else { %>
                        <div class="text-center py-4">
                            <i class="bi bi-inbox text-muted" style="font-size: 3rem;"></i>
                            <p class="text-muted mt-2">No tasks assigned yet.</p>
                            <% if ("ADMIN".equals(request.getAttribute("userRole"))) { %>
                                <a href="<%= request.getContextPath() %>/admin" class="btn btn-primary">
                                    <i class="bi bi-plus-circle me-2"></i>Create Tasks
                                </a>
                            <% } %>
                        </div>
                    <% } %>
                </div>
            </div>
        </div>
    </div>

    <!-- Quick Actions -->
    <div class="row mt-4">
        <div class="col-12">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-white">
                    <h5 class="mb-0">
                        <i class="bi bi-lightning me-2"></i>
                        Quick Actions
                    </h5>
                </div>
                <div class="card-body">
                    <div class="row g-3">
                        <div class="col-md-3">
                            <a href="<%= request.getContextPath() %>/tasks" class="btn btn-outline-primary w-100">
                                <i class="bi bi-list-task me-2"></i>View All Tasks
                            </a>
                        </div>
                        <% if ("ADMIN".equals(request.getAttribute("userRole"))) { %>
                            <div class="col-md-3">
                                <a href="<%= request.getContextPath() %>/admin" class="btn btn-outline-success w-100">
                                    <i class="bi bi-gear me-2"></i>Admin Panel
                                </a>
                            </div>
                        <% } %>
                        <div class="col-md-3">
                            <a href="<%= request.getContextPath() %>/logout" class="btn btn-outline-danger w-100">
                                <i class="bi bi-box-arrow-right me-2"></i>Logout
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
