package com.healthyfighter.repositories;

import org.springframework.data.repository.CrudRepository;

import com.healthyfighter.entities.Product;
import com.healthyfighter.entities.Product.ProductType;

public interface ProductRepository extends CrudRepository<Product, Integer>{
	public Iterable<Product> findAllByProductType(ProductType productType);
	
	public Iterable<Product> findAllByIsValidated(Boolean isValidated);
}