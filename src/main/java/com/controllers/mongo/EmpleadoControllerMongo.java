package com.controllers.mongo;

import com.entities.EmpleadoVO;
import com.repositories.mongo.IEmpleadoRepositoryMongo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class EmpleadoControllerMongo {

        @Autowired
        private IEmpleadoRepositoryMongo empleadoRepo;

        @PostMapping("/addEmployee")
        public EmpleadoVO addEmpleado(@RequestBody EmpleadoVO empleado) {
            return empleadoRepo.save(empleado);
        }

        @GetMapping("/getAllEmployees")
        public List<EmpleadoVO> getAllEmpleados(){
            return empleadoRepo.findAll();
        }
}
