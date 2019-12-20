//
//  ComponentBuilder.swift
//  Clickhouse-Project-ios
//
//  Created by Александр Плесовских on 17/12/2019.
//  Copyright © 2019 Alex. All rights reserved.
//


import UIKit


class ComponentBuilder
{
	static func createStartScreen() -> [ItemProtocol]
	{
		var itemsArray:[ItemProtocol] = []
		itemsArray.append(LabelFieldItem(text: "Подготовка запроса",
										 font: UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold),
										 cellId: labelFieldCellIdentifier))
		
		//Первая дата
		itemsArray.append(LabelFieldItem(text: "Выберите дату начала",
										 font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.regular),
										 cellId: labelFieldCellIdentifier))
		itemsArray.append(TextFieldDatePickerItem(id: textFieldId_timestamp_interval_from,
												  cellId: textFieldDatePickerCellIdentifier,
												  placeholder: "Выберите дату начала",
												  datePicker: createDatePicker()))
		
		//вторая дата
		itemsArray.append(LabelFieldItem(text: "Выберите дату окончания",
										 font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.regular),
										 cellId: labelFieldCellIdentifier))
		itemsArray.append(TextFieldDatePickerItem(id: textFieldId_timestamp_interval_to,
												  cellId: textFieldDatePickerCellIdentifier,
												  placeholder: "Выберите дату окончания",
												  datePicker: createDatePicker()))
		
		//третий пикер
		itemsArray.append(LabelFieldItem(text: "Выберите агрегацию по времени",
										 font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.regular),
										 cellId: labelFieldCellIdentifier))
		itemsArray.append(TextFieldPickerItem(id: textFieldId_aggregated_period,
											  cellId: textFieldPickerCellIdentifier,
											  placeholder: "Выберите агрегацию по времени",
											  picker: createPicker(),
											  pickerElements: aggregatedPeriodElementsArray()))
		
		//Ввод координат широта
		itemsArray.append(LabelFieldItem(text: "Можно задать интервал значений по latitude или оставить пустым",
										 font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold),
										 cellId: labelFieldCellIdentifier))
		
		itemsArray.append(contentsOf: createLabelAndTextFieldItems(labelText: "Минимальное значение latitude",
																   textFieldId: textFieldId_latitude_intervals_min,
																   textFieldPlaceholder: "Введите значение"))
		itemsArray.append(contentsOf: createLabelAndTextFieldItems(labelText: "Максимальное значение latitude",
																   textFieldId: textFieldId_latitude_intervals_max,
																   textFieldPlaceholder: "Введите значение"))
		
		//Ввод координат долготы
		itemsArray.append(LabelFieldItem(text: "Можно задать интервал значений по longitude или оставить пустым",
										 font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold),
										 cellId: labelFieldCellIdentifier))
		itemsArray.append(contentsOf: createLabelAndTextFieldItems(labelText: "Минимальное значение longitude",
																   textFieldId: textFieldId_longitude_intervals_min,
																   textFieldPlaceholder: "Введите значение"))
		itemsArray.append(contentsOf: createLabelAndTextFieldItems(labelText: "Максимальное значение longitude",
																   textFieldId: textFieldId_longitude_intervals_max,
																   textFieldPlaceholder: "Введите значение"))
		
		//Ввод координат высоты
		itemsArray.append(LabelFieldItem(text: "Можно задать интервал значений по altitude или оставить пустым",
										 font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold),
										 cellId: labelFieldCellIdentifier))
		
		itemsArray.append(contentsOf: createLabelAndTextFieldItems(labelText: "Минимальное значение altitude",
																   textFieldId: textFieldId_altitude_intervals_min,
																   textFieldPlaceholder: "Введите значение"))
		itemsArray.append(contentsOf: createLabelAndTextFieldItems(labelText: "Максимальное значение altitude",
																   textFieldId: textFieldId_altitude_intervals_max,
																   textFieldPlaceholder: "Введите значение"))
		
		
		itemsArray.append(ButtonItem(id: "but1", cellId: buttonCellIdentifier, buttonTitle: "Получить данные"))
		
		return itemsArray
	}
	
	
	static func createDatePicker() -> UIDatePicker
	{
		let pickerView = UIDatePicker()
		pickerView.backgroundColor = .white
		pickerView.translatesAutoresizingMaskIntoConstraints = false
		pickerView.locale = Locale(identifier: "ru_RU")
		return pickerView
	}
	
	static func createPicker() -> UIPickerView
	{
		let pickerView = UIPickerView()
		pickerView.backgroundColor = .white
		pickerView.showsSelectionIndicator = true
		return pickerView
	}
	
	static func aggregatedPeriodElementsArray() -> [PickerElement]
	{
		var pickerElements: [PickerElement] = []
		//pickerElements.append(PickerElement(valueForSystem: "", descriptionForUser: "Выберите агрегацию по времени"))
		pickerElements.append(PickerElement(valueForSystem: "MINUTE", descriptionForUser: "По минутам"))
		pickerElements.append(PickerElement(valueForSystem: "HOUR", descriptionForUser: "По часам"))
		pickerElements.append(PickerElement(valueForSystem: "DAY", descriptionForUser: "По дням"))
		return pickerElements
	}
	
	static func createLabelAndTextFieldItems(labelText: String, textFieldId: String, textFieldPlaceholder: String) ->Array<ItemProtocol>
	{
		var itemsArray: [ItemProtocol] = []
		//Ввод координат высоты
		itemsArray.append(LabelFieldItem(text: labelText,
										 font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.regular),
										 cellId: labelFieldCellIdentifier))
		itemsArray.append(TextFieldNumberItem(id: textFieldId,
											  cellId: textFieldNumberCellIdentifier,
											  placeholder: textFieldPlaceholder))
		return itemsArray
	}
}
