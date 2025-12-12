package com.config;

import io.swagger.v3.oas.annotations.OpenAPIDefinition;
import io.swagger.v3.oas.annotations.info.Info;
import org.springframework.context.annotation.Configuration;

@Configuration
@OpenAPIDefinition(
        info = @Info(
                title = "SpringBoot_test",
                version = "1.0",
                description = "Test for Film database w SpringBoot"
        )
)
public class OpenApiConfig {

}
