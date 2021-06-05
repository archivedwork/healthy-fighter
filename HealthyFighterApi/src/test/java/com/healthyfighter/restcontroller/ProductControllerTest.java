package com.healthyfighter.restcontroller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import com.healthyfighter.entities.Product;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.TestPropertySource;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

import javax.servlet.Filter;
import java.util.Arrays;

import static org.junit.Assert.assertArrayEquals;
import static org.junit.Assert.assertEquals;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@RunWith(SpringRunner.class)
@SpringBootTest
@TestPropertySource(locations="classpath:application-test.properties")
public class ProductControllerTest {

    private MockMvc mockMvc;

    @Autowired
    private ProductController productController;

    @Autowired
    private Filter jwtRequestFilter;

    @InjectMocks
    private ObjectMapper objectMapper;

    @Before
    public void setUp() {
        objectMapper.registerModule(new JavaTimeModule());
        mockMvc = MockMvcBuilders.standaloneSetup(productController).addFilter(jwtRequestFilter).build();
    }

    @Test
    public void checkProductsAvailability() throws Exception {
        String responseJSON = mockMvc.perform(get("/api/products/simpleuser"))
                .andExpect(status().isOk())
                .andReturn()
                .getResponse()
                .getContentAsString();
        String[] actualProductsNames = Arrays.stream(objectMapper.readValue(responseJSON, Product[].class)).map(Product::getName).toArray(String[]::new);
        String[] expectedProductsNames = new String[]{
                "Tomato", "BioCo K-2 vitamin 50mcg MegaPack 90 db tabletta"
        };
        assertArrayEquals(expectedProductsNames, actualProductsNames);
    }

    @Test
    public void checkIndividualProduct() throws Exception {
        String responseJSON = mockMvc.perform(get("/api/products/simpleuser/1/"))
                .andExpect(status().isOk())
                .andReturn()
                .getResponse()
                .getContentAsString();
        Product actualProduct = objectMapper.readValue(responseJSON, Product.class);
        Product expectedProduct = new Product(actualProduct.getId(), Product.ProductType.NATURAL_FOOD, null, "Tomato",
                "k, c", 1.58, 7.0, "Prostate Cancer", true, "Description", null,
                actualProduct.getAddedBy(), actualProduct.getValidityChangedBy(),
                actualProduct.getCreatedAt(), actualProduct.getUpdatedAt());

        assertEquals(expectedProduct, actualProduct);
    }
}