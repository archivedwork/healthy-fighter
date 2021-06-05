package com.healthyfighter.restcontroller;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.google.common.collect.Iterables;
import com.healthyfighter.config.AuthenticatedUser;
import com.healthyfighter.entities.Product;
import com.healthyfighter.entities.Product.ProductType;
import com.healthyfighter.repositories.ProductRepository;
import com.healthyfighter.repositories.UserRepository;

@CrossOrigin
@RestController
@RequestMapping("/api/products")
public class ProductController {

	@Autowired
	private UserRepository userRepository;

	@Autowired
	private ProductRepository productRepository;

	@Autowired
	private AuthenticatedUser authenticatedUser;

	@GetMapping("/simpleuser")
	public ResponseEntity<Iterable<Product>> getAll() {
		return ResponseEntity.ok(productRepository.findAll());
	}

	@GetMapping("/simpleuser/{id}")
	public ResponseEntity<Product> get(@PathVariable Integer id) {
		Optional<Product> oProduct = productRepository.findById(id);
		if (oProduct.isPresent()) {
			return ResponseEntity.ok(oProduct.get());
		} else {
			return ResponseEntity.notFound().build();
		}
	}

	@GetMapping("/simpleuser/producttype/{productTypeString}")
	public ResponseEntity<Iterable<Product>> getByProductType(@PathVariable String productTypeString) {
		try {
			return ResponseEntity
					.ok(productRepository.findAllByProductType(ProductType.valueOf(productTypeString.toUpperCase())));
		} catch (IllegalArgumentException ex) {
			return ResponseEntity.notFound().build();
		}
	}

	@PostMapping("/simpleuser/suggest")
	public ResponseEntity<Product> suggestion(@RequestBody Product newProduct) {
		newProduct.setAddedBy(userRepository.findById(0).get());
		newProduct.setIsValidated(null);
		Product savedProduct = productRepository.save(newProduct);
		return ResponseEntity.ok(savedProduct);
	}

	@PostMapping("")
	public ResponseEntity<Product> create(@RequestBody Product newProduct) {
		newProduct.setAddedBy(authenticatedUser.getUser());
		if (newProduct.getIsValidated() != null)
			newProduct.setValidityChangedBy(authenticatedUser.getUser());
		Product savedProduct = productRepository.save(newProduct);
		return ResponseEntity.ok(savedProduct);
	}

	@PutMapping("/{id}")
	public ResponseEntity<Product> update(@PathVariable Integer id, @RequestBody Product updatedProduct) {
		Optional<Product> oProduct = productRepository.findById(id);
		if (oProduct.isPresent()) {
			Product exisProduct = oProduct.get();
			if (exisProduct.getIsValidated() != updatedProduct.getIsValidated())
				updatedProduct.setValidityChangedBy(authenticatedUser.getUser());
			else
				updatedProduct.setValidityChangedBy(exisProduct.getValidityChangedBy());
			updatedProduct.setAddedBy(exisProduct.getAddedBy());
			updatedProduct.setId(id);
			return ResponseEntity.ok(productRepository.save(updatedProduct));
		} else {
			return ResponseEntity.notFound().build();
		}
	}

	@DeleteMapping("/{id}")
	public ResponseEntity<Product> delete(@PathVariable Integer id) {
		Optional<Product> oProduct = productRepository.findById(id);
		if (oProduct.isPresent()) {
			productRepository.deleteById(id);
			return ResponseEntity.ok().build();
		} else {
			return ResponseEntity.notFound().build();
		}
	}

	@GetMapping("/statistics")
	public ResponseEntity<Map<ProductType, Integer>> getStatistics() {
		Map<ProductType, Integer> result = new HashMap<Product.ProductType, Integer>() {
			private static final long serialVersionUID = 1L;
			{
				put(ProductType.NATURAL_FOOD,
						Iterables.size(productRepository.findAllByProductType(ProductType.NATURAL_FOOD)));
				put(ProductType.VITAMIN, Iterables.size(productRepository.findAllByProductType(ProductType.VITAMIN)));
			}
		};
		return ResponseEntity.ok(result);
	}
}
