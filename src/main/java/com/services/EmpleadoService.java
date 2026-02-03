package com.services;

import com.entities.EmpleadoVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import com.repositories.jpa.IEmpleadoRepository;

import java.util.List;
import java.util.Map;

@Service
public class EmpleadoService {
    private static final Logger log = LoggerFactory.getLogger(EmpleadoService.class);
    private final IEmpleadoRepository empleadoRepository;
    // Here we have the logic, so the way we want the methods to work.
    // We can also have all the conditions that we use to make the methods more solid, and harder to brak in production.
    // We have to create controls or validations that check if the user that is asking for the information is in a certain
    // privilege group

    public EmpleadoService (IEmpleadoRepository empleadoRepository){
        this.empleadoRepository = empleadoRepository;
    }
    public List<EmpleadoVO> getAll(){
        return empleadoRepository.findAll();
    }

    public List<EmpleadoVO> getByNombre(String nombre){
        return empleadoRepository.findByNombre(nombre);
    }

    public List<EmpleadoVO> getByPuesto(String puesto){
        return empleadoRepository.findByPuesto(puesto);
    }

//    public List<EmpleadoVO> getByTipo_jornada(String tipo_Jornada){
//        return empleadoRepository.findByTipo_jornada(tipo_Jornada);
//    }

    public EmpleadoVO getByID(Long id){
            return empleadoRepository.findById(id).orElseThrow(() -> new RuntimeException("Usuario no encontrado"));



    }
    // Creating employee
    public EmpleadoVO insert(EmpleadoVO empleado){
            return empleadoRepository.save(empleado);
    }

    // Total update (PUT)
    public EmpleadoVO updateByID(Long id, EmpleadoVO datosNuevos){
        EmpleadoVO empleado = getByID(id);
        empleado.setNombre(datosNuevos.getNombre());
        empleado.setEmail(datosNuevos.getEmail());
        empleado.setPuesto(datosNuevos.getPuesto());
        empleado.setTelefono(datosNuevos.getTelefono());
        empleado.setSalario_hora(datosNuevos.getSalario_hora());
        empleado.setFecha_contratacion(datosNuevos.getFecha_contratacion());
        empleado.setActivo(datosNuevos.getActivo());
        empleado.setTipo_jornada(datosNuevos.getTipo_jornada());
        return empleadoRepository.save(empleado);
    }

    // Partial update (PATCH)
    public EmpleadoVO patch(Long id, Map<String, Object> changes){
        EmpleadoVO empleado = getByID(id);
        if(changes.containsKey("nombre")){
            empleado.setNombre((String) changes.get("nombre"));

        }
        if(changes.containsKey("email")){
            empleado.setEmail((String) changes.get("email"));
        }
        if(changes.containsKey("puesto")){
            empleado.setPuesto((String) changes.get("puesto"));
        }
        if(changes.containsKey("telefono")){
            empleado.setTelefono((String) changes.get("telefono"));
        }
        if(changes.containsKey("fecha_contratacion")){
            empleado.setFecha_contratacion((String) changes.get("fecha_contratacion"));
        }
        if(changes.containsKey("salario_hora")){
            empleado.setSalario_hora((double) changes.get("salario_hora"));
        }
        if(changes.containsKey("activo")){
            empleado.setActivo((int) changes.get("nombre"));
        }
        if(changes.containsKey("tipo_jornada")){
            empleado.setTipo_jornada((String) changes.get("tipo_jornada"));
        }

        return empleadoRepository.save(empleado);

    }

    public void delete(Long id){
        empleadoRepository.deleteById(id);
    }

}
