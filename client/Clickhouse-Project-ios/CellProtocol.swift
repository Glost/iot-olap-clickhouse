//
//  CellProtocol.swift
//  Clickhouse-Project-ios
//
//  Created by Александр Плесовских on 17/12/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation

protocol CellProtocol
{
	func setFieldItem(item: ItemProtocol)
	func updateValue(value: String)
}

extension CellProtocol
{
	func updateValue(value: String)
	{
		
	}
}
