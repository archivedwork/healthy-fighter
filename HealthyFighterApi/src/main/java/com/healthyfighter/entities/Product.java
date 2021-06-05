package com.healthyfighter.entities;

import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.validation.constraints.NotBlank;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode
public class Product {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

	@Column(nullable = false)
	@Enumerated(EnumType.STRING)
	private ProductType productType;

	public enum ProductType {
		NATURAL_FOOD, VITAMIN
	}

	@Column
	private Boolean isValidated;

	@Column(nullable = false)
	@NotBlank
	private String name;

	@Column(nullable = false)
	@NotBlank
	private String vitamine;

	@Column
	private Double protein;

	@Column
	private Double carb;

	@Column(nullable = false)
	@NotBlank
	private String fight;

	@Column
	private Boolean isAllergic;

	@Column
	private String description;

	@Column
	private String link;

	@ManyToOne
	private User addedBy;

	@ManyToOne
	private User validityChangedBy;

	@Column(updatable = false)
	@CreationTimestamp
	private LocalDateTime createdAt;

	@Column
	@UpdateTimestamp
	private LocalDateTime updatedAt;



}
