package dao;

import vo.EmpleadoVO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;

public class EmpleadoDAO {
    Scanner sc = new Scanner(System.in);

    public static boolean existsEmpleado(Connection conn, long id) {
        String query = "SELECT nombre, puesto, tipo_jornada, email, telefono, " +
                "fecha_contratacion, salario_hora, activo FROM Empleados WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setLong(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next(); // So if there is at least one instance we get a true from this.
            } catch (SQLException e) {
                e.printStackTrace();
                return false;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }

    }

    public static void selectAllEmployees(Connection conn) {
        String query = "SELECT nombre, puesto, tipo_jornada, email, telefono, " +
                "fecha_contratacion, salario_hora, activo FROM Empleados";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    String nombre = rs.getString("nombre");
                    String puesto = rs.getString("puesto");
                    String tipo_jornada = rs.getString("tipo_jornada");
                    String email = rs.getString("email");
                    String telefono = rs.getString("telefono");
                    String fecha_contratacion = rs.getString("fecha_contratacion");
                    double salario_hora = rs.getDouble("salario_hora");
                    int activo = rs.getInt("activo");
                    System.out.println("[" + " |Nombre: " + nombre + " | Puesto: " + puesto + " | tipo_jornada: " + tipo_jornada
                            + " | email: " + email + " | telefono: " + telefono + " | fecha_contratacion: " + fecha_contratacion +
                            " | salario_hora: " + salario_hora + " | activo: " + activo + " ]");
                }

            } catch (SQLException e) {
                e.printStackTrace();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


public void createTable(String tableName, int colNum) {
        Scanner sc = new Scanner(System.in);
    Map<String, String> columnNames_Types = new HashMap<>();
//    ArrayList <String> columnTypes = new ArrayList<>();
    String columnName = "";
    String columnType = "";
    long lenght = 0;
    for (int i = 0; i < colNum; i++) {
        System.out.print("Name of the column: ");
        columnName = sc.nextLine().trim();
        System.out.print("Value type: ");
        columnName = sc.nextLine().toUpperCase().trim();
        String query = "CREATE TABLE " + tableName + "(\n";
        switch (columnType){
            case "INT", "BIGINT" -> {
                columnNames_Types.put(columnName, columnType);
                System.out.print("Length: ");
                lenght = sc.nextInt();
                query = query + columnNames_Types.get("INT") + " INT (" + lenght + ")"; // I LEFT IT HERE
            }
            case  "VARCHAR" -> {

            }
            case "CHAR" -> {
                lenght = 1;
            }
            case "ENUM" -> { // Hmmm, problematiic I think

            }
            case "BOOLEAN" -> {
                columnNames_Types.put(columnName, columnType);
            }
            case "DOUBLE", "DECIMAL"  -> {
                columnNames_Types.put(columnName, columnType);
                System.out.print("Length: ");
                double decimalLenght = sc.nextDouble();
            }
            case "DATE" -> {

            }
            case "DATETIME" -> {

            }
            case "TIMESTAMP" -> {

            }
            case "TIME" -> {

            }
            default -> {
                System.out.println("Not admitted type!!");
            }

        };


    }

}

public int insertEmpleado(Connection conn, EmpleadoVO newEmpleado){
        String query = "INSERT INTO Empleados (nombre, puesto, tipo_jornada, email, telefono," +
                " fecha_contratacion, salario_hora, activo) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(query)){

            stmt.setString(1, newEmpleado.getNombre());
            stmt.setString(2, newEmpleado.getPuesto());
            stmt.setString(3, newEmpleado.getTipo_jornada());
            stmt.setString(4, newEmpleado.getEmail());
            stmt.setString(5, newEmpleado.getTelefono());
            stmt.setString(6, newEmpleado.getFecha_contratacion());
            stmt.setDouble(7, newEmpleado.getSalario_hora());
            stmt.setInt(8, newEmpleado.getActivo());

            return stmt.executeUpdate();
            // We can return the data that has been inserted correctly, as a String. Or even a boolean to represent that the action was realised successfully.
        } catch (SQLException e) {
            e.printStackTrace();
            return 0;
//            throw new RuntimeException(e);
        }

}

public int updateEmpleadoWIP(Connection conn, EmpleadoVO newEmpleado, String fieldsToUpdate, String condition){
//    System.out.print("Choose the condition, or the columns where the update statement will take place: ");
//    String condition = sc.nextLine();
//    System.out.print("Type the columns that you want to update, separated by a ',': ");
//    String columnsToUpdate = sc.nextLine();
    String query = "UPDATE Empleados SET name = ?, puesto = ?, tipo_jornada = ?, email = ?, telefono = ?," +
            " fecha_contratacion = ?, salario_hora = ?, activo = ?) WHERE ?";
    try (PreparedStatement stmt = conn.prepareStatement(query)){

        // We do a switch here, having into account the fieldsToUpdate variable.
        stmt.setString(1, newEmpleado.getNombre());
        stmt.setString(2, newEmpleado.getPuesto());
        stmt.setString(3, newEmpleado.getTipo_jornada());
        stmt.setString(4, newEmpleado.getEmail());
        stmt.setString(5, newEmpleado.getTelefono());
        stmt.setString(6, newEmpleado.getFecha_contratacion());
        stmt.setDouble(7, newEmpleado.getSalario_hora());
        stmt.setInt(8, newEmpleado.getActivo());
        stmt.setString(9, condition);

        return stmt.executeUpdate();
        // We can return the data that has been inserted correctly, as a String. Or even a boolean to represent that the action was realised successfully.
    } catch (SQLException e) {
        e.printStackTrace();
        return 0;
//            throw new RuntimeException(e);
    }
}

    public int updateEmpleadoSimple(Connection conn, long id, String newEmail){
        String query = "UPDATE Empleados SET  email = ?, WHERE  id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)){

            stmt.setString(1, newEmail);
            stmt.setLong(2, id);


            return stmt.executeUpdate();
            // We can return the data that has been inserted correctly, as a String. Or even a boolean to represent that the action was realised successfully.
        } catch (SQLException e) {
            e.printStackTrace();
            return 0;
//            throw new RuntimeException(e);
        }
    }


public int deleteEmpleado(Connection conn, long id){
    String query = "DELETE FROM empleados WHERE id = ?";
    try (PreparedStatement stmt = conn.prepareStatement(query)){
        if(existsEmpleado(conn, id)){
            stmt.setLong(1, id);
            System.out.println("Empleado eliminado con éxito!");
            return stmt.executeUpdate();
        } else {
            System.out.println("Error. Empleado a eliminar no encontrado!");
            return 0;
        }
        // We can return the data that has been inserted correctly, as a String. Or even a boolean to represent that the action was realised successfully.
    } catch (SQLException e) {
        e.printStackTrace();
        return -1;
//            throw new RuntimeException(e);
    }
}

}
