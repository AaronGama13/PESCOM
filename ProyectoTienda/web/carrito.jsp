<%-- 
    Document   : carrito
    Created on : 26/10/2019, 05:55:09 PM
    Author     : gamma
--%>

<%@page import="java.util.Base64"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.sql.Blob"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Modelos.Producto"%>
<%@page import="Database.Sentencias"%>
<%@page import="Database.Conexion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    //COMPROBAMOS QUE NO EXISTA UNA SESIÓN INICIADA PREVIAMENTE    
    HttpSession sesionOK = request.getSession();   
    String username = null ,priv = null;
    ArrayList<Producto> Carrito = null;
    String Tarjeta = "";
    String Validar = "";
    int [][] Cantidad = new int[100][2];
    if(sesionOK.getAttribute("usuario")!=null){
        username = (String) sesionOK.getAttribute("usuario");
        priv = (String) sesionOK.getAttribute("priv");
        Carrito = (ArrayList<Producto>) sesionOK.getAttribute("Carrito");
        Tarjeta = (String) sesionOK.getAttribute("Tarjeta");
        Validar = (String) sesionOK.getAttribute("Validar");
        Cantidad = (int[][]) sesionOK.getAttribute("Cantidad");
    }
    
    if(priv.equals("A")){
        response.sendRedirect("productos.jsp");
        out.print("<script type='text/javascript'>alert('No tienes permiso para entrar al carrito');</script>");
    }
    %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <!--Scripts-->
	<!--Estilos-->
	<link rel="stylesheet" type="text/css" href="CSS/carrito.css">
	<link href="https://fonts.googleapis.com/css?family=Roboto&display=swap" rel="stylesheet"> 
    </head>
    <body>
        <!--Cabecera-->
	<header id="cabecera">
		<div id="logo">
			<h1>UPMIXLOGO</h1>
		</div>
		<nav id="menu">
			<ul>
				<li><a href="#">Perfil</a></li>
				<li><a href="#">Catálogo</a></li>
			</ul>
		</nav>
	</header>
	<div class="clearfix"></div>
	<section id="global">
		<div id="carrito">
			<header id="tu-carrito">
				<h1>Tu carrito</h1>
				<div class="carroC">	
					<img src="IMG/carrito.png">
				</div>
				<div class="clearfix"></div>
			</header>
			<div id="productos">
				<ul id="lista-productos">
					<div class="articulo">
						<li>							
							<img src="IMG/img1.jpg" id="imagen">							
							<div id="descripcion">
								<p>CD Appetite for Destruction - Guns N' Roses</p>
							</div>
							<div id="precio">
								<p>$10,000</p>
							</div><br><br>
							<div id="btn-remover">
								<form method="post">
									<input type="submit" name="remover" id="remover" value="remover">
								</form>
							</div>
						</li>		
						<div class="clearfix"></div>								
					</div><hr>
					<div class="articulo">
						<li>							
							<img src="IMG/img2.jpg" id="imagen">							
							<div id="descripcion">
								<p>Las Batallas en el Desierto - José Emilio Pacheco</p>
							</div>
							<div id="precio">
								<p>$10,000</p>
							</div><br><br>
							<div id="btn-remover">
								<form method="post">
									<input type="submit" name="remover" id="remover" value="remover">
								</form>
							</div>
						</li>		
						<div class="clearfix"></div>								
					</div><hr>
					<div class="articulo">
						<li>							
							<img src="IMG/img3.jpeg" id="imagen">							
							<div id="descripcion">
								<p>Juego Nintendo Switch Super Smash Bros Ultimate</p>
							</div>
							<div id="precio">
								<p>$10,000</p>
							</div><br><br>
							<div id="btn-remover">
								<form method="post">
									<input type="submit" name="remover" id="remover" value="remover">
								</form>
							</div>
						</li>		
						<div class="clearfix"></div>								
					</div><hr>
					<div class="articulo">
						<li>							
							<img src="IMG/img4.jpg" id="imagen">							
							<div id="descripcion">
								<p>Avengers Endgame Bluray</p>
							</div>
							<div id="precio">
								<p>$10,000</p>
							</div><br><br>
							<div id="btn-remover">
								<form method="post">
									<input type="submit" name="remover" id="remover" value="remover">
								</form>
							</div>
						</li>		
						<div class="clearfix"></div>								
					</div><hr>
				</ul>
			</div>
		</div>
		<div id="subtotal">
			<div id="resumen">
				<h1>resumen</h1>
			</div>
			<div id="total">
				<span>Total a pagar</span><br>
				<span>$40,000</span>
			</div>
			<div id="pagar">
				<form>
					<input type="submit" name="pagar" id="btn-pagar" value="pagar">
				</form>
			</div>
			<button id="seguir-comprando">Seguir comprando</button>
		</div>
		<div class="clearfix"></div>
	</section>
    </body>
</html>
