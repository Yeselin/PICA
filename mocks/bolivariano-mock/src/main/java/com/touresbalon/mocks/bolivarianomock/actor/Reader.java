package com.touresbalon.mocks.bolivarianomock.actor;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;

import com.touresbalon.mocks.bolivarianomock.message.MessageRQ;

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
		messageRQ.setTipoIdentifiacion(line.substring(0, 2));
		messageRQ.setIdentificacion(line.substring(2, 12));
		messageRQ.setNombreCompleto(line.substring(12, 62));
		messageRQ.setEmail(line.substring(62, 92));
		messageRQ.setCelular(line.substring(92, 106));
		messageRQ.setCiudadOrigen(line.substring(106, 126));
		messageRQ.setCiudadDestino(line.substring(126, 146));
		messageRQ.setFecha(line.substring(146, 156));
		messageRQ.setTickets(line.substring(156, 158));
		messageRQ.setCategoria(line.substring(158, 159));
		return messageRQ;
	}

}
