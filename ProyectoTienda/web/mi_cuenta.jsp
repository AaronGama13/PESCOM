<%-- 
    Document   : mi_cuenta
    Created on : 26/10/2019, 05:55:23 PM
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
    <center>
        <header>
            <div>
                <a href="productos.jsp">Productos</a>
                <a href="carrito.jsp"><img src="IMG/cart.jpg" width="50" height="50"></a>
                <a href="mi_cuenta.jsp"><img src="IMG/count.png" width="50" height="30"></a>
            </div>
        </header>
        <div>
            <h1>Ajustes de la cuenta</h1>
            <form action="ServletSettings" method="POST">
                <h3>Cambiar contraseña:<input type="password"></h3>
                <h3>Confirma contraseña:<input type="password"></h3>
                <h3>Agregar saldo:<input type="text"></h3>
                <h3>Monto añadido:<input type="number"></h3>
                <input type="submit">
            </form>
        </div>
    </center>
    </body>
</html>
