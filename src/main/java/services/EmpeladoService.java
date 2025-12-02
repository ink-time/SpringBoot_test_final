package services;

import entities.empleados.EmpleadoVO;
import repositories.IEmpleadoRepository;

import java.util.List;

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

    public EmpleadoVO getByID(long id){
        try{
            return empleadoRepository.findById(id);
        } catch (RuntimeException e){
            System.err.println("Employee with id= " + id +" not found");
            return null;

        }

    }
    public EmpleadoVO insert(){
        return null;
    }
    public EmpleadoVO update(){
        return null;
    }
    public EmpleadoVO updateComplex(){
        return null;
    }
    public int delete(){
        return 0;
    }

}
