<%-- 
    Document   : RegistroU
    Created on : 6/11/2019, 09:24:41 PM
    Author     : saulg
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <table border="0" width="300" align="Center">
           <form action="RegistroUs" method="post">           
           <tr>
               <td>Usuario:</td>
               <td><input type="text" placeholder="Usuario" name="username"></td>
           </tr>
           <tr>
               <td>Nombre:</td>
               <td><input type="text" placeholder="Nombre" name="np"></td>
           </tr>
           <tr>
               <td>Apellido Paterno:</td>
               <td> <input type="text" placeholder="Apellido Paterno" name="ap"></td>
           </tr>
           <tr>
               <td>Apellido Materno:</td>
               <td> <input type="text" placeholder="Apellido Materno" name="am"></td>
           </tr>
           <tr>
               <td>Calle:</td>
               <td> <input type="text" placeholder="Calle" name="calle"></td>
           </tr>
           <tr>
               <td>No. Exterior:</td>
               <td> <input type="number" placeholder="No. Exterior" name="noExt"></td>
           </tr>
           <tr>
               <td>No. Interior:</td>
               <td> <input type="text" placeholder="No. Interior" name="noInt"></td>
           </tr>
           <tr>
               <td>Colonia:</td>
               <td> <input type="text" placeholder="Colonia" name="col"></td>
           </tr>
           <tr>
               <td>Alcaldía:</td>
               <td> <input type="text" placeholder="Alcaldía" name="alc"></td>
           </tr>
           <tr>
               <td>Municipio:</td>
               <td> <input type="text" placeholder="Municipio" name="muni"></td>
           </tr>
           <tr>
               <td>Estado:</td>
               <td> <input type="text" placeholder="Estado" name="edo"></td>
           </tr>
           <tr>
               <td>Ciudad:</td>
               <td> <input type="text" placeholder="Ciudad" name="cd"></td>
           </tr>
           <tr>
               <td>Código Postal:</td>
               <td> <input type="number" placeholder="Código postal" name="cp"></td>
           </tr>
           <tr>
               <td>Teléfono:</td>
               <td> <input type="text" placeholder="Teléfono" name="tel"></td>
           </tr>
            <tr>
               <td>Password:</td>
               <td> <input type="password" placeholder="Password" name="txtPas"></td>
           </tr>                                   
           <tr>
               <th colspan="2">
                 <input type="submit" name="btn" value="Registrar"> 
               </th>
           </tr> 
           </form>
        </table>
    </body>
</html>