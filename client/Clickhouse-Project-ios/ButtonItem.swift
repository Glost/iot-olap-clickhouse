//
//  ButtonItem.swift
//  Clickhouse-Project-ios
//
//  Created by Александр Плесовских on 18/12/2019.
//  Copyright © 2019 Alex. All rights reserved.
//


import Foundation

protocol ButtonProtocol
{
	var delegate: ViewControllerProtocol? { get set }
	func buttonPressed()
}

class ButtonItem: ItemProtocol, ButtonProtocol
{
	var delegate: ViewControllerProtocol?
	
	init(id: String, cellId: String, buttonTitle: String)
	{
		self.id = id
		self.cellId = cellId
		self.buttonTitle = buttonTitle
	}
	
	var id: String
	var cellId: String
	var buttonTitle: String
	
	@objc func buttonPressed()
	{
		delegate?.finishButtonPressed()
	}
}
