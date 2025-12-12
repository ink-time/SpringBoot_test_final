package com.entities;

import jakarta.persistence.*;

import java.io.Serializable;
import java.time.LocalDate;

@Entity
@Table(name= "empleados")
public class EmpleadoVO {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id_empleado;

    @Column(name = "nombre", nullable = false)
    private String nombre;

    @Column(name = "puesto", nullable = false)
    private String puesto;

    @Column(name = "tipo_jornada", nullable = false)
    private String tipo_jornada;

    @Column(name = "email", nullable = false)
    private String email;

    @Column(name = "telefono", nullable = false)
    private String telefono;

    @Column(name = "fecha_contratacion", nullable = false)
    private LocalDate fecha_contratacion;

    @Column(name = "salario_hora", nullable = false)
    private double salario_hora;

    @Column(name = "activo", nullable = false)
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
    public EmpleadoVO(Long id_empleado, String nombre, String puesto, String tipo_jornada, String email, String telefono, String fecha_contratacion, double salario_hora, int activo) {
        this.id_empleado = id_empleado;
        this.nombre = nombre;
        this.puesto = puesto;
        this.tipo_jornada = tipo_jornada;
        this.email = email;
        this.telefono = telefono;
        this.fecha_contratacion = LocalDate.parse(fecha_contratacion);
        this.salario_hora = salario_hora;
        this.activo = activo;
    }

    protected EmpleadoVO() {
    }

    public Long getId_empleado() {
        return id_empleado;
    }

    public void setId_empleado(Long id_empleado) {
        this.id_empleado = id_empleado;
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
                "id_empleado=" + id_empleado +
                ", nombre='" + nombre + '\'' +
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
