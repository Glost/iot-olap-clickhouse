//
//  LabelFieldItem.swift
//  Clickhouse-Project-ios
//
//  Created by Александр Плесовских on 17/12/2019.
//  Copyright © 2019 Alex. All rights reserved.
//


import UIKit


class LabelFieldItem: ItemProtocol
{
	init(text: String, font: UIFont, cellId: String)
	{
		self.id = ""
		self.text = text
		self.cellId = cellId
		self.font = font
	}
	
	var id: String
	var cellId: String
	var text: String
	var font: UIFont
}
