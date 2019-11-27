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
        <link rel="stylesheet" href="CSS/universal.css">
        <link rel="stylesheet" href="CSS/style3.css">
        <title>Ajustes</title>
        
    </head>
    <body>
        <div>
        <div class="form">
        <div class="tab-content">
        <center><h1>Eliminar cuenta</h1></center>
        
            <form action="ServletLoguin?accion=borrar" method="POST">
                
                
                <center><input type="text" name="username" placeholder="Usuario" class="Fields"></center><br>
                
                <center><input type="password" name="pass" placeholder="Contraseña" ></center><br>
                <center><input type="submit" class="button button-block"  name="ENVIAR"></center>
                
            </form>
        
        </div>
            </div>
        <div>
            <center>
                <label>Para eliminar su cuenta introduzca su usuario y contraseña</label>
            </center>
            
            
        </div>
            </div>
    </body>
</html>