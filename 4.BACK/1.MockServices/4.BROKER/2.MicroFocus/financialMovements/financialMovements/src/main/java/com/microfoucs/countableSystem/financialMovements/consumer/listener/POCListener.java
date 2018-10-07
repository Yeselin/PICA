package com.microfoucs.countableSystem.financialMovements.consumer.listener;

import javax.jms.JMSException;
import javax.jms.Message;
import javax.jms.TextMessage;

import org.springframework.jms.annotation.JmsListener;
import org.springframework.stereotype.Component;

@Component
public class POCListener {
	@JmsListener(destination="jms/financialMovements/queue")
	public void onMessage( final Message message ) throws JMSException {
		
		System.out.println( "A financial movemente has been received!" );
		TextMessage tm = (TextMessage) message;
		System.out.println( tm.getText() );
	}	
}
