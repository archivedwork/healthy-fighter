package com.healthyfighter.restcontroller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import com.healthyfighter.entities.UserDTO;
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

import static org.junit.Assert.*;
import static org.springframework.http.MediaType.APPLICATION_JSON_UTF8;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@RunWith(SpringRunner.class)
@SpringBootTest
@TestPropertySource(locations="classpath:application-test.properties")
public class JwtAuthenticationControllerTest {

    private MockMvc mockMvc;

    @Autowired
    private JwtAuthenticationController jwtAuthenticationController;

    @InjectMocks
    private ObjectMapper objectMapper;

    @Before
    public void setUp() {
        objectMapper.registerModule(new JavaTimeModule());
        mockMvc = MockMvcBuilders.standaloneSetup(jwtAuthenticationController).build();
    }

    @Test
    public void checkCorrectAuthentication() throws Exception {
        mockMvc.perform(post("/api/authentication")
                .contentType(APPLICATION_JSON_UTF8).content("{\"username\":\"latifguliyev\",\"password\":\"TestPassword\"}"))
                .andExpect(status().isOk());
    }

    @Test
    public void checkIncorrectAuthentication() {
        try {
            mockMvc.perform(post("/api/authentication")
                    .contentType(APPLICATION_JSON_UTF8).content("{\"username\":\"wrongUserName\",\"password\":\"WrongPassword\"}"));
            fail("Test should return BadCredentialException for wrong input data! But request got success sate!");
        } catch (Exception ex) {
            assertTrue(true);
        }
    }

    @Test
    public void registerNewUser() throws Exception {
        String responseJson = mockMvc.perform(post("/api/authentication/register")
                .contentType(APPLICATION_JSON_UTF8).content(
                        "{\"name\":\"testname\",\"surname\":\"testsurname\",\"email\":\"testemail@gmail.com\",\"username\":\"testuser\",\"password\":\"testpassword\"}"
                ))
                .andExpect(status().isOk())
                .andReturn().getResponse().getContentAsString();
        UserDTO actualUser = objectMapper.readValue(responseJson, UserDTO.class);
        UserDTO expectedUser = new UserDTO(actualUser.getId(), "testname", "testsurname", "testemail@gmail.com",
                "testuser", null, actualUser.getCreatedAt(), actualUser.getUpdatedAt());
        assertEquals(expectedUser, actualUser);
    }
}