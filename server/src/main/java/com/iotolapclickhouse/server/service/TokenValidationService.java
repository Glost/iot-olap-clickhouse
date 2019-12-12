package com.iotolapclickhouse.server.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

@Service
public class TokenValidationService {

    private final String generatorToken;

    private final String clientToken;

    @Autowired
    public TokenValidationService(@Value("${token.generator}") String generatorToken,
                                  @Value("${token.client}") String clientToken) {
        this.generatorToken = generatorToken;
        this.clientToken = clientToken;
    }

    public void validateGeneratorToken(String receivedGeneratorToken) {
        validateToken(receivedGeneratorToken, generatorToken);
    }

    public void validateClientToken(String receivedClientToken) {
        validateToken(receivedClientToken, clientToken);
    }

    private void validateToken(String receivedToken, String validToken) {
        if (receivedToken == null || !receivedToken.equals(validToken)) {
            throw new SecurityException("Received token was invalid");
        }
    }
}
