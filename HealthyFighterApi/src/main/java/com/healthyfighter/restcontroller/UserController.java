package com.healthyfighter.restcontroller;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.google.common.collect.Iterables;
import com.healthyfighter.entities.User;
import com.healthyfighter.repositories.UserRepository;

@CrossOrigin
@RestController
@RequestMapping("/api/users")
public class UserController {

	@Autowired
	private UserRepository userRepository;

	@GetMapping("/users")
	public ResponseEntity<Iterable<User>> getAll() {
		return ResponseEntity.ok(userRepository.findAll());
	}

	@GetMapping("/user/{username}")
	public ResponseEntity<User> get(@PathVariable String username) {
		Optional<User> oUser = Optional.ofNullable(userRepository.findByUsername(username));
		if (oUser.isPresent()) {
			return ResponseEntity.ok(oUser.get());
		} else {
			throw new UsernameNotFoundException("User not found with username: " + username);
		}
	}

	@GetMapping("/statistics")
	public ResponseEntity<Map<String, Integer>> getStatistics() {
		Map<String, Integer> result = new HashMap<String, Integer>() {
			private static final long serialVersionUID = 1L;
			{
				put("ADMIN_USERS", Iterables.size(userRepository.findAll()));
			}
		};
		return ResponseEntity.ok(result);
	}
}
