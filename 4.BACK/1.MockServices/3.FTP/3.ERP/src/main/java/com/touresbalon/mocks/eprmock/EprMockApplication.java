package com.touresbalon.mocks.eprmock;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.jms.annotation.EnableJms;

@SpringBootApplication
@EnableJms
public class EprMockApplication {

	public static void main(String[] args) {
		SpringApplication.run(EprMockApplication.class, args);
	}
}
