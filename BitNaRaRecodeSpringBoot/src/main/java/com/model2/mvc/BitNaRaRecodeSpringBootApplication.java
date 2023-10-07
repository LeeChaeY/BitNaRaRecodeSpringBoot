package com.model2.mvc;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@ComponentScan(basePackages = "com.model2.mvc")
public class BitNaRaRecodeSpringBootApplication {

	public static void main(String[] args) {
		SpringApplication.run(BitNaRaRecodeSpringBootApplication.class, args);
	}

}
