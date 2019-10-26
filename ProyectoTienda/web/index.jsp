<%-- 
    Document   : index.jsp
    Created on : 26/10/2019, 04:14:51 PM
    Author     : gamma
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Hola mundo</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="CSS/Bootstrap/bootstrap.css">
    </head>
    <body>
    <center>
        <div class="container">
            <h2>Inicar sesión</h2>
            <form action="Login" method="POST">
                <input type="text" name="userName"><br>
                <input type="text" name="password"><br>
                <input type="submit"><br>
            </form>
        </div>
    </center>
    </body>
</html>
