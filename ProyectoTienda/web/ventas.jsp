<%-- 
    Document   : ventas
    Created on : 26/11/2019, 12:40:49 PM
    Author     : AnonimusCrack
--%>

<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="Modelos.Producto"%>
<%@page import="Database.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    //COMPROBAMOS QUE NO EXISTA UNA SESIÓN INICIADA PREVIAMENTE    
    HttpSession sesionOK = request.getSession();   
    String username = (String) sesionOK.getAttribute("usuario");
    String priv = (String) sesionOK.getAttribute("priv");
    if(sesionOK.getAttribute("usuario") == null){
        response.sendRedirect("index.jsp");
    }else{
        //out.print(username);                    
    }
    %>
    
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="CSS/universal.css">
        <link rel="stylesheet" href="CSS/detalles.css">
    </head>
    <body>
        <center>
            <header>
                <a href="productos.jsp">Bienvenido a LINIO MX feiq</a>
                <a href="carrito.jsp"><img class='view_cart' src="IMG/cart.jpg" width="50" height="50"></a>
                <a href="ajustes.jsp"><img class='view_cart' src="IMG/user.jpg" width="50" height="50"></a>
            </header>

            <div>
                <h1>Ventas Realizadas</h1>
                <table>
                    <tr>
                        <td width='50'><center>noPedido</center></td>
                        <td width='200'><center>Fecha</center></td>
                        <td width='150'><center>Comprador</center></td>
                        <td width='70'><center>&nbsp</center></td>
                    </tr>
                    <%
                        try{
                            int k = 1;
                            ResultSet rs = Sentencias.Ventas();
                            while(rs.next()){
                                out.print("<tr>");
                                out.print("<td><center> " + rs.getInt("noPedido") + " </center></td>");
                                out.print("<td><center> " + rs.getTimestamp("fecha") + " </center></td>");
                                out.print("<td><center> " + rs.getString("comprador") + " </center></td>");
                                out.print("<td><center><a href='ServletVentas?accion=mostrar&id="+rs.getInt("noPedido")+"'><button class='add_cart'>Mostrar</button></a></center></td>");
                                out.print("</tr>");
                            }
                        }catch(Exception e){ }
                    %>
                </table>
            </div>
        </center>
    </body>
</html>
