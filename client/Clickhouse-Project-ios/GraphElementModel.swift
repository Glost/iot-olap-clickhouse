//
//  GraphElementModel.swift
//  Clickhouse-Project-ios
//
//  Created by Александр Плесовских on 08/12/2019.
//  Copyright © 2019 Alex. All rights reserved.
//


import UIKit


//Структура для разбора ответа сервера
//Значения датчиков о температуре\скорости ветра\прочее
struct GraphElementModel: Codable, GraphElementProtocol
{
	func getValueForType(type: GraphType) -> CGFloat {
		switch type {
		case .min:
			return min
		case .max:
			return max
		case .avg:
			return avg
		case .median:
			return median
		case .variance:
			return variance
		default:
			return 0
		}
	}
	
	func getTimestamp() -> Date {
		return timestamp
	}
//	{
//	"timestamp":"2019-12-01 20:00:00.000Z",
//	"min":15.7,
//	"max":15.7,
//	"avg":15.7,
//	"median":15.7,
//	"variance":0.0
//	}
	private var timestamp: Date
	private var min: CGFloat
	private var max: CGFloat
	private var avg: CGFloat
	private var median: CGFloat
	private var variance: CGFloat
}
