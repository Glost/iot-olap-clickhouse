//
//  NetworkRequestBody.swift
//  Clickhouse-Project-ios
//
//  Created by Александр Плесовских on 14/12/2019.
//  Copyright © 2019 Alex. All rights reserved.
//


import Foundation


//Структура для подготовки ответа сервера
//Значения датчиков для координат
struct NetworkRequestBody : Codable
{
//	{
//	"altitude_intervals": [
//	{
//	"from": 150.0,
//	"to": 450.0
//	}
//	],
//	"timestamp_interval": {
//	"from": "2019-12-01 17:18:48.126+0300",
//	"to": "2019-12-05 15:00:00.000+0300"
//	},
//	"aggregated_period": "HOUR",
//	"need_split_by_coordinates": false
//	}
	
	enum CodingKeys: String, CodingKey {
		case aggregated_period
		case need_split_by_coordinates
		case timestamp_interval
		case altitude_intervals
		case latitude_intervals
		case longitude_intervals
	}
	
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(aggregated_period, forKey: .aggregated_period)
		try container.encode(need_split_by_coordinates, forKey: .need_split_by_coordinates)
		if let timeStamp = timestamp_interval {
			try container.encode(timeStamp, forKey: .timestamp_interval)
		}
		
		if let latitude = latitude_intervals {
			try container.encode([latitude], forKey: .latitude_intervals)
		}
		
		if let longitude = longitude_intervals {
			try container.encode([longitude], forKey: .longitude_intervals)
		}
		
		if let altitude = altitude_intervals {
			try container.encode([altitude], forKey: .altitude_intervals)
		}
	}
	
	//Высота
	var altitude_intervals: Dictionary<String, String>? = nil
	//Широта
	var latitude_intervals: Dictionary<String, String>? = nil
	//Долгота
	var longitude_intervals: Dictionary<String, String>? = nil
	
	var aggregated_period: String
	let need_split_by_coordinates = false
	var timestamp_interval: Dictionary<String, String>? = nil
	init(aggregatedPeriod: String, timeFrom: Date, timeTo: Date)
	{
		self.aggregated_period = aggregatedPeriod
		let formatter = DateFormatter()
		//"timestamp":"2019-12-01 17:00:00.000+0300",
		formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSZ"
		//formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
		self.timestamp_interval = [
			"from":formatter.string(from: timeFrom),
			"to":formatter.string(from: timeTo),
		];
	}
	
	init(dictionary: Dictionary<String, Any>)
	{
		self.aggregated_period = dictionary[textFieldId_aggregated_period] as! String
		//дата от и до
		let timestamp_from = dictionary[textFieldId_timestamp_interval_from] as? Date
		let timestamp_to = dictionary[textFieldId_timestamp_interval_to] as? Date
		if ((timestamp_to != nil) && (timestamp_from != nil))
		{
			let formatter = DateFormatter()
			//"timestamp":"2019-12-01 17:00:00.000+0300",
			formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSZ"
			self.timestamp_interval = [
				"from":formatter.string(from: timestamp_from!),
				"to":formatter.string(from: timestamp_to!),
			];
		}
		//latitude
		if let latitude_max = dictionary[textFieldId_latitude_intervals_max] as? String,
			let latitude_min = dictionary[textFieldId_latitude_intervals_min] as? String
		{
			self.latitude_intervals = [
				"from":latitude_min,
				"to":latitude_max
			];
		}
		
		//longitude
		if let longitude_max = dictionary[textFieldId_longitude_intervals_max] as? String,
			let longitude_min = dictionary[textFieldId_longitude_intervals_min] as? String
		{
			self.longitude_intervals = [
				"from":longitude_min,
				"to":longitude_max
			];
		}
		
		//altitude
		if let altitude_max = dictionary[textFieldId_altitude_intervals_max] as? String,
			let altitude_min = dictionary[textFieldId_altitude_intervals_min] as? String
		{
			self.latitude_intervals = [
				"from":altitude_min,
				"to":altitude_max
			];
		}
	}
}
