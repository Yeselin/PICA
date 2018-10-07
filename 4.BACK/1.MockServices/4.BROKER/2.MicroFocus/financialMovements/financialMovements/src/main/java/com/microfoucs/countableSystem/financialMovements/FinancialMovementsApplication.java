package com.microfoucs.countableSystem.financialMovements;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@ComponentScan(basePackages="com.microfoucs.countableSystem.financialMovements.consumer.listener")
@SpringBootApplication
public class FinancialMovementsApplication {

	public static void main(String[] args) {
		SpringApplication.run(FinancialMovementsApplication.class, args);
	}
}



