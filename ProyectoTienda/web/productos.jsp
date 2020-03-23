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
<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="Database.Conexion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

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
        Carrito = (ArrayList<Producto>) sesionOK.getAttribute("Carrito");
        Cantidad = (int[][]) sesionOK.getAttribute("Cantidad");
        msj = (String) sesionOK.getAttribute("msj");
    }
    %>

<!DOCTYPE html>
<html>
    <head>
            <meta charset="utf-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Catálogo de productos</title>
            <link rel="stylesheet" href="CSS/catalogo.css" type="text/css">
            <link href="https://fonts.googleapis.com/css?family=Roboto&display=swap" rel="stylesheet"> 
            <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    </head>
    <body>
        <nav class="navbar navbar-expand-lg">
            <div class="collapse navbar-collapse">
                <ul class="navbar-nav mr-auto">
                    <li class="navbar-item">
                        <img src="assets/icons/logo.png" class="logo">
                    </li>
                    <li class="navbar-item">
                        <a class="nav-link products-link" href="#">Productos</a>
                    </li>
                </ul>
                <a href="ajustes.jsp"><img src="assets/icons/profile.png" class="profile"></a>
                <a href="carrito.jsp"><img src="assets/icons/cart.png" class="cart"></a>
            </div>
        </nav>		
        <div id="carouselExampleSlidesOnly" class="carousel slide" data-ride="carousel">
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <img src="assets/imgs/uno.jpg" class="d-block w-100">
                </div>
                <div class="carousel-item">
                    <img src="assets/imgs/dos.png" class="d-block w-100">
                </div>
                <div class="carousel-item">
                    <img src="assets/imgs/tres.jpg" class="d-block w-100">
                </div>
                <div class="menu-overlay">
                    <form action="productos.jsp" method="post" id="filter-form">
                        <div class="filter-menu">
                            <div class="menu-item">
                                <input type="hidden" name="filter" value="L">
                                <a id="filter-link">
                                    <img src="assets/icons/book.png" width="20" height="20">
                                    <p>Libros</p>
                                </a>
                            </div>
                            <div class="menu-item">

                                <img src="assets/icons/movie.png" width="20" height="20">
                                <p>Películas</p>
                            </div>
                            <div class="menu-item">
                                <img src="assets/icons/cd.png" width="20" height="20">
                                <p>Música</p>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <div class="container">	
            <div class="catalogue">
                <br/><br/>
                <%
                try{
                    char tipo = 'N';
                    if(request.getParameter("filter")!=null){
                        tipo = request.getParameter("filter").charAt(0);
                        if(tipo=='L'){
                            out.print("<p class='title'>Catálogo de libros</p>");
                        }else if(tipo=='P'){
                            out.print("<p class='title'>Catálogo de películas</p>");
                        }else{
                            out.print("<p class='title'>Catálogo de CDs</p>");
                        }
                    }                
                    Conexion con = new Conexion();
                    Producto aux;
                    ArrayList<Producto> productos = Sentencias.readProductos(tipo);
                    for (Producto p : productos) {
                        out.print("<div class='product-container'>");
                            out.print("<div class='product-img'>");
                                out.print("<img id='id_img' src='data:image/jpg;base64,"+p.getFoto()+"'>");
                                out.print("<div class='product-overlay'></div>");
                                out.print("<div class='btn-add'><a href='ServletCarrito?accion=agregar&id="+p.getId()+"' onclick=\"agregar_carrito();\">Comprar</a></div>");
                                out.print("<div class='btn-details'><a href='detalles.jsp?sku="+p.getId()+"'>Ver detalles</a></div>");
                            out.print("</div>");
                            out.print("<p class='product-info'>");
                                out.print("<b>"+p.getNombre()+"</b><br/>");
                                out.print("$"+p.getPrecio()+" mxn");
                            out.print("</p>");
                        out.print("</div>");
                    }
                    //if (priv.equals("A")) {
                      //  out.print("<div class='product-container'><h4>Añadir producto</h4><br><br><a href='aniadir_producto.jsp'><img src='IMG/add.png' width='80' height='80'></a></div>");
                    //}
                }catch(Exception e){
                    System.out.println("ERROR (productos.jsp): "+e);
                    e.printStackTrace();
                } 
                %>
            </div>
        </div>
        <footer class="page-footer font-small">
            <div class="footer-copyright text-center py-3">
                © 2020 Copyright Upmix.
            </div>
        </footer>
        <script type="text/javascript" src="https://code.jquery.com/jquery-1.11.0.min.js"></script>
        <script type="text/javascript" src="https://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
        <script type="text/javascript">
            
            
            function agregar_carrito(){
                alert("Producto agregado al carrito de compras");
            }

            <% if(!msj.equals("")) {%>
                alert("Compra realizada con éxito");
            <%}%>
        </script>
    </body>
</html>