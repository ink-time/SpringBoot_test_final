package com.connection;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoDatabase;

import java.util.ArrayList;

public class ConnectionMongoDB {
    private static final String MONGO_URL = "mongodb://localhost:27017";
    private static final String DB_NAME = "cinesdb";
    public static MongoDatabase getConnectionMongo() {
        try{
            MongoClient client = MongoClients.create(MONGO_URL);
            return client.getDatabase(DB_NAME);
        } catch (Exception e) {
            throw new RuntimeException("Error conectando a MongoDB", e);
        }
    }



    public static boolean collectionExistance(String collName){
        MongoDatabase db = getConnectionMongo();
        ArrayList<String> collNameList = new ArrayList<>();
        collNameList = db.listCollectionNames().into(collNameList);
        System.out.println(collNameList);
        return collNameList.contains(collName);
//        System.out.println("Collection Name " + collName + " " + db.listCollectionNames().into(new ArrayList<>()).contains(collName));
    }
}
