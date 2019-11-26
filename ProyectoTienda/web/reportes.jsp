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
    <%
    //COMPROBAMOS QUE NO EXISTA UNA SESIÓN INICIADA PREVIAMENTE    
    HttpSession sesionOK = request.getSession();   
    String username = "";
    String priv = "";
    String msj = "";
    ArrayList<Producto> Carrito = new ArrayList<Producto>();
    int[][] Cantidad = new int[100][2];
    if(sesionOK.getAttribute("usuario") != null){
        //RECUPERAMOS LOS DATOS DE LA SESIÓN
        username = (String) sesionOK.getAttribute("usuario");
        priv = (String) sesionOK.getAttribute("priv");
        msj = (String) sesionOK.getAttribute("msj");
    }
    %>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="CSS/universal.css">
    </head>
    <body>
    <center>
    <header>
        <a href="productos.jsp">Bienvenido a LINIO MX feiq</a>
            
                <a href="ajustes.jsp"><img class='view_cart' src="IMG/user.jpg" width="30" height="30"></a>
            <%
            out.print("<form action='ServletLoguin' method='POST'>");
                out.print("<input name='username' type='hidden' value='"+username+"'>");
                out.print("<input name='pass' type='hidden' value='X'>");
                out.print("<input name='accion' type='hidden' value='cerrar'>");
                out.print("<input type='submit' value='Cerrar sesión'>");
            out.print("</form>");
            %>
    </header>
        <h1>Reportes</h1>
        <div class="container">
            <div class="container-fluid">
                <h2>Productos con bajo inventario</h2>
                <table>
                    <tr>
                        <td><center>Nombre del producto</center></td>
                        <td><center>Unidades disponibles</center></td>
                        <td><center>Añadir unidades</center></td>
                    </tr>
                <%
                  ArrayList<Producto> plowstock = Sentencias.readBajoStock();
                  for(Producto p: plowstock){
                      out.print("<tr>");
                      out.print("<td><center>"+p.getNombre()+"</center></td>");
                      out.print("<td><center>"+p.getStock()+"</center></td>");
                      out.print("<td><center><a href='detalles.jsp?sku="+p.getId()+"'><button>Añadir</button></a></center></td>");
                      out.print("</tr>");
                  }
                %>
                </table>
            </div>
        </div>
    </center>
    </body>
</html>
