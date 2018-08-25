package com.touresbalon.mocks.bolivarianomock.message;

import java.io.Serializable;

public class MessageRS implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String timestamp;
	private String transactionID;
	private String tipoIdentificacion;
	private String identificacion;
	private String status;
	private String price;
	private String reserveDate;
	private String category;
	private String totalTickets;
	
	public MessageRS() {
		super();
	}	
	
	public String getTimestamp() {
		return timestamp;
	}
	public void setTimestamp(String timestamp) {
		this.timestamp = timestamp;
	}
	public String getTransactionID() {
		return transactionID;
	}
	public void setTransactionID(String transactionID) {
		this.transactionID = transactionID;
	}
	public String getTipoIdentificacion() {
		return tipoIdentificacion;
	}
	public void setTipoIdentificacion(String tipoIdentificacion) {
		this.tipoIdentificacion = tipoIdentificacion;
	}
	public String getIdentificacion() {
		return identificacion;
	}
	public void setIdentificacion(String identificacion) {
		this.identificacion = identificacion;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public String getReserveDate() {
		return reserveDate;
	}
	public void setReserveDate(String reserveDate) {
		this.reserveDate = reserveDate;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getTotalTickets() {
		return totalTickets;
	}
	public void setTotalTickets(String totalTickets) {
		this.totalTickets = totalTickets;
	}	
	
}
