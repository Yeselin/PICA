package com.touresbalon.mocks.hilton.actor;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;

import com.touresbalon.mocks.hilton.message.MessageRQ;

public class Reader {

	/**
	 * 
	 * @param inputStream
	 */
	public List<MessageRQ> read(InputStream inputStream) throws Exception {
		try {
			List<MessageRQ> listMessageRQ = new ArrayList<>();
			String line = null;
			try (BufferedReader bf = new BufferedReader(new InputStreamReader(inputStream))) {
				while (null != (line = bf.readLine())) {
					listMessageRQ.add(transform(line));
				}
			}
			return listMessageRQ;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	/**
	 * 
	 * @param line
	 * @return
	 */
	private MessageRQ transform(String line) {
		MessageRQ messageRQ = new MessageRQ();
		messageRQ.setIdentificationType(line.substring(0, 2));
		messageRQ.setIdentification(line.substring(2, 12));
		messageRQ.setFullName(line.substring(12, 62));
		messageRQ.setEmail(line.substring(62, 92));
		messageRQ.setPhone(line.substring(92, 106));
		messageRQ.setAddress(line.substring(106, 156));
		messageRQ.setCity(line.substring(156, 176));
		messageRQ.setLodgingCity(line.substring(176, 196));
		messageRQ.setCheckIn(line.substring(196, 206));
		messageRQ.setCheckout(line.substring(206, 216));
		messageRQ.setRooms(line.substring(216, 218));
		messageRQ.setGuests(line.substring(218, 220));
		return messageRQ;
	}

}
