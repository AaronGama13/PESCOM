/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controlador;

import Database.Sentencias;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author saulg
 */
@WebServlet(name = "ServletLoguin", urlPatterns = {"/ServletLoguin"})
public class ServletLoguin extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            String username = request.getParameter("username");
            String pass = request.getParameter("pass");                        
            String accion = request.getParameter("accion");
            
            if (accion.equals("loguin")) {
                if (username.isEmpty() || pass.isEmpty()) {
                    request.setAttribute("msg", "Llena todos los campos");
                    request.getRequestDispatcher("index.jsp").forward(request, response);
                } else {
                    if (Sentencias.autenticacion(username, pass)) {
                        String priv = Sentencias.privilegio(username);
                        HttpSession sesion = request.getSession();
                        sesion.setAttribute("usuario", username); 
                        sesion.setAttribute("priv", priv);
                        sesion.setAttribute("Carrito", null);
                        sesion.setAttribute("Cantidad", null);
                        sesion.setAttribute("Tarjeta", "");
                        sesion.setAttribute("msj", "");
                        sesion.setAttribute("Validar", "");
                        response.sendRedirect("productos.jsp");                        
                    } else {
                        request.setAttribute("msg", "Usuario o contraseña incorrectos");
                        request.getRequestDispatcher("index.jsp").forward(request, response);
                    }
                }
            }
            else if(accion.equals("cerrar")) {
                HttpSession sesion = request.getSession();
                request.getSession().removeAttribute("usuario");
                sesion.invalidate();
                response.sendRedirect("index.jsp");
            }
            
            else if(accion.equals("borrar")) {
                if (username.isEmpty() || pass.isEmpty()) {
                    request.setAttribute("msg", "Llena todos los campos");
                    request.getRequestDispatcher("index.jsp").forward(request, response);
                } else {
                    if(Sentencias.borrarUsuario(username, pass)) {
                        HttpSession sesion = request.getSession();
                        request.getSession().removeAttribute("usuario");
                        sesion.invalidate();
                        response.sendRedirect("index.jsp");
                    }
                }
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
