package com.healthyfighter;

import com.healthyfighter.entities.User;
import com.healthyfighter.repositories.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.context.event.EventListener;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spring.web.plugins.Docket;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

@EnableSwagger2
@SpringBootApplication
public class HealthyFighterApiApplication {

	@Autowired
	private UserRepository userRepository;

	public static void main(String[] args) {
		SpringApplication.run(HealthyFighterApiApplication.class, args);
	}

	@Bean
	public Docket productApi() {
		return new Docket(DocumentationType.SWAGGER_2).select()
				.apis(RequestHandlerSelectors.basePackage("com.healthyfighter")).build();
	}

	@EventListener
	public void seed(ContextRefreshedEvent event) {
		for (User user : userRepository.findAll()) {
			// encrypted password length is 60, 50 is chosen randomly
			if (user.getPassword().length() < 50) {
				user.setPassword(new BCryptPasswordEncoder().encode(user.getPassword()));
				userRepository.save(user);
			}

		}
	}

}