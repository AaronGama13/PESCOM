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
                    <h1>¡Únete!</h1>
                    <form action="ServletRegistro" method="POST">          
                    <div class="top-row">
                        <div class="field-wrap">
                            <label>
                                Usuario<span class="req"></span>
                            </label>
                            <input type="text" required autocomplete="off" name="username" id="username"/>
                        </div>
                        <div class="field-wrap">
                            <label>
                                Nombre<span class="req"></span>
                            </label>
                            <input type="text" required autocomplete="off" name="np" id="np"/>
                        </div>
                    </div>
                    <div class="top-row">    
                        <div class="field-wrap">
                            <label>
                              Apellido paterno<span class="req"></span>
                            </label>
                            <input type="text"required autocomplete="off" name="ap" id="ap"/>
                        </div>
                        <div class="field-wrap">
                            <label>
                                Apellido materno<span class="req"></span>
                            </label>
                            <input type="text" required autocomplete="off" name="am" id="am"/>
                        </div>
                    </div>
                    <div class="top-row">    
                        <div class="field-wrap">
                            <label>
                                Calle<span class="req"></span>
                            </label>
                            <input type="text" required autocomplete="off" name="calle" id="calle"/>
                        </div>
                        <div class="field-wrap">
                            <label>
                                No. Exterior<span class="req"></span>
                            </label>
                            <input type="number" required autocomplete="off" name="noExt" id="noExt"/>
                        </div>
                    </div>
                    <div class="top-row">    
                        <div class="field-wrap">
                            <label>
                                No. Interior<span class="req"></span>
                            </label>
                            <input type="number" required autocomplete="off" name="noInt" id="noInt"/>
                        </div>
                        <div class="field-wrap">
                            <label>
                                Colonia<span class="req"></span>
                            </label>
                            <input type="text" required autocomplete="off" name="col" id="col"/>
                        </div>
                    </div>
                    <div class="top-row">    
                        <div class="field-wrap">
                            <label>
                                Alcaldía<span class="req"></span>
                            </label>
                            <input type="text" required autocomplete="off" name="alc" id="alc"/>
                        </div>
                        <div class="field-wrap">
                            <label>
                                Municipio<span class="req"></span>
                            </label>
                            <input type="text" required autocomplete="off" name="muni" id="muni"/>
                        </div>
                    </div>
                    <div class="top-row">    
                        <div class="field-wrap">
                            <label>
                                Estado<span class="req"></span>
                            </label>
                            <input type="text" required autocomplete="off" name="edo" id="edo"/>
                        </div>
                        <div class="field-wrap">
                            <label>
                                Ciudad<span class="req"></span>
                            </label>
                            <input type="text" required autocomplete="off" name="cd" id="cd"/>
                        </div>
                    </div>
                    <div class="top-row">
                        <div class="field-wrap">
                            <label>
                                Código Postal<span class="req"></span>
                            </label>
                            <input type="number" required autocomplete="off" name="cp" id="cp"/>
                        </div>
                        <div class="field-wrap">
                            <label>
                                Teléfono<span class="req"></span>
                            </label>
                            <input type="text" required autocomplete="off" name="tel" id="tel"/>
                        </div>
                    </div>
                    <div class="top-row">
                        <div class="field-wrap">
                            <label>
                                Contraseña<span class="req"></span>
                            </label>
                            <input type="password" required autocomplete="off" name="pass" id="pass"/>
                        </div>
                    </div>                    
                        <br>                    
                    <button type="submit" class="button button-block"/>Registrarse</button>
                    </form>
                </div>
                
                <div id="login">   
                    <h1>¡Bienvenido!</h1>          
                    <form action="ServletLoguin?accion=loguin" method="POST">
                        <input type="hidden" name="accion" value="loguin"/>
                        <div class="field-wrap">
                            <label>
                              Usuario<span class="req"></span>
                            </label>
                            <input type="text"required autocomplete="off" name="username"/>
                        </div>
                        <div class="field-wrap">
                        <label>
                          Contraseña<span class="req" ></span>
                        </label>
                        <input type="password"required autocomplete="off" name="pass"/>
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
