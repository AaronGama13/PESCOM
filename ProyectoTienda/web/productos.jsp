<%-- 
    Document   : productos
    Created on : 26/10/2019, 05:28:33 PM
    Author     : gamma
--%>

<%@page import="java.util.Base64"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.sql.Blob"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Modelos.Producto"%>
<%@page import="Database.Sentencias"%>
<%@page import="Database.Conexion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    //COMPROBAMOS QUE NO EXISTA UNA SESIÓN INICIADA PREVIAMENTE    
    HttpSession sesionOK = request.getSession();   
    String username = "";
    if(sesionOK.getAttribute("usuario") != null){
        username = (String) sesionOK.getAttribute("usuario");
    }
    %>

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
                <%if(sesionOK.getAttribute("usuario") != null){%>
                <h2><%out.println("Bienvenido a LinioMX feiq " + username);%></h2>
                <%} else {%>
                <a href="index.jsp"></a>
                <%}%>
                <a href="productos.jsp">Productos</a>
                <a href="carrito.jsp"><img src="IMG/cart.jpg" width="50" height="50"></a>
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
                    try{
                        Conexion con = new Conexion();
                        ArrayList<Producto> productos = Sentencias.readProductos('N');
                        for(Producto p : productos){
                            out.print("<div>"+p.getNombre()+"<br><img id='id_img' src='data:image/jpg;base64,"+p.getFoto()+"' width='50' height='50' ><br>"+p.getPrecio());
                            out.print("<br><button>Comprar</button></div>");
                        }
                    }catch(Exception e){
                        System.out.println("ERROR"+e);
                    }
                %>
            </div>
        </div>
            <div>
                <% if(sesionOK.getAttribute("usuario") != null){%>
                <a href="ServletLoguin?accion=cerrar">Cerrar sesión</a>
                <%}%>
            </div>
    </center>
    </body>
</html>
