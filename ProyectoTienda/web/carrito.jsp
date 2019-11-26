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
    String username = null ,priv = null;
    ArrayList<Producto> Carrito = null;
    String Tarjeta = "";
    String Validar = "";
    if(sesionOK.getAttribute("usuario")!=null){
        username = (String) sesionOK.getAttribute("usuario");
        priv = (String) sesionOK.getAttribute("priv");
        Carrito = (ArrayList<Producto>) sesionOK.getAttribute("Carrito");
        Tarjeta = (String) sesionOK.getAttribute("Tarjeta");
        Validar = (String) sesionOK.getAttribute("Validar");
    }
    
    if(priv.equals("A")){
        response.sendRedirect("productos.jsp");
        out.print("<script type='text/javascript'>alert('No tienes permiso para entrar al carrito');</script>");
    }
    %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="CSS/universal.css">
        <style type="text/css">
            button{
                display: inline-block;
                padding: 10px 20px;
                font-size: 16px;
                cursor: pointer;
                border-radius: 10px;
                margin: 0px;
                background: grey;
            }
            button.visible{
                background: #5cb85c; 
            }
            button.novisible{
                background: #d9534f;
            }
        </style> 
    </head>
    <body>
        <center>
        <header>
            <div>
                <a href="productos.jsp">Productos</a>
                <a href="carrito.jsp"><img class='view_cart' src="IMG/cart.jpg" width="30" height="30"></a>
                <a href="ajustes.jsp"><img class='view_cart' src="IMG/user.jpg" width="30" height="30"></a>
            </div>
        </header>
        <div>
            <h1>Mi carrito de compras</h1>
            <%
                try{
                    out.print("<table>");
                    out.print("<tr>");
                    out.print("<td width='50'><center> &nbsp </center></td>");
                    out.print("<td width='60'><center> Cantidad </center></td>");
                    out.print("<td width='150'><center> Producto </center></td>");
                    out.print("<td width='100'><center> Precio </center></td>");
                    out.print("</tr>");
                    
                    int[][] Cantidad = new int[100][2];
                    int k = 0;
                    
                    if(Carrito == null)
                        Carrito = new ArrayList<Producto>();
                    
                    ciclo:
                    for(Producto p : Carrito){
                        for(int i = 0; i < 100; i++){
                            if(Cantidad[i][0] == p.getId()){
                                Cantidad[i][1]++;
                                continue ciclo;
                            }
                            if(Cantidad[i][0] == 0){
                                k = i;
                                break;
                            }
                        }
                        Cantidad[k][0] = p.getId();
                        Cantidad[k][1] = 1;
                    }                    
                    k = 0;
                    for(int i = 0; i < 100; i++){
                        if(Cantidad[k][0] == 0)
                            break;
                        out.print("<tr>");
                        for(Producto p: Carrito){
                            if(p.getId() == Cantidad[k][0])
                            {
                                out.print("<td><center><img id='id_img' src='data:image/jpg;base64, " + p.getFoto() + "'width='40' height='40'></center></td>");
                                out.print("<td><center>"+Cantidad[k][1]+ "</center></td>");
                                out.print("<td><center>"+p.getNombre()+" <input type=\"hidden\" name=\"idProducto\" value="+p.getId()+"></center></td>");
                                out.print("<td><center>" + p.getPrecio() + "</center></td>");
                                break;
                            }
                        }
                        out.print("<td><center><a href='ServletCarrito?accion=quitar&id="+k+"'><button class='add_cart' onclick=\"quitar_carrito();\">Quitar</button></a></center></td>");
                        out.print("</tr>");
                        k++;
                    }
                    out.print("</table>");
                }catch(Exception e){
                    System.out.println("ERROR"+e);
                }
            %>
        </div>
        
        <div>
            <h2>
                Seleccione forma de pago:
            </h2>
            <table>
                <tr>
                    <td>
                        <a href='ServletCarrito?accion=Tarjeta&id=0'>
                            <button name="VISA" id="VISA" class="visible"> VISA</button>
                        </a>
                    </td>
                    <td><label>&nbsp&nbsp&nbsp&nbsp&nbsp</label></td>
                    <td>
                        <a href='ServletCarrito?accion=Tarjeta&id=1'>
                            <button name="Mastercard" id="Mastercard" class="novisible"> Mastercard</button>
                        </a>
                    </td>
                </tr>
            </table>
            <br>
            <form action="ServletCarrito" method="POST">
                <table>
                    <tr>
                        <td width='200'>
                            <h3>
                                Numero de tarjeta:
                            </h3>
                        </td>
                        <td width='100'>
                            <h3>
                                Fecha de vencimiento:
                            </h3>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input type="text" placeholder="5451354972" name="NumTarjeta">
                        </td>
                        <td>
                            <input type="date" name="FechTarjeta">
                        </td>
                    </tr>
                </table>

                <%
                    out.print("<input type='submit' value='Proceder con la compra'> ");
                %>
            </form>
            <%
                out.print("<label> "+Validar+" </label>");
            %>  
        </div>
    </center>
    </body>
</html>
