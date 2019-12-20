//
//  TextFieldPickerItem.swift
//  Clickhouse-Project-ios
//
//  Created by Александр Плесовских on 17/12/2019.
//  Copyright © 2019 Alex. All rights reserved.
//


import UIKit


class TextFieldPickerItem: NSObject, ItemProtocol, UIPickerViewDataSource, UIPickerViewDelegate, ItemWithValueProtocol
{
	init(id: String, cellId: String, placeholder: String, picker: UIPickerView, pickerElements:[PickerElement])
	{
		self.id = id
		self.cellId = cellId
		self.placeholder = placeholder
		self.pickerForTextField = picker
		self.pickerElements = pickerElements
		self.value = nil
		super.init()
		self.pickerForTextField.delegate = self
		self.pickerForTextField.dataSource = self
	}
	
	var id: String
	var cellId: String
	var placeholder: String
	var pickerForTextField: UIPickerView
	var value: String?
	private var pickerElements: [PickerElement]
	var cellDelegate: CellProtocol?
	
	func getValue() -> Any? {
		return value
	}
}

//UIPickerViewDataSource, UIPickerViewDelegate
extension TextFieldPickerItem
{
	func numberOfComponents(in pickerView: UIPickerView) -> Int
	{
		return 1
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
	{
		return self.pickerElements.count
	}
	
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
	{
		return pickerElements[row].descriptionForUser
	}
	
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
	{
		cellDelegate?.updateValue(value: pickerElements[row].descriptionForUser)
		self.value = pickerElements[row].valueForSystem
	}
}
