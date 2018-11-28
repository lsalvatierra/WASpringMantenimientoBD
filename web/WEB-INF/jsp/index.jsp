<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <spring:url var="JqueryJs" value="/Recursos/Scripts/Jquery/jquery-1.12.4.js"></spring:url>        
        <spring:url var="bootstrapCss" value="/Recursos/Content/Bootstrap/bootstrap.css"></spring:url>
        <spring:url var="bootstrapJS" value="/Recursos/Scripts/Bootstrap/bootstrap.js"></spring:url>        
        <script src="${JqueryJs}" type="text/javascript"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/1.4.0/jquery-migrate.js" type="text/javascript"></script>        
        <link href="${bootstrapCss}" rel="stylesheet" />
        <script src="${bootstrapJS}" type="text/javascript"></script>
        <script type="text/javascript">            
            $(document).ready(function(){
                $("#btnAgregar").on("click", function(){
                    ListarEspecialidad();                    
                    $("#txtCodigo").val("");
                    $("#txtNombre").val("");
                    $("#txtApellido").val(""); 
                    $("#ddlProcedencia").val("0");
                    $('#modalAlumno').modal('show');
                    
                });
                $(".btnActualizar").live("click",function(){
                    ListarEspecialidad();                    
                    $("#txtCodigo").val($(this).attr("data-idAlumno"));
                    $("#txtNombre").val($(this).attr("data-nomAlumno"));
                    $("#txtApellido").val($(this).attr("data-apeAlumno"));
                    $("#ddlProcedencia").val($(this).attr("data-Procedencia"));
                    $("#ddlEspecialidad").val($(this).attr("data-idEspecialidad"));
                    $('#modalAlumno').modal('show');                    
                });
                
                 $("#btnRegistrarDatos").on("click", function(){
                    if($("#txtCodigo").val() === ""){
                        $.ajax({                        
                            type: 'post',
                            contentType: "application/json",
                            url: '/WAMantenimientoBD/RegistrarAlumno',
                            data: JSON.stringify({ 
                                ApeAlumno: $("#txtApellido").val(),
                                NomAlumno: $("#txtNombre").val(),
                                IdEspecialidad: $("#ddlEspecialidad").val(),
                                Procedencia: $("#ddlProcedencia").val()
                            }),
                            success: function (data, textStatus, jqXHR) {
                                if(data){
                                    alert("Se registró correctamente.");
                                    ListarAlumnos();
                                }else{
                                    alert("Ocurrio un error en la base de datos.");
                                }
                            }
                        });
                    }
                    else{
                        alert("modificar");
                        $.ajax({                        
                            type: 'post',
                            contentType: "application/json",
                            url: '/WAMantenimientoBD/ModificarAlumno',
                            data: JSON.stringify({ 
                                IdAlumno: $("#txtCodigo").val(),
                                ApeAlumno: $("#txtApellido").val(),
                                NomAlumno: $("#txtNombre").val(),
                                IdEspecialidad: $("#ddlEspecialidad").val(),
                                Procedencia: $("#ddlProcedencia").val()
                            }),
                            success: function (data, textStatus, jqXHR) {
                                if(data){
                                    alert("Se actualizó correctamente.");
                                    ListarAlumnos();
                                }else{
                                    alert("Ocurrio un error en la base de datos.");
                                }
                            }
                        });
                    }
                    $('#modalAlumno').modal('hide');
                });
                
                $(".btnEliminar").live("click", function(){
                    //alert($(this).attr("data-idAlumno"));
                    $.ajax({                        
                            type: 'post',
                            contentType: "application/json",
                            url: '/WAMantenimientoBD/EliminarAlumno',
                            data: JSON.stringify({
                             IdAlumno: $(this).attr("data-idAlumno")   
                            }),
                            success: function (data, textStatus, jqXHR) {
                                if(data){
                                    alert("Se eliminó correctamente.");
                                    ListarAlumnos();
                                }else{
                                    alert("Ocurrio un error en la base de datos.");
                                }
                            }
                        });
                    });
            });

            function ListarEspecialidad(){
                $.ajax({                        
                   type: 'post',                 
                   url: '/WAMantenimientoBD/ListarEspecialidad',
                   async: false,
                   cache: false,
                   dataType: 'json',
                   success: function (data, textStatus, jqXHR) {     
                       $("#ddlEspecialidad").html("");
                       $("#ddlEspecialidad").append("<option value='0'>Seleccione</option>");
                       $.each(data, function(index, value){                           
                           $("#ddlEspecialidad").append("<option value='"+value.idEspecialidad+"'>"+value.nomEspecialidad+"</option>");
                       });                       
                   }
               });                 
            }
            
            function ListarAlumnos(){
                $.ajax({                        
                   type: 'get',                 
                   url: '/WAMantenimientoBD/ListarAlumnos',
                   async: false,
                   cache: false,
                   dataType: 'json',
                   success: function (data, textStatus, jqXHR) {
                       //alert(data);  
                       $("#tblAlumnos > tbody").html("");
                       //var Procedencia ="";
                       $.each(data, function(index, value){                           
                           /*if(value.procedencia === "P"){
                               Procedencia ="Particular";    
                           }else{
                               Procedencia ="Estatal";  
                           } */                           
                           $("#tblAlumnos > tbody").append("<tr>"+
                                   "<td>"+value.idAlumno+"</td>"+
                                   "<td>"+value.nomAlumno+"</td>"+
                                   "<td>"+value.apeAlumno+"</td>"+
                                   "<td>"+value.nomEspecialidad+"</td>"+
                                   "<td>"+value.procedencia+"</td>"+
                                   "<td><button type='button' data-idEspecialidad='"+value.idEspecialidad+"' data-Procedencia='"+value.procedencia+"' data-apeAlumno='"+value.apeAlumno+"' data-nomAlumno='"+value.nomAlumno+"' data-idAlumno='"+value.idAlumno+"' data-toggle='modal' class='btn btn-warning btnActualizar' >Edit</button></td>"+
                                   "<td><button type='button' data-idAlumno='"+value.idAlumno+"' data-toggle='modal' class='btn btn-danger btnEliminar' >X</button></td>"+
                                   "</tr>");
                       });                       
                   }
               });                 
            }
        </script>
        <title>Mantenimiento de Alumnos</title>
    </head>
    <body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
          <a class="navbar-brand" href="Principal.jsp">WA-IDAT</a>
          <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
          </button>
          <div class="collapse navbar-collapse" id="navbarNav">
          </div>
        </nav>
        <div class="card">
            
          <h5 class="card-header bg-danger text-white">Mantenimiento de alumnos</h5>
          
          <div class="card-body">
              <button type="button" data-toggle="modal" class="btn btn-primary" id="btnAgregar" >Agregar</button> 
              <br />
              <br />
            <table id="tblAlumnos" class="table table-striped table-bordered table-sm">
                <thead >
                  <tr>
                    <th scope="col">Código</th>                      
                    <th scope="col">Nombres</th>
                    <th scope="col">Apellidos</th>
                    <th scope="col">Especialidad</th>
                    <th scope="col">Procedencia</th>
                    <th scope="col">Actualizar</th>
                    <th scope="col">Eliminar</th>
                  </tr>
                </thead>
                <tbody>
                <c:forEach var = "alumno" items="${lstAlumnos}" >
                    <tr>
                        <td><c:out value="${alumno.getIdAlumno()}" ></c:out></td>
                        <td><c:out value="${alumno.getNomAlumno()}" ></c:out></td>
                        <td><c:out value="${alumno.getApeAlumno()}" ></c:out></td>
                        <td><c:out value="${alumno.getNomEspecialidad()}" ></c:out></td>
                        <td><c:out value="${alumno.getProcedencia()}" ></c:out></td>
                        <td><button type='button' data-idEspecialidad='${alumno.getIdEspecialidad()}' 
