/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controlador;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import Modelos.RegistrarU;

/**
 *
 * @author saulg
 */
@WebServlet(name = "ServletRegistro", urlPatterns = {"/ServletRegistro"})
public class ServletRegistro extends HttpServlet {

    String username, np, ap, am, calle, col, alc, muni, edo, cd, pass;
    int noExt, noInt, cp, tel;
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            
            username = request.getParameter("username");
            np = request.getParameter("np");
            ap = request.getParameter("ap");
            am = request.getParameter("am");
            calle = request.getParameter("calle");
            noExt = Integer.parseInt(request.getParameter("noExt"));
            noInt = Integer.parseInt(request.getParameter("noInt"));
            col = request.getParameter("col");
            alc = request.getParameter("alc");
            muni = request.getParameter("muni");
            edo = request.getParameter("edo");
            cd = request.getParameter("cd");
            cp = Integer.parseInt(request.getParameter("cp"));
            tel = Integer.parseInt(request.getParameter("tel"));
            pass = request.getParameter("pass");
            
            RegistrarU registrar = new RegistrarU();
            
            if(registrar.registro(username, np, ap, am, calle, noExt, noInt, col, alc, muni, edo, cd, cp, tel, pass)) {
                response.sendRedirect("index.jsp");
            } else {
                request.setAttribute("msg", "No se pudieron registrar sus datos");
                request.getRequestDispatcher("index.jsp").forward(request, response);
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
