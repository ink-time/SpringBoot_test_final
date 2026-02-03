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
    private org.springframework.core.env.Environment env;

    @PostConstruct //This executes automatically when starting the app
  public void initialize(){
        System.out.println("Connecting to Mongo database: " + mongoTemplate.getDb().getName());
        System.out.println("Property URI: " + env.getProperty("spring.data.mongodb.uri"));
        System.out.println("Property Database: " + env.getProperty("spring.data.mongodb.database"));
        try{
          List<String> collections = Arrays.asList(
                  "empleados",
                  "entradas",
                  "peliculas"
          );

          for(String collection: collections){
              if(!mongoTemplate.collectionExists(collection)){
                  mongoTemplate.createCollection(collection);
                  System.out.println("Collection created succcesfully");

              }else{
                  System.out.println("Collection: "+ collection +" already existed");
              }
          }
      }catch (Exception e){
        System.err.println("Critical error while starting the database: "+ e.getMessage());
      }
  }

}
