package controllers;

import entities.empleados.EmpleadoVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import services.EmpleadoService;
import services.IEmpleadoService;

import java.util.List;

// This class will handle incoming HTTP requests

// PUT is used to update a whole element, like a whole employee in the database, and not one of the attributes of an employee
// PATCH is used to modify one attribute, or element from an employee, not the whole employee.
@RestController
@RequestMapping("/api/empleado")
public class EmpleadoController {
    private final EmpleadoService empleadoService;
    public EmpleadoController(EmpleadoService empleadoService){
        this.empleadoService = empleadoService;

    }
    @GetMapping
    public List<EmpleadoVO> getAll(){
    return empleadoService.getAll();
    }

    @GetMapping("/{id}")
    @ResponseBody
    public EmpleadoVO getByID(@RequestBody long id){
        return empleadoService.getByID(id);
    }

    @PostMapping
    public EmpleadoVO create(@RequestBody EmpleadoVO empleado){
        return empleadoService.insert();
    }



}
