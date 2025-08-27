<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard - WorkNest</title>
    <%@ include file="_head.jspf" %>
</head>
<body>
    <%@ include file="_header.jspf" %>

    <main class="container my-4">
        <div class="row">
            <div class="col-12">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <div>
                        <h2 class="mb-1">
                            <i class="bi bi-gear text-primary me-2"></i>Admin Dashboard
                        </h2>
                        <p class="text-muted mb-0">Manage users, tasks, and monitor system activity</p>
                    </div>
                    <div class="text-end">
                        <span class="badge bg-success fs-6">
                            <i class="bi bi-shield-check me-1"></i>Admin Access
                        </span>
                    </div>
                </div>

                <!-- Task Statistics -->
                <div class="row g-3 mb-4">
                    <div class="col-md-3">
                        <div class="card border-0 shadow-sm">
                            <div class="card-body text-center">
                                <i class="bi bi-clock text-warning" style="font-size: 2rem;"></i>
                                <h4 class="mt-2 mb-1"><%= ((java.util.Map)request.getAttribute("counts")).get("PENDING") != null ? ((java.util.Map)request.getAttribute("counts")).get("PENDING") : 0 %></h4>
                                <p class="text-muted mb-0">Pending</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card border-0 shadow-sm">
                            <div class="card-body text-center">
                                <i class="bi bi-arrow-clockwise text-info" style="font-size: 2rem;"></i>
                                <h4 class="mt-2 mb-1"><%= ((java.util.Map)request.getAttribute("counts")).get("IN_PROGRESS") != null ? ((java.util.Map)request.getAttribute("counts")).get("IN_PROGRESS") : 0 %></h4>
                                <p class="text-muted mb-0">In Progress</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card border-0 shadow-sm">
                            <div class="card-body text-center">
                                <i class="bi bi-check-circle text-success" style="font-size: 2rem;"></i>
                                <h4 class="mt-2 mb-1"><%= ((java.util.Map)request.getAttribute("counts")).get("COMPLETED") != null ? ((java.util.Map)request.getAttribute("counts")).get("COMPLETED") : 0 %></h4>
                                <p class="text-muted mb-0">Completed</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card border-0 shadow-sm">
                            <div class="card-body text-center">
                                <i class="bi bi-exclamation-triangle text-danger" style="font-size: 2rem;"></i>
                                <h4 class="mt-2 mb-1"><%= ((java.util.Map)request.getAttribute("counts")).get("DELAYED") != null ? ((java.util.Map)request.getAttribute("counts")).get("DELAYED") : 0 %></h4>
                                <p class="text-muted mb-0">Delayed</p>
                            </div>
                        </div>
                    </div>
                </div>

                <form method="post" action="<%= request.getContextPath() %>/admin/tasks/clear" class="mb-4" onsubmit="return confirm('Clear all tasks? This cannot be undone.')">
                    <button type="submit" class="btn btn-outline-danger">
                        <i class="bi bi-x-circle me-1"></i>Clear All Tasks
                    </button>
                </form>

                <!-- Create User Section -->
                <div class="card shadow-sm mb-4">
                    <div class="card-header bg-primary text-white">
                        <h5 class="mb-0"><i class="bi bi-person-plus me-2"></i>Create New User</h5>
                    </div>
                    <div class="card-body">
                        <form method="post" action="<%= request.getContextPath() %>/admin/user/create" class="row g-3">
                            <div class="col-md-4">
                                <label class="form-label">Username</label>
                                <input name="username" class="form-control" placeholder="Enter username" required />
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">Password</label>
                                <input name="password" type="password" class="form-control" placeholder="Enter password" required />
                            </div>
                            <div class="col-md-3">
                                <label class="form-label">Role</label>
                                <select name="role" class="form-select">
                                    <option value="USER" selected>User</option>
                                    <option value="ADMIN">Admin</option>
                                </select>
                            </div>
                            <div class="col-md-1">
                                <label class="form-label">&nbsp;</label>
                                <button type="submit" class="btn btn-primary w-100">
                                    <i class="bi bi-plus-circle"></i>
                                </button>
                            </div>
                        </form>
                        <small class="text-muted"><i class="bi bi-info-circle me-1"></i>Create users to assign tasks to them</small>
                    </div>
                </div>

                <!-- Users Management Section -->
                <div class="card shadow-sm mb-4">
                    <div class="card-header bg-info text-white">
                        <h5 class="mb-0"><i class="bi bi-people me-2"></i>Manage Users</h5>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead class="table-light">
                                    <tr>
                                        <th>ID</th>
                                        <th>Username</th>
                                        <th>Role</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% 
                                    java.util.List users = (java.util.List) request.getAttribute("users");
                                    if (users != null) {
                                        for (Object userObj : users) {
                                            com.worknest.model.User u = (com.worknest.model.User) userObj;
                                    %>
                                        <tr>
                                            <td><%= u.getId() %></td>
                                            <td><strong><%= u.getUsername() %></strong></td>
                                            <td>
                                                <span class="badge bg-<%= "ADMIN".equals(u.getRole().name()) ? "danger" : "secondary" %>"><%= u.getRole() %></span>
                                            </td>
                                            <td>
                                                <div class="btn-group btn-group-sm" role="group">
                                                    <button type="button" class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#editUser<%= u.getId() %>">
                                                        <i class="bi bi-pencil"></i>
                                                    </button>
                                                    <form method="post" action="<%= request.getContextPath() %>/admin/user/delete" style="display:inline" onsubmit="return confirm('Are you sure you want to delete this user?')">
                                                        <input type="hidden" name="id" value="<%= u.getId() %>"/>
                                                        <button type="submit" class="btn btn-outline-danger">
                                                            <i class="bi bi-trash"></i>
                                                        </button>
                                                    </form>
                                                </div>
                                            </td>
                                        </tr>
                                    <%
                                        }
                                    }
                                    %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

