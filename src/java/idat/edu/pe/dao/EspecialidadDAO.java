/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package idat.edu.pe.dao;

import idat.edu.pe.bd.BDConnection;
import idat.edu.pe.idao.IEspecialidadDAO;
import idat.edu.pe.model.Especialidad;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author LuisAngel
 */
public class EspecialidadDAO implements IEspecialidadDAO{

    @Override
    public List<Especialidad> ListarEspecialidad() {
List<Especialidad> lista = new ArrayList<>();
            BDConnection objCon = new BDConnection();            
            Connection con = objCon.EstablecerConexion();
            try{
                //CallableStatement cstmt = con.prepareCall("{call dbo.sp_ListarAlumno}");
                Statement cstmt = con.createStatement();
                ResultSet rs =cstmt.executeQuery("{call dbo.sp_Especialidad}");
                while (rs.next()) {
                   lista.add(new Especialidad(rs.getString(1),rs.getString(2),rs.getDouble(3)));
                }
                rs.close();
                cstmt.close();
                objCon.Desconectar();
            }catch(SQLException ex){
                ex.printStackTrace();
            }            
         return lista;        
    }
    
}
