/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package idat.edu.pe.controller;

import com.google.gson.Gson;
import idat.edu.pe.dao.EspecialidadDAO;
import idat.edu.pe.dao.MantAlumnoDAO;
import idat.edu.pe.model.Alumno;
import idat.edu.pe.model.Especialidad;
import java.util.ArrayList;
import java.util.List;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 *
 * @author LuisAngel
 */
@Controller
public class AlumnoController {
    
    @RequestMapping(value ="/", method = RequestMethod.GET)
    public String index (Model model){
        MantAlumnoDAO objAlumnoDAO = new MantAlumnoDAO();
        List<Alumno> lstAlumnos = objAlumnoDAO.ListarAlumnos();
        model.addAttribute("lstAlumnos",lstAlumnos);
        return "index";
    }
    
    @RequestMapping(value ="/ListarEspecialidad", method = RequestMethod.POST, produces = "application/json")
    public @ResponseBody List<Especialidad> Especialidad (){
        EspecialidadDAO objEspeDAO = new EspecialidadDAO();
        List<Especialidad> lstEspecialidad = objEspeDAO.ListarEspecialidad();        
        return lstEspecialidad;
    }
    @RequestMapping(value ="/EliminarAlumno", method = RequestMethod.POST,  consumes = "application/json", produces = "application/json")
    public @ResponseBody Boolean MantEliminarAlumno (@RequestBody  String IdAlumno){
        MantAlumnoDAO objAlumnoDAO = new MantAlumnoDAO();        
        Boolean rpta = objAlumnoDAO.EliminarAlumno(IdAlumno);
        return rpta;
    }    
    
    @RequestMapping(value ="/RegistrarAlumno", method = RequestMethod.POST)
    public @ResponseBody Boolean MantRegistrarAlumno (@RequestParam(value = "ApeAlumno", required = true) String ApeAlumno, @RequestParam(value = "NomAlumno", required = true) String NomAlumno, @RequestParam(value = "IdEspecialidad", required = true) String IdEspecialidad, @RequestParam(value = "Procedencia", required = true) String Procedencia){
        MantAlumnoDAO objAlumnoDAO = new MantAlumnoDAO();   
        Alumno objAlumno = new Alumno("", ApeAlumno, NomAlumno, IdEspecialidad, Procedencia);
        Boolean rpta = objAlumnoDAO.RegistrarAlumno(objAlumno);
        return rpta;
    }
    
    
    
    @RequestMapping(value="/json", method=RequestMethod.GET, produces = "application/json")
    public @ResponseBody List<String> jsonPage() {

            List<String> result = new ArrayList<String>();
            result.add("Hello World!");

        return result;
    }
}
