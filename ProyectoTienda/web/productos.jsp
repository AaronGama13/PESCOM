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
    ArrayList<Producto> Carrito = new ArrayList<Producto>();
    /*if(sesionOK.getAttribute("usuario") != null){
        username = (String) sesionOK.getAttribute("usuario");
        Carrito = (ArrayList<Producto>) sesionOK.getAttribute("Carrito");
    }*/
    %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="CSS/productos.css">
        <link rel="stylesheet" href="CSS/universal.css">
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
                /*if(sesionOK.getAttribute("usuario") == null){
                    response.sendRedirect("index.jsp");
                }else{
                    out.print(username);
                }*/
            %>
            <a href="productos.jsp">Bienvenido a LINIO MX feiq</a>
            <a href="carrito.jsp"><img class='view_cart' src="IMG/cart.jpg" width="30" height="30"></a>
            <a href="ajustes.jsp"><img class='view_cart' src="IMG/user.jpg" width="30" height="30"></a>
        </header>
        <h1>Productos disponibles</h1>
        <div class="filter_by">        
            <h3>Filtrar por:
                <form action="productos.jsp" method="post">
                    <select name="filter" onchange="this.form.submit();" >
                        <option value="N">Todos</option>
                        <option value='I'>Imágenes</option>
                        <option value="L">Libros</option>
                        <option value="P">Películas</option>
                        <option value="M">Música</option>
                    </select>
                </form>
            </h3>
        </div><br><br><br><br><br>  
        <div>
            <%
            try{
                Conexion con = new Conexion();
                Producto aux;
                char tipo = 'N';
                if(request.getParameter("filter")!=null){
                    tipo = request.getParameter("filter").charAt(0);
                }
                ArrayList<Producto> productos = Sentencias.readProductos(tipo);
                for(Producto p : productos){
                    out.print("<div class='product-container'>");
                        out.print("<h4>"+p.getNombre()+"</h4><br><br>");
                        out.print("<img id='id_img' src='data:image/jpg;base64,"+p.getFoto()+"' width='50' height='50' ><br><br>");
                        out.print("$ "+p.getPrecio()+" mxn<br>");
                        /*
                        NOTA:
                        SE DEBE VERIFICAR LOS PRIVILEGIOS DEL USUARIO ANTES DE IMPRIMIR LAS DOS SIGUIENTES LINEAS DE CODIGO
                        SI ES USUARIO ADMIN SE MUESTRAN LAS SIGUIENTES LÍNEAS
                        out.print(p.getStock()+" unidades disponibles");
                        out.print("<a href='editar_producto.jsp'><button>Editar producto</button></a>");
                        */
                        out.print("<a href='ServletCarrito?id="+p.getId()+"'><button class='add_cart' onclick=\"agregar_carrito();\">Agregar al carrito</button></a><br>");
                        out.print("<a href='detalles.jsp?sku="+p.getId()+"'><button class='detail_btn'>Ver detalles</button></a>");
                    out.print("</div>");
                }
                /*
                    SI EL USUARIO ES ADMIN DESCOMENTAR ESTAS LINEAS
                */
            }catch(Exception e){
                System.out.println("ERROR (productos.jsp): "+e);
                e.printStackTrace();
            }
            %>
        </div>
        <div class="product-detail">
            <h3></h3>
        </div>
    </center>
    </body>
</html>
