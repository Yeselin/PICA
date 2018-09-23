package com.touresbalon.mocks.bolivarianomock.actor;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.UUID;

import com.touresbalon.mocks.bolivarianomock.message.MessageRQ;
import com.touresbalon.mocks.bolivarianomock.message.MessageRS;

public class Writer {

	/**
	 * 
	 * @param listMessageRQ
	 * @return
	 */
	public InputStream write(List<MessageRQ> listMessageRQ) {
		DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd hh:mm");
		MessageRS messageRS = null;
		InputStream inputStream = null;
		StringBuffer buffer = new StringBuffer();
		
		for (MessageRQ rq : listMessageRQ) {
			messageRS = new MessageRS();
			messageRS.setTimestamp(dateTimeFormatter.format(LocalDateTime.now()));
			messageRS.setTransactionID(UUID.randomUUID().toString());
			messageRS.setTipoIdentificacion(rq.getTipoIdentifiacion());
			messageRS.setIdentificacion(rq.getIdentificacion());
			messageRS.setStatus("RESERVED");
			messageRS.setPrice(String.format("%d", (int)(Math.random() * 1000000)));
			messageRS.setReserveDate(rq.getFecha());
			messageRS.setCategory(rq.getCategoria());
			messageRS.setTotalTickets(rq.getTickets());
					
			buffer.append(messageRS.getTimestamp());
			buffer.append(messageRS.getTransactionID());
			buffer.append(messageRS.getTipoIdentificacion());
			buffer.append(messageRS.getIdentificacion());
			buffer.append(messageRS.getStatus());
			buffer.append(messageRS.getPrice());
			buffer.append(messageRS.getReserveDate());
			buffer.append(messageRS.getCategory());
			buffer.append(messageRS.getTotalTickets());
			buffer.append("\n");
			
		}
		
		inputStream = new ByteArrayInputStream(buffer.toString().getBytes());
		return inputStream;
	}
}
