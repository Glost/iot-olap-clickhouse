//
//  AggregatedValuesModel.swift
//  Clickhouse-Project-ios
//
//  Created by Александр Плесовских on 08/12/2019.
//  Copyright © 2019 Alex. All rights reserved.
//


import UIKit


//Структура для разбора ответа сервера
//Значения датчиков
struct AggregatedValuesModel: Codable
{
	//  {
	//  "coordinates":null,
	//	"aggregated_values":{...}
	//	}
	var aggregated_values: AggregatedGraphModel
}
