<%-- 
    Document   : index.jsp
    Created on : 26/10/2019, 04:14:51 PM
    Author     : García Medina Saúl
                 Sánchez Castro Aarón Gamaliel
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true"%>

<%
    //COMPROBAMOS QUE NO EXISTA UNA SESIÓN INICIADA PREVIAMENTE
    String nom="";
    HttpSession sesionOK=request.getSession();
    if(sesionOK.getAttribute("perfil")!=null)
        nom=(String)sesionOK.getAttribute("nom")+" "+(String)sesionOK.getAttribute("ape");
    %>
<!DOCTYPE html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href='https://fonts.googleapis.com/css?family=Titillium+Web:400,300,600' rel='stylesheet' type='text/css'>
        <link rel="stylesheet" href="CSS/normalize.min.css">
        <link rel="stylesheet" href="CSS/style2.css">
    </head>
    <body>
        <div class="form">
            <ul class="tab-group">
              <li class="tab active"><a href="#signup">Regístrate</a></li>
              <li class="tab"><a href="#login">Iniciar Sesión</a></li>
            </ul>
            <div class="tab-content">
                <div id="signup">   
                    <h1>Carrito de Compras</h1>
                    <form action="ServletRegistro" method="POST">          
                    <div class="top-row">
                        <div class="field-wrap">
                            <label>
                                Nombre<span class="req"></span>
                            </label>
                            <input type="text" required autocomplete="off" name="txtUsu" id="txtUsu"/>
                        </div>
                        <div class="field-wrap">
                            <label>
                              Apellidos<span class="req"></span>
                            </label>
                            <input type="text"required autocomplete="off" name="txtAp" id="txtAp"/>
                        </div>
                    </div>
                    <div class="field-wrap">
                        <label>
                          Password<span class="req"></span>
                        </label>
                        <input type="password"required autocomplete="off" name="txtPas"/>
                    </div>     
                    <div class="field-wrap">
                        <label>
                            Correo<span class="req"></span>
                        </label>
                         <input maxlength="120" type="email"required autocomplete="off" name="txtEmail"/>
                    </div>     
                    <div class="field-wrap">
                        <label>
                            Localidad<span class="req"></span>
                        </label>
                        <input type="text"required autocomplete="off" name="txtLoc"/>
                    </div>                    
                    <button type="submit" class="button button-block"/>Registrarse</button>
                    </form>
                </div>
                <div id="login">   
                    <h1>¡Bienvenido!</h1>          
                    <form action="ServletLogin" method="POST">
                        <input type="hidden" name="accion" value="loguin"/>
                        <div class="field-wrap">
                            <label>
                              Nombre<span class="req"></span>
                            </label>
                            <input type="text"required autocomplete="off" name="txtUsu"/>
                        </div>
                        <div class="field-wrap">
                        <label>
                          Contraseña<span class="req" ></span>
                        </label>
                        <input type="password"required autocomplete="off" name="txtPas"/>
                        </div>
                        <button class="button button-block"/>Iniciar Sesión</button>
                    </form>
                </div>
            </div><!-- tab-content -->
        </div> <!-- /form -->
        <script src='js/jquery.min.js'></script>
        <script src="js/index.js"></script>
             <%
              if(request.getAttribute("msg")!=null)
                 out.println(request.getAttribute("msg"));
             %>        
    </body>
</html>
