package com.touresbalon.mocks.eprmock;

import javax.jms.JMSException;

import org.apache.activemq.command.ActiveMQTextMessage;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jms.annotation.JmsListener;
import org.springframework.stereotype.Component;

@Component
public class Receiver {

	private final Logger log = LoggerFactory.getLogger(Receiver.class);
	
	@JmsListener(destination = "${activemq.queueName}", containerFactory = "factory")
	public void receiveMessage(ActiveMQTextMessage message) {
		try {
			log.info(message.getText());
		} catch (JMSException e) {
			log.error("Error al recibir el mensaje", e);
		}
	}
}
