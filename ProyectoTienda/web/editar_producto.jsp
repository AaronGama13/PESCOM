<%-- 
    Document   : editar_producto
    Created on : 15/11/2019, 07:23:53 PM
    Author     : gamma
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            out.print("<h1>"+request.getParameter("sku")+"</h1>");
        %>
    </body>
</html>
