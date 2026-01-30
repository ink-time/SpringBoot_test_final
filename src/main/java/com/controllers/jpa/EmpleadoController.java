package com.controllers.jpa;

import com.entities.EmpleadoVO;
import org.springframework.web.bind.annotation.*;
import com.services.EmpleadoService;

import java.util.List;
import java.util.Map;

// This class will handle incoming HTTP requests

// PUT is used to update a whole element, like a whole employee in the database, and not one of the attributes of an employee
// PATCH is used to modify one attribute, or element from an employee, not the whole employee.
@RestController
@RequestMapping("/EmpleadoVO")
public class EmpleadoController {
    private final EmpleadoService empleadoService;
    public EmpleadoController(EmpleadoService empleadoService){
        this.empleadoService = empleadoService;

    }
    @GetMapping
    public List<EmpleadoVO> getAll(){
    return empleadoService.getAll();
    }

    @GetMapping(value="/{id}")
    //@RequestMapping(value="/{id}", method = RequestMethod.GET)
    //@ResponseBody
    public EmpleadoVO getByID(@PathVariable Long id){
        return empleadoService.getByID(id);
    }

    @GetMapping("Nombre/{nombre}") //If these have the same structure as the idGetMapping, it will not work, because both mappings have the same endpoint for springboot
    public List<EmpleadoVO> getByNombre(@RequestBody String nombre){
        return empleadoService.getByNombre(nombre);
    }
    @GetMapping("Puesto/{puesto}")
    public List<EmpleadoVO> getByPuesto(@RequestBody String puesto){
        return empleadoService.getByPuesto(puesto);
    }

//    @GetMapping("/{tipo_jornada}")
//    public List<EmpleadoVO> getByTipo_jornada(@RequestBody String jornada){
//        return empleadoService.getByTipo_jornada(jornada);
//    }


    @PostMapping
    public EmpleadoVO create(@RequestBody EmpleadoVO empleado){
            return empleadoService.insert(empleado);
            // So the following code doesn't work, and it doesn't make sense. Since when doing a POST in Swagger,
            // with a database with serial IDs, we should not specify the id.
            /*
            if(getByID(empleado.getId_empleado()) == null){
            return empleadoService.insert(empleado);
        }else{
            System.err.println("The employee already exists!");
            return null;
        }
             */
    }

    @PutMapping("/put/{id}")
    public EmpleadoVO updateByID(@PathVariable Long id, EmpleadoVO newData){
        return empleadoService.updateByID(id, newData);
    }

    @PatchMapping("/patch/{id}")
    public EmpleadoVO patch(@PathVariable Long id, @RequestBody Map<String, Object> changes){
        return empleadoService.patch(id, changes);
    }

    @DeleteMapping("/delete/{id}") // This didn't work without changing the mapping to what it is now (it used to be: /{id})
    public void delete(@PathVariable Long id){
        empleadoService.delete(id);
    }



}
