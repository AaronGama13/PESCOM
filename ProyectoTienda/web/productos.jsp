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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="CSS/productos.css">
        <link rel="stylesheet" href="CSS/universal.css">
    </head>
    <script type="text/javascript">
        function agregar_carrito(){
            alert("Producto agregado al carrito de compras");
        }
        
        <% if(!msj.equals("")) {%>
            alert("Compra realizada con éxito");
        <%}%>
    </script>
    <body>
    <center>
        <header>
            <a href="productos.jsp">Bienvenido a LINIO MX feiq</a>
                <%
                if(!priv.equals("A")){ %>
                    <a href="carrito.jsp"><img class='view_cart' src="IMG/cart.jpg" width="30" height="30"></a>
                    <a href="ajustes.jsp"><img class='view_cart' src="IMG/user.jpg" width="30" height="30"></a>
                <%}
                out.print("<form action='ServletLoguin' method='POST'>");
                    out.print("<input name='username' type='hidden' value='"+username+"'>");
                    out.print("<input name='pass' type='hidden' value='X'>");
                    out.print("<input name='accion' type='hidden' value='cerrar'>");
                    out.print("<input type='submit' value='Cerrar sesión'>");
                out.print("</form>");
                %>
                    
        </header>
        <br>
        <%
        if(priv.equals("A")){ %>
            <a href="ventas.jsp"><font color="#000000" >Ventas Realizadas</font></a><br>
            <a href="reportes.jsp"><font color="#000000" >Reportes</font></a>
        <%}%>           
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
                for (Producto p : productos) {
                    out.print("<div class='product-container'>");
                        out.print("<h4>" + p.getNombre() + "</h4><br><br>");
                        out.print("<img id='id_img' src='data:image/jpg;base64," + p.getFoto() + "' width='50' height='50' ><br><br>");
                        out.print("$ " + p.getPrecio() + " mxn<br>");
                        if (priv.equals("A")) {
                            out.print(p.getStock() + " unidades disponibles");
                            out.print("<a href='detalles.jsp?sku="+p.getId()+"'><button>Editar producto</button></a>");
                            out.print("</div>");
                        } else {
                            out.print("<a href='ServletCarrito?accion=agregar&id=" + p.getId() + "'><button class='add_cart' onclick=\"agregar_carrito();\">Agregar al carrito</button></a><br>");
                            out.print("<a href='detalles.jsp?sku=" + p.getId() + "'><button class='detail_btn'>Ver detalles</button></a>");
                            out.print("</div>");
                        }
                }
                if (priv.equals("A")) {
                    out.print("<div class='product-container'><h4>Añadir producto</h4><br><br><a href='aniadir_producto.jsp'><img src='IMG/add.png' width='80' height='80'></a></div>");
                }   
            }catch(Exception e){
                System.out.println("ERROR (productos.jsp): "+e);
                e.printStackTrace();
            }
            %>
            <% if(sesionOK.getAttribute("username") != null){%>
            <a href="ServletLoguin?accion=cerrar">Cerrar sesion</a>
            <%}%>
        </div>
        <div class="product-detail">
            <h3></h3>
        </div>
    </center>
    </body>
</html>
