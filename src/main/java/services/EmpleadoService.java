package services;

import entities.EmpleadoVO;
import org.springframework.stereotype.Service;
import repositories.IEmpleadoRepository;

import java.util.List;
import java.util.Map;

@Service
public class EmpleadoService {
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

    public List<EmpleadoVO> getByName(String nombre){
        return empleadoRepository.findByNombre(nombre);
    }

    public List<EmpleadoVO> getByPuesto(String puesto){
        return empleadoRepository.findByPuesto(puesto);
    }

    public List<EmpleadoVO> getByTipo_jornada(String tipo_Jornada){
        return empleadoRepository.findByTipo_jornada(tipo_Jornada);
    }

    public EmpleadoVO getByID(long id){
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
            empleado.setNombre((String) changes.get("email"));
        }
        if(changes.containsKey("puesto")){
            empleado.setNombre((String) changes.get("puesto"));
        }
        if(changes.containsKey("telefono")){
            empleado.setNombre((String) changes.get("telefono"));
        }
        if(changes.containsKey("salario_hora")){
            empleado.setNombre((String) changes.get("salario_hora"));
        }
        if(changes.containsKey("activo")){
            empleado.setNombre((String) changes.get("nombre"));
        }
        if(changes.containsKey("tipo_jornada")){
            empleado.setNombre((String) changes.get("tipo_jornada"));
        }
        return empleadoRepository.save(empleado);

    }

    public void delete(Long id){
        empleadoRepository.deleteById(id);
    }

}
