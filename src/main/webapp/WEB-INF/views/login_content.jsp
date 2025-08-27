<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="container-fluid">
    <div class="row justify-content-center">
        <div class="col-md-6 col-lg-4">
            <div class="card shadow border-0">
                <div class="card-body p-5">
                    <div class="text-center mb-4">
                        <i class="bi bi-house-heart-fill text-primary" style="font-size: 3rem;"></i>
                        <h2 class="mt-3">Welcome Back</h2>
                        <p class="text-muted">Sign in to your WorkNest account</p>
                    </div>
                    
                    <% if (request.getAttribute("error") != null) { %>
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="bi bi-exclamation-triangle me-2"></i>
                            <%= request.getAttribute("error") %>
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    <% } %>
                    <% if (request.getAttribute("success") != null) { %>
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <i class="bi bi-check-circle me-2"></i>
                            <%= request.getAttribute("success") %>
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    <% } %>
                    
                    <form method="post" action="<%= request.getContextPath() %>/login">
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Username</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-person"></i></span>
                                <input class="form-control" type="text" name="username" placeholder="Enter your username" required />
                            </div>
                        </div>
                        <div class="mb-4">
                            <label class="form-label fw-semibold">Password</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-lock"></i></span>
                                <input class="form-control" type="password" name="password" placeholder="Enter your password" required />
                            </div>
                        </div>
                        <button class="btn btn-primary w-100 py-2 fw-semibold" type="submit">
                            <i class="bi bi-box-arrow-in-right me-2"></i>Sign In
                        </button>
                    </form>
                    
                    <div class="text-center mt-4">
                        <p class="text-muted mb-0">Don't have an account? 
                            <a href="<%= request.getContextPath() %>/register" class="text-decoration-none fw-semibold">Create one</a>
                        </p>
                    </div>
                    
                    <hr class="my-4">
                    
                    <div class="text-center">
                        <small class="text-muted">
                            <strong>Demo Accounts:</strong><br>
                            Admin: admin / admin<br>
                            User: user / user
                        </small>
                        <div class="mt-2">
                            <a class="text-decoration-none" href="<%= request.getContextPath() %>/create-demo-users">Reset demo users</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
