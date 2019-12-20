//
//  TextFieldNumberItem.swift
//  Clickhouse-Project-ios
//
//  Created by Александр Плесовских on 18/12/2019.
//  Copyright © 2019 Alex. All rights reserved.
//


import UIKit


class TextFieldNumberItem: ItemProtocol, ItemWithValueProtocol
{
	init(id: String, cellId: String, placeholder: String)
	{
		self.id = id
		self.cellId = cellId
		self.placeholder = placeholder
		self.value = nil
	}
	
	var id: String
	var cellId: String
	var placeholder: String
	var value: String?
	var cellDelegate: CellProtocol?
	
	func valueUpdated(value: String?)
	{
		self.value = value
	}
	
	func getValue() -> Any?
	{
		return self.value == "" ? nil : self.value
	}
}
