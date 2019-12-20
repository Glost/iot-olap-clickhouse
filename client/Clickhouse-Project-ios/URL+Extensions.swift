//
//  URL+Extensions.swift
//  Clickhouse-Project-ios
//
//  Created by Александр Плесовских on 03/12/2019.
//  Copyright © 2019 Alex. All rights reserved.
//


import Foundation


//Расширение для запросов к API
extension URL
{
	struct Graph
	{
		private init() { }
	}
}

extension URL.Graph
{
	private static let baseService = "http://84.201.158.2/"
	//Получение данных о графах
	static func getGraphURL() ->URL
	{
		//getAggregatedData
		let url = baseService + "/getAggregatedData"
		//let url = baseService + "/ping"
		return URL(string: url)!
	}
}
