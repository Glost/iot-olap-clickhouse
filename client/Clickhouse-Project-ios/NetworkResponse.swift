//
//  NetworkResponse.swift
//  Clickhouse-Project-ios
//
//  Created by Александр Плесовских on 03/12/2019.
//  Copyright © 2019 Alex. All rights reserved.
//


import UIKit


//Структура для разбора ответа сервера
//Весь ответ, успешность операции
struct NetworkResponse: Codable
{
	//{
	//"is_success":true,
	//"error_message":null,
	//"click_house_query_execution_time":74,
	//"sensor_aggregated_values":[]
	//}
	var is_success: Bool
	var error_message: String?
	var click_house_query_execution_time: Int
	var sensor_aggregated_values: [AggregatedValuesModel]?
}
