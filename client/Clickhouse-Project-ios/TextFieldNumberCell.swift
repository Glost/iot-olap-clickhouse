//
//  TextFieldNumberCell.swift
//  Clickhouse-Project-ios
//
//  Created by Александр Плесовских on 18/12/2019.
//  Copyright © 2019 Alex. All rights reserved.
//


import UIKit


class TextFieldNumberCell: TextFieldCell, CellProtocol, UITextFieldDelegate
{
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String!) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		textField.delegate = self
		textField.keyboardType = UIKeyboardType.decimalPad
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	var delegate: ItemProtocol?
	//протокол
	func setFieldItem(item: ItemProtocol)
	{
		if (item is TextFieldNumberItem)
		{
			let textFieldNumberItem = item as! TextFieldNumberItem
			if let value = textFieldNumberItem.value {
				textField.text = value
			} else {
				textField.placeholder = textFieldNumberItem.placeholder
			}
			delegate = textFieldNumberItem
			textFieldNumberItem.cellDelegate = self
		}
	}
	
	func updateValue(value: String)
	{
		self.textField.text = value
	}
	
	func textFieldDidEndEditing(_ textField: UITextField)
	{
		self.delegate?.valueUpdated(value: textField.text)
	}
}
