package com.healthyfighter.config;

import org.springframework.stereotype.Component;
import org.springframework.web.context.annotation.SessionScope;

import com.healthyfighter.entities.User;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@SessionScope
@Component
@Data
@NoArgsConstructor
@AllArgsConstructor
public class AuthenticatedUser {
	private User user;
}
