package services;

import entities.empleados.EmpleadoVO;

import java.util.List;

public interface IEmpleadoService {
// Here we have the logic, so the way we want the methods to work.
// We can also have all the conditions that we use to make the methods more solid, and harder to brak in production.
    public boolean objectExists(long id);
    public List<EmpleadoVO> getAll();
    public int insert();
    public int update();
    public int updateComplex();
    public int delete();

}
