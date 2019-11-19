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
        <link rel="stylesheet" href="CSS/detalles.css">
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
                    out.print("<br><br><img id='id_img' src='data:image/jpg;base64,"+aux.getFoto()+"'><br><br>");
                    if(priv.equals("A")){
                        out.print("<div class='details-container'>");
                        out.print("<form action='ServletModProd' method='POST'>");
                        out.print("<input name='id' type='hidden' value='"+idProducto+"'>");
                        out.print("<label>Cambiar nombre:</label><input name='nombre' type='text' value='"+aux.getNombre()+"'><br><br>");
                        out.print("<label>Cambiar precio:</label><input name='precio' type='number' value='"+aux.getPrecio()+"'> mxn<br><br>");
                        out.print("<label>Cambiar stock:</label><input name='stock' type='number' value='"+aux.getStock()+"'>unidades disponibles<br><br>");
                        out.print("<label>Cambiar detalles:</label><br><textarea name='detalles'>"+aux.getDetalles()+"</textarea><br><br>");
                        out.print("<input type='submit' value='Modificar producto'>");
                        out.print("</div>");
                        out.print("</form>");
                    }else{
                        out.print("<div>");
                        out.print("<h4>"+aux.getNombre()+"</h4><br>");
                        out.print("$ "+aux.getPrecio()+" mxn<br>");
                        out.print("<h5>"+aux.getDetalles()+"</h5>");
                        out.print("<a href='ServletCarrito?accion=agregar&id="+aux.getId()+"'><button class='add_cart' onclick=\"agregar_carrito();\">Agregar al carrito</button></a><br>");
                        out.print("</div>");
                    }
                %>
            </div>
        </center>
    </body>
</html>
