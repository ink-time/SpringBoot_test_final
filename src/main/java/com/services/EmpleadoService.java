package com.services;

import com.config.MongoConfig;
import com.entities.EmpleadoVO;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.model.Filters;
import org.bson.Document;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.stereotype.Service;
import com.repositories.jpa.IEmpleadoRepository;


import java.util.List;
import java.util.Map;

//import static com.connection.ConnectionMongoDB.DB_NAME;
// The IDE suggested importing this Constant, but it is private,
// I can change it to public, but it doesn't seem necessary

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
        // We isnert the employee in the MongoDB database as well. But only if it doesn't exist already.
        if (!findByName(empleado.getNombre())) {
            Document doc = new Document("nombre", empleado.getNombre())
                    .append("puesto", empleado.getPuesto())
                    .append("tipo_jornada", empleado.getTipo_jornada())
                    .append("email", empleado.getEmail())
                    .append("telefono", empleado.getTelefono())
                    .append("fecha_contratacion", empleado.getFecha_contratacion())
                    .append("salario_hora", empleado.getSalario_hora())
                    .append("activo", empleado.getActivo());

            getCollection().insertOne(doc);

            System.out.println("Alumno  en mongoDB: " + empleado.getNombre());
//            listEmpleados();
        }
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
    @Autowired
    static MongoTemplate template;
    // Mongo Static methods, to use only on the logic related to MongoDB in the methods above
    private static MongoCollection<Document> getCollection() {
        try{
            MongoConfig mongoConf= new MongoConfig();
            MongoTemplate database = template;
            System.out.println();
            return database.getDb().getCollection("empleados");
        } catch (Exception e) {
            throw new RuntimeException("Error conectando a MongoDB", e);
        }

    }
    public static boolean findByName(String nombre) {
        Document empleado = getCollection()
                .find(Filters.eq("nombre", nombre))
                .first();

        if (empleado != null) {
            System.out.println("El empleado ya existe: " + nombre);
            return true;
        }

        System.out.println("No existe el empleado: " + nombre);
        return false;
    }
    public void listEmpleados() {
        MongoCursor<Document> cursor = getCollection().find().iterator();

        System.out.println("Listado de empleados:");
        while (cursor.hasNext()) {
            Document doc = cursor.next();
            System.out.println(
                    doc.getString("nombre") + " " +
                            doc.getString("nombre") + " " +
                            doc.getString("puesto") + " " +
                            doc.getString("tipo_jornada") + " " +
                            doc.getString("email") + " " +
                            doc.getString("telefono") + " " +
                            doc.getString("fecha_contratacion") + " " +
                            doc.getDouble("salario_hora") + " " +
                            doc.getInteger("activo") + " "
            );
        }
    }
}
