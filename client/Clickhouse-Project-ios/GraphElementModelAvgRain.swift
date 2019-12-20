//
//  GraphElementModelAvgRain.swift
//  Clickhouse-Project-ios
//
//  Created by Александр Плесовских on 06/12/2019.
//  Copyright © 2019 Alex. All rights reserved.
//


import UIKit


//Структура для разбора ответа сервера
//Значения датчиков о средней дождливости
struct GraphElementModelAvgRain: Codable, GraphElementProtocol
{
	func getValueForType(type: GraphType) -> CGFloat {
		switch type {
		case .avg_rain:
			return avg_rains
		default:
			return 0
		}
	}
	
	func getTimestamp() -> Date {
		return timestamp
	}
//	{
//	"timestamp":"2019-12-03 22:00:00.000Z",
//	"avg_rains":0.875
//	}
	private var timestamp: Date
	private var avg_rains: CGFloat
}
