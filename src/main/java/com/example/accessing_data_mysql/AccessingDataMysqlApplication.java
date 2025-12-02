package com.example.accessing_data_mysql;

import connection.MyConnection;
import entities.empleados.EmpleadoDAO;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import entities.empleados.EmpleadoVO;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.Scanner;

import static entities.empleados.EmpleadoDAO.selectAllEmployees;

@SpringBootApplication
public class AccessingDataMysqlApplication {

	public static void main(String[] args) {
		SpringApplication.run(AccessingDataMysqlApplication.class, args);

	}

}