data-Procedencia='${alumno.getProcedencia()}' data-apeAlumno='${alumno.getApeAlumno
()}' data-nomAlumno='${alumno.getNomAlumno()}' data-idAlumno='${alumno.getIdAlumno
()}' data-toggle='modal' class='btn btn-warning btnActualizar' >Edit</button></td>
                        <td><button type='button' data-
idAlumno='${alumno.getIdAlumno()}' data-toggle='modal' class='btn btn-danger 
btnEliminar' >X</button></td>
                    </tr>                    
                </c:forEach>
                </tbody>
            </table>
          </div>
        </div>
    <div class="modal fade" id="modalAlumno" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
              <div class="modal-content">
                <div class="modal-header">
                  <h5 class="modal-title" id="exampleModalLabel">Mantenimiento de Alumno</h5>
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                  </button>
                </div>
                <div class="modal-body">
                  <form>
                    <div class="form-group">
                      <label for="txtCodigo" class="col-form-label">Código:</label>
                      <input type="text" readonly class="form-control" id="txtCodigo">
                    </div>
                    <div class="form-group">
                      <label for="txtNombre" class="col-form-label">Nombre:</label>
                      <input type="text" class="form-control" id="txtNombre">
                    </div>
                    <div class="form-group">
                      <label for="txtApellido" class="col-form-label">Apellido:</label>
                      <input type="text" class="form-control" id="txtApellido">
                    </div>
                    <div class="form-group">
                      <label for="ddlEspecialidad" class="col-form-label">Especialidad:</label>
                      <select class="form-control" id="ddlEspecialidad">
                      </select> 
                    </div>
                    <div class="form-group">
                      <label for="ddlProcedencia" class="col-form-label">Procedencia:</label>
                      <select class="form-control" id="ddlProcedencia">
                          <option value="0">Seleccione</option>
                          <option value="P">Particular</option>
                          <option value="N">Estatal</option>
                      </select> 
                    </div>                      
                  </form>
                </div>
                <div class="modal-footer">
                  <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                  <button type="button"  id="btnRegistrarDatos" class="btn btn-primary">Guardar</button>
                </div>
              </div>
            </div>
          </div>
    </body>
</html>
