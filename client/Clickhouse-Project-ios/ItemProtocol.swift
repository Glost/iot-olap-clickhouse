//
//  ItemProtocol.swift
//  Clickhouse-Project-ios
//
//  Created by Александр Плесовских on 17/12/2019.
//  Copyright © 2019 Alex. All rights reserved.
//


import Foundation


protocol ItemProtocol
{
	var id: String { get set }
	var cellId: String { get set }
	func valueUpdated(value: String?)
}

extension ItemProtocol
{
	func valueUpdated(value: String?)
	{
		fatalError()
	}
}

protocol ItemWithValueProtocol
{
	func getValue() -> Any?
}
