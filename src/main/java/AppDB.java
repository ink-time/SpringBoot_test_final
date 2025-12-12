import com.connection.MyConnection;
import com.entities.EmpleadoDAO;
import com.entities.EmpleadoVO;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.Scanner;

import static com.entities.EmpleadoDAO.selectAllEmployees;


public class AppDB {
    public static void main(String[] args) {
    Connection conn = null;
    try {
        conn = MyConnection.getConnection();
        if(conn!=null) {
            Scanner scan = new Scanner (System.in);
            // All the stuff that happens if the com.connection is successful and if there are no errors
            System.out.println("Connected");

            EmpleadoVO employee1 = new EmpleadoVO("David", "Jefassso", "Jornada Completa", "david.guti@gmail.com", "679290198", "2025-11-21", 77.7, 1);
            EmpleadoDAO employeeManager = new EmpleadoDAO();
            selectAllEmployees(conn);
//            employeeManager.insertEmpleado(conn, employee1);
            System.out.println();
            selectAllEmployees(conn);
//            This is a comment for the new branch commit



        }else {
            System.out.println("Not connected properly!");
        }
        // method returned, if it was 1, it executed succesfully, if it was 0, then no
    } catch (Exception e) {
        e.printStackTrace();
    }
		finally {
        if(conn!=null){
            try {
                conn.close();
                System.out.print("The database com.connection has been closed.");
            } catch (SQLException e) {
                System.out.print("The database com.connection was not closed properly.");
//                throw new RuntimeException(e);
                e.printStackTrace();
                //The com.connection cannot be closed
            }
        }
    }
    }
}

// Hacer una rama que se llame Springboot
// Para que si tenemos errores, se queden en esa rama