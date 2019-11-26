<%-- 
    Document   : aniadir_producto
    Created on : 15/11/2019, 08:59:37 PM
    Author     : saulg
--%>
<%
    //COMPROBAMOS QUE NO EXISTA UNA SESIÓN INICIADA PREVIAMENTE    
    HttpSession sesionOK = request.getSession();   
    String username = "";
    String priv = "";    
    if(sesionOK.getAttribute("usuario") != null){
        username = (String) sesionOK.getAttribute("usuario");
        priv = (String) sesionOK.getAttribute("priv");        
    }
    %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="CSS/universal.css">
        <link rel="stylesheet" href="CSS/style3.css">
        <title>Añadir Producto</title>
    </head>
    <body>
        <div class="form">
        <div class="tab-content">
    <center><h1>Añadir producto</h1></center>
    <form action="ServletAniadir" method="POST" enctype="multipart/form-data">
            <center>
                <input type="text" name="nom" placeholder="Nombre del producto"><br><br>
                <input type="number" name="precio" step="0.01" placeholder="Precio"><br><br>
                <input type="number" name="stock" placeholder="Cantidad"><br><br>
                <input type="text" name="tipo" placeholder="Tipo de producto"><br><br>
                
                <input type="file" name="foto" required><br><br>
                <textarea spellcheck="true" name="detalles" placeholder="Detalles"></textarea><br><br>
                
                <input class="button button-block" type="submit">
            </center>
        </form>
    </div>
        </div>
    </body>
</html>
