<%-- 
    Document   : detalles
    Created on : 13/11/2019, 12:22:46 PM
    Author     : gamma
--%>

<%@page import="Modelos.Producto"%>
<%@page import="Database.Sentencias"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="CSS/universal.css">
    </head>
    <body>
        <header>
            <%
                HttpSession sesionOK = request.getSession();
                String username = (String) sesionOK.getAttribute("usuario");
                String priv = (String) sesionOK.getAttribute("priv");
                if(sesionOK.getAttribute("usuario") == null){
                    response.sendRedirect("index.jsp");
                }else{
                    out.print(username);
                    out.print(priv);
                }
            %>
            <a href="productos.jsp">Bienvenido a LINIO MX feiq</a>
            <a href="carrito.jsp"><img class='view_cart' src="IMG/cart.jpg" width="50" height="50"></a>
            <a href="ajustes.jsp"><img class='view_cart' src="IMG/user.jpg" width="50" height="50"></a>
        </header>
        <center>
            <div>
                <%
                    int idProducto = Integer.parseInt(request.getParameter("sku"));
                    Producto aux = Sentencias.readProductoId(idProducto);
                    out.print("<br><br><img id='id_img' src='data:image/jpg;base64,"+aux.getFoto()+"'><br>");
                    out.print("<div>");
                    out.print("<h4>"+aux.getNombre()+"</h4><br>");
                    out.print("$ "+aux.getPrecio()+" mxn<br>");
                    out.print("<h5>"+aux.getDetalles()+"</h5>");
                    out.print("<a href='ServletCarrito?id="+aux.getId()+"'><button class='add_cart' onclick=\"agregar_carrito();\">Agregar al carrito</button></a><br>");
                    out.print("</div>");
                %>
            </div>
        </center>
    </body>
</html>
