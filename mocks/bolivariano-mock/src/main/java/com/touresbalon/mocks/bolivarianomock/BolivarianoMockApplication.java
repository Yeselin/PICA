package com.touresbalon.mocks.bolivarianomock;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@EnableScheduling
public class BolivarianoMockApplication {

	public static void main(String[] args) {
		SpringApplication.run(BolivarianoMockApplication.class, args);
	}
}
