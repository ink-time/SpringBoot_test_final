package repositories;

import entities.empleados.EmpleadoVO;
import org.springframework.data.repository.Repository;

import java.util.ArrayList;
import java.util.List;

public interface IEmpleadoRepository extends Repository<EmpleadoVO, Long> {
List<EmpleadoVO> findAll();
EmpleadoVO findById(long id);

List<EmpleadoVO> findByNombre(String nombre);

EmpleadoVO insertEmpleado(EmpleadoVO empleado);

EmpleadoVO save(EmpleadoVO empleado);



}
