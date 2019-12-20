//
//  TextFieldDatePickerCell.swift
//  Clickhouse-Project-ios
//
//  Created by Александр Плесовских on 17/12/2019.
//  Copyright © 2019 Alex. All rights reserved.
//


import UIKit


class TextFieldDatePickerCell: TextFieldCell, CellProtocol
{
	//протокол
	func setFieldItem(item: ItemProtocol)
	{
		if (item is TextFieldDatePickerItem)
		{
			let textFieldItem = item as! TextFieldDatePickerItem
			textField.placeholder = textFieldItem.placeholder
			textField.inputView = textFieldItem.datePickerForTextField
			textFieldItem.cellDelegate = self
		}
	}

	func updateValue(value: String)
	{
		self.textField.text = value
	}
}
