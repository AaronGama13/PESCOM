<%-- 
    Document   : productos
    Created on : 26/10/2019, 05:28:33 PM
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
            <div>
                <h1>Productos</h1>
                <h3>Filtrar por:
                    <select>
                        <option>Todos</option>
                        <option>Imágenes</option>
                        <option>Libros</option>
                        <option>Películas</option>
                        <option>Música</option>
                    </select>
                </h3>
            </div>
            <div>
                <%
                    //AQUÍ VAMOS A LLENAR CON UNA CONSULTA A LA BASE DE DATOS
                %>
            </div>
        </div>
    </center>
    </body>
</html>
