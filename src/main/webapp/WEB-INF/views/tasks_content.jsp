<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="container-fluid">
    <div class="row">
        <div class="col-12">
            <%-- Display error message if any --%>
            <% String errorMsg = (String) request.getSession().getAttribute("errorMessage"); 
               if (errorMsg != null) { 
            %>
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="bi bi-exclamation-triangle me-2"></i><%= errorMsg %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
                <% request.getSession().removeAttribute("errorMessage"); %>
            <% } 
            
               // Display success message if any
               String successMsg = (String) request.getSession().getAttribute("successMessage");
               if (successMsg != null) { 
            %>
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="bi bi-check-circle me-2"></i><%= successMsg %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
                <% request.getSession().removeAttribute("successMessage"); %>
            <% } %>
            <div class="d-flex justify-content-between align-items-center mb-4">
                <div>
                    <h2 class="mb-1">
                        <i class="bi bi-list-task text-primary me-2"></i>My Tasks
                    </h2>
                    <p class="text-muted mb-0">Manage and track your assigned tasks</p>
                </div>
                <div class="text-end">
                    <span class="badge bg-primary fs-6">
                                                 <i class="bi bi-check-circle me-1"></i><%= request.getAttribute("tasks") != null ? ((java.util.List)request.getAttribute("tasks")).size() : 0 %> Tasks
                    </span>
                </div>
            </div>

            <% if (request.getAttribute("tasks") == null || ((java.util.List)request.getAttribute("tasks")).isEmpty()) { %>
                <div class="text-center py-5">
                    <i class="bi bi-check-circle text-success" style="font-size: 4rem;"></i>
                    <h3 class="mt-3 text-muted">No tasks assigned yet!</h3>
                    <p class="text-muted">You're all caught up. New tasks will appear here when assigned.</p>
                    <a href="<%= request.getContextPath() %>/dashboard" class="btn btn-primary">
                        <i class="bi bi-house me-2"></i>Go to Dashboard
                    </a>
                </div>
            <% } else { %>
                <% 
                java.util.List<com.worknest.model.Task> tasks = (java.util.List<com.worknest.model.Task>)request.getAttribute("tasks");
                for (com.worknest.model.Task t : tasks) { 
                %>
                        <div class="card shadow-sm mb-4">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-start mb-3">
                                    <div>
                                        <h5 class="card-title mb-1"><%= t.getTitle() %></h5>
                                        <p class="card-text text-muted mb-2"><%= t.getDescription() %></p>
                                        <div class="d-flex gap-3 text-muted small">
                                            <span><i class="bi bi-calendar-event me-1"></i>Start: <%= t.getStartDate() %></span>
                                            <span><i class="bi bi-calendar-check me-1"></i>Due: <%= t.getDueDate() %></span>
                                            <% if (t.isDelayed()) { %>
                                                <span class="text-danger"><i class="bi bi-exclamation-triangle me-1"></i>Delayed</span>
                                            <% } %>
                                        </div>
                                    </div>
                                    <span class="badge bg-<%= t.getStatus().toString().equals("COMPLETED") ? "success" : t.getStatus().toString().equals("IN_PROGRESS") ? "warning" : "secondary" %> fs-6">
                                        <%= t.getStatus() %>
                                    </span>
                                </div>
                                
                                <form method="post" action="<%= request.getContextPath() %>/tasks/<%= t.getId() %>/status" class="row g-2 align-items-center mb-3">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                    <div class="col-auto">
                                        <select name="status" class="form-select form-select-sm">
                                            <% 
                                            com.worknest.model.TaskStatus[] statuses = (com.worknest.model.TaskStatus[])request.getAttribute("statuses");
                                            for (com.worknest.model.TaskStatus s : statuses) {
                                                if (!s.toString().equals("DELAYED")) {
                                            %>
                                                <option value="<%= s %>" <%= t.getStatus().equals(s) ? "selected" : "" %>><%= s %></option>
                                            <% 
                                                }
                                            } 
                                            %>
                                        </select>
                                    </div>
                                    <div class="col-auto">
                                        <button type="submit" class="btn btn-primary btn-sm">
                                            <i class="bi bi-arrow-clockwise me-1"></i>Update Status
                                        </button>
                                    </div>
                                </form>
                                
                                <form method="post" action="<%= request.getContextPath() %>/tasks/<%= t.getId() %>/comments" class="row g-2">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                    <div class="col">
                                        <input name="text" placeholder="Add a comment..." class="form-control form-control-sm" required />
                                    </div>
                                    <div class="col-auto">
                                        <button type="submit" class="btn btn-outline-secondary btn-sm">
                                            <i class="bi bi-chat-dots me-1"></i>Comment
                                        </button>
                                    </div>
                                </form>
                                
                                <% if (t.getComments() != null && !t.getComments().isEmpty()) { %>
                                    <div class="mt-3">
                                        <h6 class="text-muted mb-2"><i class="bi bi-chat-left-text me-1"></i>Comments</h6>
                                        <div class="list-group list-group-flush">
                                            <% for (com.worknest.model.Comment cmt : t.getComments()) { %>
                                                <div class="list-group-item border-0 px-0 py-2">
                                                    <div class="d-flex">
                                                        <i class="bi bi-person-circle text-muted me-2"></i>
                                                        <div>
                                                            <small class="text-muted"><%= cmt.getAuthor().getUsername() %> - <%= cmt.getCreatedAt() %></small>
                                                            <p class="mb-0"><%= cmt.getText() %></p>
                                                        </div>
                                                    </div>
                                                </div>
                                            <% } %>
                                        </div>
                                    </div>
                                <% } %>
                            </div>
                        </div>
                <% } %>
            <% } %>
        </div>
    </div>
</div>
