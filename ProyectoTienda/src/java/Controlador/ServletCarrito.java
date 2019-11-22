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
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "ServletCarrito", urlPatterns = {"/ServletCarrito"})
public class ServletCarrito extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try (PrintWriter out = response.getWriter()) {
            
            int idProducto = Integer.parseInt(request.getParameter("id"));
            String accion = request.getParameter("accion");
            HttpSession sesion = request.getSession();
            ArrayList<Producto> Carrito = (ArrayList<Producto>) sesion.getAttribute("Carrito");
            
            if(accion.equals("agregar")){
                Producto aux = Sentencias.readProductoId(idProducto);
                if(Carrito == null)
                    Carrito = new ArrayList<Producto>();  
                Carrito.add(aux);
                sesion.setAttribute("Carrito", Carrito);
                response.sendRedirect("productos.jsp");
            }
            else if(accion.equals("quitar")){
                //Producto aux = Sentencias.readProductoId(idProducto);
                Carrito.remove(idProducto);
                if(Carrito == null)
                    Carrito = new ArrayList<Producto>();
                sesion.setAttribute("Carrito", Carrito);
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
            else if(accion.equals("Validar")){
                String Tarjeta = (String) sesion.getAttribute("Tarjeta");
                if(Tarjeta.equals("")){
                    sesion.setAttribute("Validar", "Seleccione el tipo de tarjeta");
                    response.sendRedirect("carrito.jsp");
                }
                String sNum =  request.getParameter("id");
                sNum = sNum.replace(" ","");
                if(sNum.length() != 16){
                    sesion.setAttribute("Validar", "Tarjeta no valida");
                    response.sendRedirect("carrito.jsp");
                }
                for(int i = 0; i < 16; i++){
                    if (!Character.isDigit(sNum.charAt(i))){
                        sesion.setAttribute("Validar", "Tarjeta no valida");
                        response.sendRedirect("carrito.jsp");
                    }
                }
                if(sNum.charAt(0) != '4' && Tarjeta.equals("VISA")){
                    sesion.setAttribute("Validar", "Tarjeta VISA no valida");
                    response.sendRedirect("carrito.jsp");
                }
                int aux = Integer.parseInt(Character.toString(sNum.charAt(0)) + Character.toString(sNum.charAt(1)));
                if(!(aux > 50 && aux < 56) && Tarjeta.equals("VISA")){
                    sesion.setAttribute("Validar", "Tarjeta Mastercard no valida");
                    response.sendRedirect("carrito.jsp");
                }
                sesion.setAttribute("Validar", "Tarjeta valida");
                response.sendRedirect("detalles_compra.jsp");
            }
        } catch(Exception e){
            System.out.println("ERROR (Sentencias.readProductos): "+e);
            e.printStackTrace();
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            HttpSession sesion = request.getSession();
            String Tarjeta = (String) sesion.getAttribute("Tarjeta");
            if(Tarjeta.equals("")){
                sesion.setAttribute("Validar", "Seleccione el tipo de tarjeta");
                response.sendRedirect("carrito.jsp");
                return;
            }
            String sNum =  request.getParameter("NumTarjeta");
            sNum = sNum.replace(" ","");
            if(sNum.length() != 16){
                sesion.setAttribute("Validar", "Tarjeta no valida");
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
            response.sendRedirect("detalles_compra.jsp");
       }catch(Exception e){
            System.out.println("ERROR (Sentencias.readProductos): "+e);
            e.printStackTrace();
        }
    }
          

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
