package com.repositories.mongo;

import com.entities.EmpleadoVO;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface IEmpleadoRepositoryMongo extends MongoRepository<EmpleadoVO, String> {
    
}
