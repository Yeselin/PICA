package com.touresbalon.mocks.eprmock;

import javax.jms.Queue;

import org.apache.activemq.ActiveMQConnectionFactory;
import org.apache.activemq.command.ActiveMQQueue;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.jms.core.JmsTemplate;

@Configuration
public class Config {
	
	@Value("${activemq.broker-url}")
	private String brokerURL;
	
	@Value("${activemq.queueName}")
	private String brokerQueue;
	
	@Bean
	public Queue queue() {
		return new ActiveMQQueue();
	}
	
	@Bean
	public ActiveMQConnectionFactory getConnectionFactoryMQ() {
		ActiveMQConnectionFactory factory = new ActiveMQConnectionFactory();
		factory.setBrokerURL(brokerURL); 
		return factory;
	}
	
	@Bean
	public JmsTemplate jmsTemplate() {
		return new JmsTemplate(getConnectionFactoryMQ());
	}
	
}
