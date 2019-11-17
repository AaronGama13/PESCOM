<%-- 
    Document   : reportes
    Created on : 11/11/2019, 10:34:06 PM
    Author     : gamma
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="Modelos.Producto"%>
<%@page import="Database.Sentencias"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
    <center>
        <h1>Reportes</h1>
        <div class="container">
            <div class="container-fluid">
                <h2>Productos con bajo inventario</h2>
                <table>
                    <tr>
                        <td>Nombre del producto</td>
                        <td>Unidades disponibles</td>
                        <td>Añadir unidades</td>
                    </tr>
                <%
                  ArrayList<Producto> plowstock = Sentencias.readBajoStock();
                  for(Producto p: plowstock){
                      out.print("<tr>");
                      out.print("<td>"+p.getNombre()+"</td>");
                      out.print("<td>"+p.getStock()+"</td>");
                      out.print("<td><a href='detalles.jsp?sku="+p.getId()+"'><button>Añadir</button></a></td>");
                      out.print("</tr>");
                  }
                %>
                </table>
            </div>
            <div class="container-fluid"><h2>Ventas</h2></div>
        </div>
    </center>
    </body>
</html>
