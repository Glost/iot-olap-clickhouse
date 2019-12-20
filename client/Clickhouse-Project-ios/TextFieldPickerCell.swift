//
//  TextFieldPickerCell.swift
//  Clickhouse-Project-ios
//
//  Created by Александр Плесовских on 17/12/2019.
//  Copyright © 2019 Alex. All rights reserved.
//


import UIKit


class TextFieldPickerCell: TextFieldCell, CellProtocol
{
	//протокол
	func setFieldItem(item: ItemProtocol)
	{
		if (item is TextFieldPickerItem)
		{
			let textFieldItem = item as! TextFieldPickerItem
			textField.placeholder = textFieldItem.placeholder
			textField.inputView = textFieldItem.pickerForTextField
			textFieldItem.cellDelegate = self
		}
	}
	
	func updateValue(value: String)
	{
		self.textField.text = value
	}
}
