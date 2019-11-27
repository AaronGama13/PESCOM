<%-- 
    Document   : ajustes
    Created on : 13/11/2019, 12:22:33 PM
    Author     : gamma
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    //COMPROBAMOS QUE NO EXISTA UNA SESIÓN INICIADA PREVIAMENTE    
    HttpSession sesionOK = request.getSession();   
    String username;
    if(sesionOK.getAttribute("usuario") != null){
        username = (String) sesionOK.getAttribute("usuario");
    }
    %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ajustes</title>
    </head>
    <body>
        <div>
            <form action="ServletLoguin?accion=borrar" method="POST">
                <center><h3>Eliminar cuenta</h3></center>
                <center><label>Para eliminar su cuenta introduzca su usuario y contraseña</label></center><br>
                <center><input type="text" name="username" placeholder="Usuario"></center><br>
                <center><input type="password" name="pass" placeholder="Contraseña"></center><br>
                <center><input type="submit" name="borrar"></center>
            </form>
        </div>
    </body>
</html>
