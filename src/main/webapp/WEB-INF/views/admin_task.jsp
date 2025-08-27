<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Task Detail - WorkNest</title>
    <%@ include file="_head.jspf" %>
    <style>
        .card{background:#fff;border:1px solid #e5e9f0;border-radius:10px;padding:1rem 1.2rem;margin-bottom:1rem;box-shadow:0 2px 8px rgba(0,0,0,.05)}
        .muted{opacity:.7}
        .badge{display:inline-block;padding:.15rem .5rem;border-radius:8px;font-size:.85rem}
        .b-pending{background:#fff3cd;border:1px solid #ffe69c}
        .b-inprogress{background:#cfe2ff;border:1px solid #9ec5fe}
        .b-completed{background:#d1e7dd;border:1px solid #a3cfbb}
        .b-delayed{background:#f8d7da;border:1px solid #f1aeb5}
        .btn{background:#2563eb;color:#fff;border:none;border-radius:6px;padding:.5rem .8rem;cursor:pointer}
        .btn-link{background:transparent;border:none;color:#2563eb;cursor:pointer}
        ul{padding-left:1.2rem}
        .comment{border-left:3px solid #e5e9f0;margin:.6rem 0;padding:.3rem .6rem}
        a{color:#2563eb}
    </style>
 </head>
<body class="theme-admin">
<%@ include file="_nav.jspf" %>
<div class="container">
<p><a href="<%= request.getContextPath() %>/admin">← Back to dashboard</a></p>

<div class="card">
    <h2 style="margin:.2rem 0"><%= ((com.worknest.model.Task)request.getAttribute("task")).getTitle() %></h2>
    <p class="muted" style="margin:.2rem 0">Assigned to: <b><%= ((com.worknest.model.Task)request.getAttribute("task")).getAssignee() != null ? ((com.worknest.model.Task)request.getAttribute("task")).getAssignee().getUsername() : "-" %></b></p>
    <p style="margin:.2rem 0"><%= ((com.worknest.model.Task)request.getAttribute("task")).getDescription() %></p>
    <p class="muted">
        Start: <%= ((com.worknest.model.Task)request.getAttribute("task")).getStartDate() %> • Due: <%= ((com.worknest.model.Task)request.getAttribute("task")).getDueDate() %>
            <% 
    com.worknest.model.Task task = (com.worknest.model.Task)request.getAttribute("task");
    if (task.isDelayed()) {
    %>
        <span class="badge b-delayed">DELAYED</span>
    <% } else if ("COMPLETED".equals(task.getStatus().toString())) { %>
        <span class="badge b-completed">COMPLETED</span>
    <% } else if ("IN_PROGRESS".equals(task.getStatus().toString())) { %>
        <span class="badge b-inprogress">IN PROGRESS</span>
    <% } else { %>
        <span class="badge b-pending">PENDING</span>
    <% } %>
    </p>
 </div>

<div class="card">
    <h3 style="margin:.2rem 0">Edit Task</h3>
    <form method="post" action="<%= request.getContextPath() %>/admin/tasks/<%= ((com.worknest.model.Task)request.getAttribute("task")).getId() %>/update">
        <div style="display:grid;grid-template-columns:1fr 1fr;gap:12px">
            <div>
                <label>Title</label>
                <input name="title" class="form-control" value="<%= ((com.worknest.model.Task)request.getAttribute("task")).getTitle() %>" required />
            </div>
            <div>
                <label>Status</label>
                <select name="status" class="form-select">
                    <% com.worknest.model.TaskStatus[] statuses = (com.worknest.model.TaskStatus[])request.getAttribute("statuses");
                       com.worknest.model.Task tsk = (com.worknest.model.Task)request.getAttribute("task");
                       for (com.worknest.model.TaskStatus s : statuses) { %>
                        <option value="<%= s %>" <%= tsk.getStatus().equals(s) ? "selected" : "" %>><%= s %></option>
                    <% } %>
                </select>
            </div>
            <div style="grid-column:1 / span 2">
                <label>Description</label>
                <textarea name="description" class="form-control" rows="3"><%= ((com.worknest.model.Task)request.getAttribute("task")).getDescription() %></textarea>
            </div>
            <div>
                <label>Start Date</label>
                <input type="date" name="startDate" class="form-control" value="<%= ((com.worknest.model.Task)request.getAttribute("task")).getStartDate() %>" />
            </div>
            <div>
                <label>Due Date</label>
                <input type="date" name="dueDate" class="form-control" value="<%= ((com.worknest.model.Task)request.getAttribute("task")).getDueDate() %>" />
            </div>
            <div>
                <label>Assignee</label>
                <select name="assigneeId" class="form-select">
                    <% java.util.List users = (java.util.List) request.getAttribute("users");
                       com.worknest.model.User current = ((com.worknest.model.Task)request.getAttribute("task")).getAssignee();
                       if (users != null) {
                           for (Object uo : users) {
                               com.worknest.model.User u = (com.worknest.model.User) uo; %>
                               <option value="<%= u.getId() %>" <%= (current != null && current.getId().equals(u.getId())) ? "selected" : "" %>><%= u.getUsername() %> (<%= u.getRole() %>)</option>
                    <%     }
                       } %>
                </select>
            </div>
        </div>
        <div style="margin-top:12px">
            <button type="submit" class="btn">Save Changes</button>
            <a class="btn-link" href="<%= request.getContextPath() %>/admin">Cancel</a>
        </div>
    </form>
</div>

<div class="card">
    <form method="post" action="<%= request.getContextPath() %>/admin/tasks/<%= ((com.worknest.model.Task)request.getAttribute("task")).getId() %>/delete" onsubmit="return confirm('Delete this task permanently?')">
        <button type="submit" class="btn" style="background:#dc2626">Delete Task</button>
    </form>
</div>

<div class="card">
    <h3 style="margin:.2rem 0">Comments</h3>
    <% 
    if (task.getComments() == null || task.getComments().isEmpty()) {
    %>
        <p class="muted">No comments yet.</p>
    <% } else { %>
        <% for (com.worknest.model.Comment c : task.getComments()) { %>
            <div class="comment">
                <div><b><%= c.getAuthor() != null ? c.getAuthor().getUsername() : "Unknown" %></b></div>
                <div><%= c.getText() %></div>
            </div>
        <% } %>
    <% } %>
</div>
</div>
</body>
</html>

