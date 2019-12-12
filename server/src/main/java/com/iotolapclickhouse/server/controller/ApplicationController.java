package com.iotolapclickhouse.server.controller;

import com.iotolapclickhouse.server.model.request.GetAggregatedDataRequest;
import com.iotolapclickhouse.server.model.request.PushDataRequest;
import com.iotolapclickhouse.server.model.response.GetAggregatedDataResponse;
import com.iotolapclickhouse.server.service.SensorValuesService;
import com.iotolapclickhouse.server.service.TokenValidationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RestController;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;

@RestController
public class ApplicationController {

    private final SensorValuesService sensorValuesService;

    private final TokenValidationService tokenValidationService;

    @Autowired
    public ApplicationController(SensorValuesService sensorValuesService,
                                 TokenValidationService tokenValidationService) {
        this.sensorValuesService = sensorValuesService;
        this.tokenValidationService = tokenValidationService;
    }

    @PostMapping("pushData")
    public void pushData(@RequestBody @NotNull @Valid PushDataRequest request,
                         @RequestHeader String token) {
        tokenValidationService.validateGeneratorToken(token);
        sensorValuesService.pushData(request);
    }

    @PostMapping("getAggregatedData")
    @NotNull
    public GetAggregatedDataResponse getAggregatedData(@RequestBody @NotNull @Valid GetAggregatedDataRequest request,
                                                       @RequestHeader String token) {
        tokenValidationService.validateClientToken(token);
        return sensorValuesService.getAggregatedData(request);
    }
}
