//
//  GraphElementProtocol.swift
//  Clickhouse-Project-ios
//
//  Created by Александр Плесовских on 15/12/2019.
//  Copyright © 2019 Alex. All rights reserved.
//


import UIKit


protocol GraphElementProtocol
{
	func getValueForType(type: GraphType) -> CGFloat
	func getTimestamp() -> Date
}
