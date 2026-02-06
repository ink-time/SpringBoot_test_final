package com.config;

import jakarta.annotation.PostConstruct;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.repository.config.EnableMongoRepositories;

import java.util.Arrays;
import java.util.List;


@Configuration
@EnableMongoRepositories(basePackages = "com.repositories.mongo") // This is to specify where the repositories Mongo has to search for will be. So it doesn't confuse them with the mySQL ones
public class MongoConfig {
    @Autowired
    private MongoTemplate mongoTemplate;
    @Autowired
    private org.springframework.core.env.Environment env; // This is to check if the properties for mongo where being read properly. Since I had problems with them.

    @PostConstruct //This executes automatically when starting the app
  public void initialize(){
        System.out.println("Connecting to Mongo database: " + mongoTemplate.getDb().getName());
        System.out.println("Property URI: " + env.getProperty("spring.data.mongodb.uri"));
        System.out.println("Property Database: " + env.getProperty("spring.data.mongodb.database"));
        try{
            // A list with all the tables that we have in the relational database.
            // This works, but I would like to go check all the tables that exist in the mySQL database with code, and get those names into a List automatically.
            // That way this works even if we create new tables in the mySQL table for any reason.
          List<String> collections = Arrays.asList(
                  "empleados",
                  "entradas",
                  "horarios_semanales_empleados",
                  "registro_horas_mensual",
                  "peliculas",
                  "proyecciones",
                  "salas"


          );

          for(String collection: collections){
              // We actually create the collections here, but only if they are not already there.
              if(!mongoTemplate.collectionExists(collection)){
                  mongoTemplate.createCollection(collection);
                  // Logging
                  System.out.println("Collection created succcesfully");

              }else{
                  // More logging
                  System.out.println("Collection: "+ collection +" already existed");
              }
          }
      }catch (Exception e){
        System.err.println("Critical error while starting the database: "+ e.getMessage());
      }
  }

    public MongoTemplate getMongoTemplate() {
        return mongoTemplate;
    }

    public void setMongoTemplate(MongoTemplate mongoTemplate) {
        this.mongoTemplate = mongoTemplate;
    }
}
