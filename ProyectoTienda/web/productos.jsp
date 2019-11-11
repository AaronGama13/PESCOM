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
    ArrayList<Producto> Carrito = new ArrayList<Producto>();
    if(sesionOK.getAttribute("usuario") != null){
        username = (String) sesionOK.getAttribute("usuario");
        Carrito = (ArrayList<Producto>) sesionOK.getAttribute("Carrito");
    }
    %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <script type="text/javascript">
        function agregar_carrito()
        {
            alert("Producto agregado al carrito de compras");
        }
    </script>
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
                <%
                    out.print("<form action= \"ServletCarrito?accion=verCarrito\" method=\"POST\">");
                    out.print("<input type = \"image\" src=\"IMG/cart.jpg\" width=\"70\" height=\"70\">");
                    out.print("</form>");
                %>
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
                            <option>Musica</option>
                        </select>
                    
                </h3>
            </div>
            <div>
                <input type="hidden" name="accion" value="agregar"/>
                <%
                    try{
                        Conexion con = new Conexion();
                        ArrayList<Producto> productos = Sentencias.readProductos('N');
                        out.print("<table>");
                        for(Producto p : productos){
                            out.print("<tr>");
                            out.print("<form action= \"ServletCarrito?accion=agregar\" method=\"POST\" >");
                            out.print("<td>"+p.getNombre()+" <input type=\"hidden\" name=\"idProducto\" value="+p.getId()+"></td>");
                            out.print("<td> <img id='id_img' src='data:image/jpg;base64,"+p.getFoto()+"' width='50' height='50' ></td>");
                            out.print("<td>" + p.getPrecio() + "</td>");
                            out.print("<td><input type = \"submit\" value = \"Comprar\" " +
                                    "onclick=\"agregar_carrito()\"></td>");
                            out.print("</form>");
                            out.print("</tr>");

                        }
                        out.print("</table>");
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
