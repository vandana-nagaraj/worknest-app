<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="container-fluid">
    <!-- Hero Section -->
    <div class="row mb-5">
        <div class="col-lg-8 mx-auto text-center">
            <h1 class="display-3 fw-bold text-primary mb-4">
                <i class="bi bi-house-heart-fill me-3"></i>Welcome to WorkNest
            </h1>
            <p class="lead text-muted mb-5 fs-5">
                Your simple and efficient task management solution. Organize, track, and collaborate on tasks with ease.
            </p>
            <div class="d-grid gap-3 d-sm-flex justify-content-sm-center">
                                    <a href="<%= request.getContextPath() %>/login" class="btn btn-primary btn-lg px-5 py-3">
                        <i class="bi bi-box-arrow-in-right me-2"></i>Get Started
                    </a>
                    <a href="<%= request.getContextPath() %>/register" class="btn btn-outline-secondary btn-lg px-5 py-3">
                        <i class="bi bi-person-plus me-2"></i>Create Account
                    </a>
            </div>
        </div>
    </div>

    <!-- Features Section -->
    <div class="row mb-5">
        <div class="col-12">
            <h2 class="text-center mb-5">Why Choose WorkNest?</h2>
        </div>
        <div class="col-md-4 mb-4">
            <div class="card h-100 border-0 shadow-sm">
                <div class="card-body text-center p-4">
                    <div class="bg-primary bg-opacity-10 rounded-circle d-inline-flex align-items-center justify-content-center mb-3" style="width: 80px; height: 80px;">
                        <i class="bi bi-list-task text-primary" style="font-size: 2rem;"></i>
                    </div>
                    <h5 class="card-title">Task Management</h5>
                    <p class="card-text text-muted">
                        Create, organize, and track your tasks with our intuitive interface. 
                        Set priorities, due dates, and status updates with ease.
                    </p>
                </div>
            </div>
        </div>
        <div class="col-md-4 mb-4">
            <div class="card h-100 border-0 shadow-sm">
                <div class="card-body text-center p-4">
                    <div class="bg-success bg-opacity-10 rounded-circle d-inline-flex align-items-center justify-content-center mb-3" style="width: 80px; height: 80px;">
                        <i class="bi bi-people text-success" style="font-size: 2rem;"></i>
                    </div>
                    <h5 class="card-title">Team Collaboration</h5>
                    <p class="card-text text-muted">
                        Work together seamlessly with comments, updates, and real-time task sharing. 
                        Keep everyone in the loop with our collaboration features.
                    </p>
                </div>
            </div>
        </div>
        <div class="col-md-4 mb-4">
            <div class="card h-100 border-0 shadow-sm">
                <div class="card-body text-center p-4">
                    <div class="bg-warning bg-opacity-10 rounded-circle d-inline-flex align-items-center justify-content-center mb-3" style="width: 80px; height: 80px;">
                        <i class="bi bi-graph-up text-warning" style="font-size: 2rem;"></i>
                    </div>
                    <h5 class="card-title">Progress Tracking</h5>
                    <p class="card-text text-muted">
                        Monitor task status, deadlines, and overall progress with our comprehensive 
                        tracking system. Stay on top of your projects.
                    </p>
                </div>
            </div>
        </div>
    </div>

    <!-- How It Works Section -->
    <div class="row mb-5">
        <div class="col-12">
            <div class="card border-0 shadow-sm">
                <div class="card-body p-5">
                    <h2 class="text-center mb-5">How It Works</h2>
                    <div class="row">
                        <div class="col-md-3 text-center mb-4">
                            <div class="bg-primary text-white rounded-circle d-inline-flex align-items-center justify-content-center mb-3" style="width: 60px; height: 60px;">
                                <span class="fw-bold">1</span>
                            </div>
                            <h5>Sign Up</h5>
                            <p class="text-muted">Create your account in seconds</p>
                        </div>
                        <div class="col-md-3 text-center mb-4">
                            <div class="bg-primary text-white rounded-circle d-inline-flex align-items-center justify-content-center mb-3" style="width: 60px; height: 60px;">
                                <span class="fw-bold">2</span>
                            </div>
                            <h5>Create Tasks</h5>
                            <p class="text-muted">Add your tasks and set priorities</p>
                        </div>
                        <div class="col-md-3 text-center mb-4">
                            <div class="bg-primary text-white rounded-circle d-inline-flex align-items-center justify-content-center mb-3" style="width: 60px; height: 60px;">
                                <span class="fw-bold">3</span>
                            </div>
                            <h5>Track Progress</h5>
                            <p class="text-muted">Monitor status and updates</p>
                        </div>
                        <div class="col-md-3 text-center mb-4">
                            <div class="bg-primary text-white rounded-circle d-inline-flex align-items-center justify-content-center mb-3" style="width: 60px; height: 60px;">
                                <span class="fw-bold">4</span>
                            </div>
                            <h5>Complete</h5>
                            <p class="text-muted">Mark tasks as done and celebrate</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Call to Action -->
    <div class="row">
        <div class="col-12">
            <div class="card bg-primary text-white border-0">
                <div class="card-body text-center p-5">
                    <h2 class="mb-3">Ready to Get Started?</h2>
                    <p class="lead mb-4">Join thousands of users who are already managing their tasks efficiently with WorkNest.</p>
                    <div class="d-grid gap-3 d-sm-flex justify-content-sm-center">
                        <a href="<%= request.getContextPath() %>/register" class="btn btn-light btn-lg px-5">
                            <i class="bi bi-person-plus me-2"></i>Create Free Account
                        </a>
                        <a href="<%= request.getContextPath() %>/login" class="btn btn-outline-light btn-lg px-5">
                            <i class="bi bi-box-arrow-in-right me-2"></i>Sign In
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
