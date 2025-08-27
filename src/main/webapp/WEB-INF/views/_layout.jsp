<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>WorkNest</title>
    <%@ include file="_head.jspf" %>
</head>
<body>
    <%@ include file="_header.jspf" %>
    
    <main class="container my-4">
        <jsp:include page="${param.page}" />
    </main>
    
    <%@ include file="_footer.jspf" %>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>

