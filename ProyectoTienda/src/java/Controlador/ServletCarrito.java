/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controlador;

import Database.Sentencias;
import Modelos.Producto;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.util.*;
import java.text.SimpleDateFormat;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet(name = "ServletCarrito", urlPatterns = {"/ServletCarrito"})
public class ServletCarrito extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try (PrintWriter out = response.getWriter()) {
            
            int idProducto = Integer.parseInt(request.getParameter("id"));
            String accion = request.getParameter("accion");
            HttpSession sesion = request.getSession();
            int[][] Cantidad = (int [][]) sesion.getAttribute("Cantidad");
            ArrayList<Producto> Carrito = (ArrayList<Producto>) sesion.getAttribute("Carrito");
            
            if(accion.equals("agregar")){
                Producto aux = Sentencias.readProductoId(idProducto);
                if(Carrito == null)
                    Carrito = new ArrayList<Producto>();  
                Carrito.add(aux);
                Cantidad = SacarCantidad(Carrito);
                sesion.setAttribute("Carrito", Carrito);
                sesion.setAttribute("Cantidad", Cantidad);
                response.sendRedirect("productos.jsp");
            }
            else if(accion.equals("quitar")){
                Producto aux = Sentencias.readProductoId(idProducto);
                //int i = Carrito.indexOf((Object) aux);
                //if(Carrito == null)
                //    Carrito = new ArrayList<Producto>();
                
                for(int i = 0; i < 100; i++){
                    if(Cantidad[i][0] == aux.getId())
                    {
                        Cantidad[i][1]--;
                        if(Cantidad[i][1] <= 0){
                            for(int k = i; k < 99; k++){
                                if(Cantidad[k+1][0] == 0)
                                    break;
                                Cantidad[k][0] = Cantidad[k+1][0];
                                Cantidad[k][1] = Cantidad[k+1][1];
                            }
                        }
                        break;
                    }
                }
                sesion.setAttribute("Cantidad", Cantidad);
                response.sendRedirect("carrito.jsp");
            }
            else if(accion.equals("Tarjeta")){
                if(idProducto == 0){
                    sesion.setAttribute("Tarjeta", "VISA");
                    response.sendRedirect("carrito.jsp");
                }                    
                else if(idProducto == 1){
                    sesion.setAttribute("Tarjeta", "Mastercard");
                    response.sendRedirect("carrito.jsp");
                }
            }
        } catch(Exception e){
            System.out.println("ERROR (ServletCarrito.doGet): "+e);
            e.printStackTrace();
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            HttpSession sesion = request.getSession();
            String username = (String) sesion.getAttribute("usuario");
            ArrayList<Producto> Carrito = (ArrayList<Producto>) sesion.getAttribute("Carrito");
            String Tarjeta = (String) sesion.getAttribute("Tarjeta");
            if(Carrito == null || Carrito.isEmpty()){
                sesion.setAttribute("Validar", "Seleccione un producto a comprar");
                response.sendRedirect("carrito.jsp");
                return;
            }
            else if(Tarjeta.equals("")){
                sesion.setAttribute("Validar", "Seleccione el tipo de tarjeta");
                response.sendRedirect("carrito.jsp");
                return;
            }
            SimpleDateFormat formateador = new SimpleDateFormat("yyyy-MM-DD");
            Date sFech =  formateador.parse(request.getParameter("FechTarjeta"));
            String aux2 = formateador.format(new Date());
            Date fechaActual =  formateador.parse(aux2);
            
            
            String sNum =  request.getParameter("NumTarjeta");
            sNum = sNum.replace(" ","");
            if(sNum.length() != 16){
                sesion.setAttribute("Validar", "Tarjeta no valida");
                response.sendRedirect("carrito.jsp");
                return;
            }
            if(sFech.before(fechaActual)){
                sesion.setAttribute("Validar", "Tarjeta Vencida");
                response.sendRedirect("carrito.jsp");
                return;
            }
            for(int i = 0; i < 16; i++){
                if (!Character.isDigit(sNum.charAt(i))){
                    sesion.setAttribute("Validar", "Tarjeta no valida");
                    response.sendRedirect("carrito.jsp");
                    return;
                }
            }
            if(sNum.charAt(0) != '4' && Tarjeta.equals("VISA")){
                sesion.setAttribute("Validar", "Tarjeta VISA no valida");
                response.sendRedirect("carrito.jsp");
                return;
            }
            int aux = Integer.parseInt(Character.toString(sNum.charAt(0)) + Character.toString(sNum.charAt(1)));
            if(!(aux > 50 && aux < 56) && Tarjeta.equals("Mastercard")){
                sesion.setAttribute("Validar", "Tarjeta Mastercard no valida");
                response.sendRedirect("carrito.jsp");
                return;
            }
            //Ingresar valor a la tabla
            int[][] Cantidad = SacarCantidad(Carrito);
            String msj = Sentencias.insertarCompra(username, Cantidad);
            //if(msj.equals("Compra realizada con éxito"))
            //    Carrito.clear();
            //sesion.setAttribute("msj", msj);
            //sesion.setAttribute("Carrito", Carrito);
            int Pedido = Sentencias.maxNoPedido() - 1;
            ResultSet Compra = Sentencias.NoVenta(Pedido);
            sesion.setAttribute("Carrito", null);
            sesion.setAttribute("Cantidad", null);
            sesion.setAttribute("rs", Compra);
            response.sendRedirect("venta_detalles.jsp");
       }catch(Exception e){
            System.out.println("ERROR (Sentencias.readProductos): "+e);
            e.printStackTrace();
        }
    }
    
    public static int[][] SacarCantidad(ArrayList<Producto> Carrito){
        int[][] Cantidad = new int [100][2];
        int k = 0;
        
        ciclo:
        for(Producto p : Carrito){
            for(int i = 0; i < 100; i++){
                if(Cantidad[i][0] == p.getId()){
                    Cantidad[i][1]++;
                    continue ciclo;
                }
                if(Cantidad[i][0] == 0){
                    k = i;
                    break;
                }
            }
            Cantidad[k][0] = p.getId();
            Cantidad[k][1] = 1;
        }
        return Cantidad;
    }
          

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
