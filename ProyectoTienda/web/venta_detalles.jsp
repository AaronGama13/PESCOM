<%-- 
    Document   : venta_detalles
    Created on : 26/11/2019, 01:58:36 PM
    Author     : AnonimusCrack
--%>

<%@page import="Database.Sentencias"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    //COMPROBAMOS QUE NO EXISTA UNA SESIÓN INICIADA PREVIAMENTE    
    HttpSession sesionOK = request.getSession();   
    String username = (String) sesionOK.getAttribute("usuario");
    String priv = (String) sesionOK.getAttribute("priv");
    String comprador;
    ResultSet Compra = (ResultSet) sesionOK.getAttribute("rs");
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
                <%
                Compra.next();
                out.print("<h1>Venta con No.Pedido " +  Compra.getInt("noPedido") + " </h1>");
                %>
                <table>
                    <tr>
                        <td width='200'><center>Fecha:</center></td>
                        <td width='150'><center>Comprador:</center></td>
                    </tr>
                    <tr>
                    <%
                        out.print("<td><center> " + Compra.getTimestamp("fecha") + "</center></td>");
                        out.print("<td><center> " + Compra.getString("comprador") + "</center></td>");
                        comprador=Compra.getString("comprador");
                    %>
                    </tr>
                </table>
                <br><br><br>
                <table>
                    <tr>
                        <td width='50'><center>idProducto</center></td>
                        <td width='150'><center>Nombre del Producto</center></td>
                        <td width='50'><center>Cantidad</center></td>
                    </tr>
                    <%
                        do{
                            out.print("<tr>");
                            out.print("<td><center> " + Compra.getInt("idProducto") + "</center></td>");
                            out.print("<td><center> " + Compra.getString("nomProducto") + "</center></td>");
                            out.print("<td><center> " + Compra.getInt("cantidadProdcuto") + "</center></td>");
                            out.print("</tr>");
                        }while(Compra.next());
                    %>
                </table>
                <h1>Etiqueta de envío</h1>
                <%
                    ResultSet datosComprador = Sentencias.datosEnvio(comprador);
                %>
                <table>
                    <tr>
                        <td>
                            <%
                                datosComprador.getString("");
                            %>
                        </td>
                        <td>
                            <%
                            %>
                        </td>
                        <td>
                            <%
                            %>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                    </tr>
                    <tr>
                        <td></td>
                    </tr>
                </table>
                <br><br>
                <%if(priv == "A"){%>
                    <a href="ventas.jsp"><font color="#000000" >Regresar</font></a>
                <%}else{%>
                    <a href="productos.jsp"><font color="#000000" >Regresar</font></a>
                <%}%>
            </div>
        </center>
    </body>
</html>
