<%-- 
    Document   : carrito
    Created on : 26/10/2019, 05:55:09 PM
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
    String username = (String) sesionOK.getAttribute("usuario");
    ArrayList<Producto> Carrito = (ArrayList<Producto>) sesionOK.getAttribute("Carrito");;
    %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="CSS/universal.css">
    </head>
    <body>
        <center>
        <header>
            <div>
                <a href="productos.jsp">Productos</a>
                <a href="carrito.jsp"><img class='view_cart' src="IMG/cart.jpg" width="30" height="30"></a>
            </div>
        </header>
        <div>
            <h1>Mi carrito de compras</h1>
            <%
                try{
                    int i = 0;
                    out.print("<table>");
                    for(Producto p : Carrito){
                        out.print("<tr>");
                        out.print("<td>"+p.getNombre()+" <input type=\"hidden\" name=\"idProducto\" value="+p.getId()+"></td>");
                        out.print("<td> <img id='id_img' src='data:image/jpg;base64,"+p.getFoto()+"' width='50' height='50' ></td>");
                        out.print("<td>" + p.getPrecio() + "</td>");
                        out.print("<td><a href='ServletCarrito?accion=quitar&id="+i+"'><button class='add_cart' onclick=\"quitar_carrito();\">Quitar del carrito</button></a></td>");
                        out.print("</tr>");
                        i++;
                    }
                    out.print("</table>");
                }catch(Exception e){
                    System.out.println("ERROR"+e);
                }
            %>
        </div>
    </center>
    </body>
</html>
