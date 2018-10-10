package com.touresbalon.mocks.hilton.actor;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.UUID;

import com.touresbalon.mocks.hilton.message.MessageRQ;
import com.touresbalon.mocks.hilton.message.MessageRS;

public class Writer {

	/**
	 * 
	 * @param listMessageRQ
	 * @return
	 */
	public InputStream write(List<MessageRQ> listMessageRQ) {
		DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd hh:mm:ss");
		MessageRS messageRS = null;
		InputStream inputStream = null;
		StringBuffer buffer = new StringBuffer();
		
		for (MessageRQ rq : listMessageRQ) {
			messageRS = new MessageRS();
			
			messageRS.setTimestamp(dateTimeFormatter.format(LocalDateTime.now()));
			messageRS.setTransactionID(UUID.randomUUID().toString());
			messageRS.setIdentificationType(rq.getIdentificationType());
			messageRS.setIdentification(rq.getIdentification());
			messageRS.setLogdingCity(rq.getLodgingCity());
			messageRS.setCheckIn(rq.getCheckIn());
			messageRS.setCheckOut(rq.getCheckout());
			messageRS.setRooms(rq.getRooms());
			messageRS.setGuest(rq.getGuests());
			messageRS.setPrice(String.format("%d", (int)(Math.random() * 1000000)));
			messageRS.setCurrency("COP");			
			messageRS.setStatus("RES");	
					
			buffer.append(messageRS.getTimestamp());
			buffer.append(messageRS.getTransactionID());
			buffer.append(messageRS.getIdentificationType());
			buffer.append(messageRS.getIdentification());
			buffer.append(messageRS.getLogdingCity());
			buffer.append(messageRS.getCheckIn());
			buffer.append(messageRS.getCheckOut());
			buffer.append(messageRS.getRooms());
			buffer.append(messageRS.getGuest());
			buffer.append(messageRS.getPrice());
			buffer.append(messageRS.getCurrency());
			buffer.append(messageRS.getStatus());
			
			buffer.append("\n");			
		}
		
		inputStream = new ByteArrayInputStream(buffer.toString().getBytes());
		return inputStream;
	}
}
