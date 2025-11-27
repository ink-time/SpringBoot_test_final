package vo;

import java.time.LocalDate;

public class EmpleadoVO {
    private String nombre;
    private String puesto;
    private String tipo_jornada;

    private String email;

    private String telefono;
    private LocalDate fecha_contratacion;

    private double salario_hora;

    private int activo;

    public EmpleadoVO(String nombre, String puesto, String tipo_jornada, String email, String telefono, String fecha_contratacion, double salario_hora, int activo) {
        this.nombre = nombre;
        this.puesto = puesto;
        this.tipo_jornada = tipo_jornada;
        this.email = email;
        this.telefono = telefono;
        this.fecha_contratacion = LocalDate.parse(fecha_contratacion);
        this.salario_hora = salario_hora;
        this.activo = activo;
    }

    public EmpleadoVO() {
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getPuesto() {
        return puesto;
    }

    public void setPuesto(String puesto) {
        this.puesto = puesto;
    }

    public String getTipo_jornada() {
        return tipo_jornada;
    }

    public void setTipo_jornada(String tipo_jornada) {
        this.tipo_jornada = tipo_jornada;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getFecha_contratacion() {
        return fecha_contratacion.toString();
    }

    public void setFecha_contratacion(String fecha_contratacion) {
        this.fecha_contratacion = LocalDate.parse(fecha_contratacion);
    }

    public double getSalario_hora() {
        return salario_hora;
    }

    public void setSalario_hora(double salario_hora) {
        this.salario_hora = salario_hora;
    }

    public int getActivo() {
        return activo;
    }

    public void setActivo(int activo) {
        this.activo = activo;
    }

    @Override
    public String toString() {
        return "EmpleadoVO{" +
                "nombre='" + nombre + '\'' +
                ", puesto='" + puesto + '\'' +
                ", tipo_jornada='" + tipo_jornada + '\'' +
                ", email='" + email + '\'' +
                ", telefono='" + telefono + '\'' +
                ", fecha_contratacion=" + fecha_contratacion +
                ", salario_hora=" + salario_hora +
                ", activo=" + activo +
                '}';
    }
}
