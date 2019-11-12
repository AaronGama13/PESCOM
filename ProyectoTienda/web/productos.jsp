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
        <link rel="stylesheet" href="CSS/productos.css">
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
            <%
                if(sesionOK.getAttribute("usuario") == null){
                    //response.sendRedirect("index.jsp");
                }
            %>
            <a href="productos.jsp">Bienvenido a LINIO MX feiq</a>
            <img class='view_cart' src="IMG/cart.jpg" width="50" height="50">
        </header>
        <h1>Productos disponibles</h1>
        <div class="filter_by">        
            <h3>Filtrar por:
                <select>
                        <option>Todos</option>
                        <option>Imágenes</option>
                        <option>Libros</option>
                        <option>Películas</option>
                        <option>Música</option>
                    </select>

            </h3>
        </div><br><br><br>
        <div>
            <%
            try{
                Conexion con = new Conexion();
                ArrayList<Producto> productos = Sentencias.readProductos('N');
                for(Producto p : productos){
                    out.print("<div class='product-container'>");
                        out.print("<form action=\"ServletCarrito?accion=agregar\" method=\"POST\">");
                        out.print("<h4>"+p.getNombre()+"</h4><input type=\"hidden\" name=\"idProducto\" value="+p.getId()+"><br><br>");
                        out.print("<img id='id_img' src='data:image/jpg;base64,"+p.getFoto()+"' width='50' height='50' ><br><br>");
                        out.print("$ "+p.getPrecio()+" mxn<br><br>");
                        out.print("<input class='add_cart' type = 'submit' value = \"Agregar al carrito\" " + "onclick=\"agregar_carrito()\"><br><br>");
                        out.print("<button class='detail_btn'>Ver detalles</button>");
                    out.print("</div>");
                }
            }catch(Exception e){
                System.out.println("ERROR"+e);
            }
            %>
        </div>
    </center>
    </body>
</html>
