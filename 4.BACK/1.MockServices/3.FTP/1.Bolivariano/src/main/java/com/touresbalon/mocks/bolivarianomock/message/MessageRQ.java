package com.touresbalon.mocks.bolivarianomock.message;

import java.io.Serializable;

public class MessageRQ implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String tipoIdentifiacion;
	private String identificacion;
	private String nombreCompleto;
	private String email;
	private String celular;
	private String ciudadOrigen;
	private String ciudadDestino;
	private String fecha;
	private String tickets;
	private String categoria;
	
	
	public String getTipoIdentifiacion() {
		return tipoIdentifiacion;
	}
	public void setTipoIdentifiacion(String tipoIdentifiacion) {
		this.tipoIdentifiacion = tipoIdentifiacion;
	}
	public String getIdentificacion() {
		return identificacion;
	}
	public void setIdentificacion(String identificacion) {
		this.identificacion = identificacion;
	}
	public String getNombreCompleto() {
		return nombreCompleto;
	}
	public void setNombreCompleto(String nombreCompleto) {
		this.nombreCompleto = nombreCompleto;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getCelular() {
		return celular;
	}
	public void setCelular(String celular) {
		this.celular = celular;
	}
	public String getCiudadOrigen() {
		return ciudadOrigen;
	}
	public void setCiudadOrigen(String ciudadOrigen) {
		this.ciudadOrigen = ciudadOrigen;
	}
	public String getCiudadDestino() {
		return ciudadDestino;
	}
	public void setCiudadDestino(String ciudadDestino) {
		this.ciudadDestino = ciudadDestino;
	}
	public String getFecha() {
		return fecha;
	}
	public void setFecha(String fecha) {
		this.fecha = fecha;
	}
	public String getTickets() {
		return tickets;
	}
	public void setTickets(String tickets) {
		this.tickets = tickets;
	}
	public String getCategoria() {
		return categoria;
	}
	public void setCategoria(String categoria) {
		this.categoria = categoria;
	}
	
	

}
