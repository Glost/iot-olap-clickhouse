//
//  TextFieldDatePickerItem.swift
//  Clickhouse-Project-ios
//
//  Created by Александр Плесовских on 17/12/2019.
//  Copyright © 2019 Alex. All rights reserved.
//


import UIKit


class TextFieldDatePickerItem: ItemProtocol, ItemWithValueProtocol
{
	init(id: String, cellId: String, placeholder: String, datePicker: UIDatePicker)
	{
		self.id = id
		self.cellId = cellId
		self.placeholder = placeholder
		self.datePickerForTextField = datePicker
		self.datePickerForTextField.addTarget(self, action: #selector(updateDate), for: .valueChanged)
		self.timeValue = nil
	}
	
	var id: String
	var cellId: String
	var placeholder: String
	var datePickerForTextField: UIDatePicker
	var timeValue: Date?
	var cellDelegate: CellProtocol?
	
	@objc func updateDate()
	{
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd HH:mm"
		timeValue = self.datePickerForTextField.date
		cellDelegate?.updateValue(value: formatter.string(from: self.datePickerForTextField.date))
	}
	
	func getValue() -> Any? {
		return timeValue
	}
}