<h3>Create Task</h3>
<form method="post" action="<%= request.getContextPath() %>/admin/task/create" class="row g-2 align-items-end">
    <div class="col-md-2"><input class="form-control" name="title" placeholder="Task title" required /></div>
    <div class="col-md-3"><input class="form-control" name="description" placeholder="Description" /></div>
    <div class="col-md-2"><input class="form-control" name="startDate" type="date" placeholder="Start date" /></div>
    <div class="col-md-2"><input class="form-control" name="dueDate" type="date" placeholder="Due date" /></div>
    <div class="col-md-2"><select class="form-select" name="assigneeId">
        <% 
        java.util.List usersForSelect = (java.util.List) request.getAttribute("users");
        if (usersForSelect != null) {
            for (Object userObj : usersForSelect) {
                com.worknest.model.User u2 = (com.worknest.model.User) userObj;
        %>
            <option value="<%= u2.getId() %>"><%= u2.getUsername() %> (<%= u2.getRole() %>)</option>
        <%
            }
        }
        %>
    </select></div>
    <div class="col-md-1"><button class="btn btn-primary" type="submit">Assign</button></div>
</form>

<h3>All Tasks</h3>
<table class="table table-striped table-sm">
    <thead>
    <tr><th>ID</th><th>Title</th><th>Assignee</th><th>Status</th><th>Start</th><th>Due</th><th>Details</th></tr>
    </thead>
    <tbody>
    <% 
    java.util.List allTasks = (java.util.List) request.getAttribute("allTasks");
    if (allTasks != null) {
        for (Object taskObj : allTasks) {
            com.worknest.model.Task t = (com.worknest.model.Task) taskObj;
    %>
        <tr>
            <td><%= t.getId() %></td>
            <td><%= t.getTitle() %></td>
            <td><%= t.getAssignee() != null ? t.getAssignee().getUsername() : "-" %></td>
            <td><%= t.isDelayed() ? "DELAYED" : t.getStatus() %></td>
            <td><%= t.getStartDate() %></td>
            <td><%= t.getDueDate() %></td>
            <td><a href="<%= request.getContextPath() %>/admin/tasks/<%= t.getId() %>">View</a></td>
        </tr>
    <%
        }
    }
    %>
    </tbody>
 </table>

</div>
</body>
</html>

