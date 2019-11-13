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
    </head>
    <body>
        <center>
        <header>
            <div>
                <a href="productos.jsp">Productos</a>
                <a href="carrito.jsp"><img src="IMG/cart.jpg" width="50" height="50"></a>
            </div>
        </header>
        <div>
            <h1>Mi carrito de compras</h1>
            <%
                try{
                    out.print("<table>");
                    for(Producto p : Carrito){
                        out.print("<tr>");
                        out.print("<td>"+p.getNombre()+" <input type=\"hidden\" name=\"idProducto\" value="+p.getId()+"></td>");
                        out.print("<td> <img id='id_img' src='data:image/jpg;base64,"+p.getFoto()+"' width='50' height='50' ></td>");
                        out.print("<td>" + p.getPrecio() + "</td>");
                        out.print("</tr>");
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
