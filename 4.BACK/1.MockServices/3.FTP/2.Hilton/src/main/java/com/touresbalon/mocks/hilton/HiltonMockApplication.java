package com.touresbalon.mocks.hilton;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@EnableScheduling
public class HiltonMockApplication {

	public static void main(String[] args) {
		SpringApplication.run(HiltonMockApplication.class, args);
	}
}
