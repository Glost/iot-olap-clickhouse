//
//  AggregatedGraphModel.swift
//  Clickhouse-Project-ios
//
//  Created by Александр Плесовских on 08/12/2019.
//  Copyright © 2019 Alex. All rights reserved.
//


import UIKit


//Структура для разбора ответа сервера
//Значения датчиков для координат
struct AggregatedGraphModel: Codable
{
	//	{
	//	"air_temperature":[],
	//	"air_humidity":[],
	//	"wind_speed":[],
	//	"illuminance":[],
	//	"avg_rains_values":[]
	//	}
	var air_temperature: [GraphElementModel]
	var air_humidity: [GraphElementModel]
	var wind_speed: [GraphElementModel]
	var illuminance: [GraphElementModel]
	var avg_rains_values: [GraphElementModelAvgRain]
}
