package com.config;

import jakarta.annotation.PostConstruct;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.repository.config.EnableMongoRepositories;

import java.util.Arrays;
import java.util.List;


@Configuration
@EnableMongoRepositories(basePackages = "com.repositories.mongo")
public class MongoConfig {
    @Autowired
    private MongoTemplate template;

    @PostConstruct
  public void initialize(){
        System.out.println("Connecting to Mongo database: " + template.getDb().getName());
      try{
          List<String> collections = Arrays.asList(
                  "empleados",
                  "entradas",
                  "peliculas"
          );

          for(String collection: collections){
              if(!template.collectionExists(collection)){
                  template.createCollection(collection);
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
