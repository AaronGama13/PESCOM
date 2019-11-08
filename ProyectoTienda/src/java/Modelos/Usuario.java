/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Modelos;

/**
 *
 * @author saulg
 */
public class Usuario {
    private String username, np, ap, am, calle, col, alc, muni, edo, cd, tel, pass;
    private int noExt, noInt, cp;

    public Usuario(String username, String np, String ap, String am, String calle, String col, String alc, String muni, String edo, String cd, String tel, String pass, int noExt, int noInt, int cp) {
        this.username = username;
        this.np = np;
        this.ap = ap;
        this.am = am;
        this.calle = calle;
        this.col = col;
        this.alc = alc;
        this.muni = muni;
        this.edo = edo;
        this.cd = cd;
        this.tel = tel;
        this.pass = pass;
        this.noExt = noExt;
        this.noInt = noInt;
        this.cp = cp;
    }        

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getNp() {
        return np;
    }

    public void setNp(String np) {
        this.np = np;
    }

    public String getAp() {
        return ap;
    }

    public void setAp(String ap) {
        this.ap = ap;
    }

    public String getAm() {
        return am;
    }

    public void setAm(String am) {
        this.am = am;
    }

    public String getCalle() {
        return calle;
    }

    public void setCalle(String calle) {
        this.calle = calle;
    }

    public String getCol() {
        return col;
    }

    public void setCol(String col) {
        this.col = col;
    }

    public String getAlc() {
        return alc;
    }

    public void setAlc(String alc) {
        this.alc = alc;
    }

    public String getMuni() {
        return muni;
    }

    public void setMuni(String muni) {
        this.muni = muni;
    }

    public String getEdo() {
        return edo;
    }

    public void setEdo(String edo) {
        this.edo = edo;
    }

    public String getCd() {
        return cd;
    }

    public void setCd(String cd) {
        this.cd = cd;
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    public String getPass() {
        return pass;
    }

    public void setPass(String pass) {
        this.pass = pass;
    }

    public int getNoExt() {
        return noExt;
    }

    public void setNoExt(int noExt) {
        this.noExt = noExt;
    }

    public int getNoInt() {
        return noInt;
    }

    public void setNoInt(int noInt) {
        this.noInt = noInt;
    }

    public int getCp() {
        return cp;
    }

    public void setCp(int cp) {
        this.cp = cp;
    }
    
    
}
