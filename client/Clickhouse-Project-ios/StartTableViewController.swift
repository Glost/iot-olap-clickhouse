//
//  StartTableViewController.swift
//  Clickhouse-Project-ios
//
//  Created by Александр Плесовских on 17/12/2019.
//  Copyright © 2019 Alex. All rights reserved.
//


import UIKit


protocol ViewControllerProtocol
{
	func finishButtonPressed()
}

class StartTableViewController: UITableViewController, ViewControllerProtocol
{
	private var items: [ItemProtocol] = []
	
	init(items: [ItemProtocol])
	{
		self.items = items
		super.init(style: .plain)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

//MARK: - Lifecycle
extension StartTableViewController
{
	override func viewDidLoad()
	{
		for item in items
		{
			if item is ButtonProtocol
			{
				var buttonItem = item as! ButtonProtocol
				buttonItem.delegate = self
			}
		}
		
		super.viewDidLoad()
		self.tableView.backgroundColor = .white
		self.tableView.delegate = self
		self.tableView.dataSource = self
		
		self.tableView.register(TextFieldDatePickerCell.self, forCellReuseIdentifier: textFieldDatePickerCellIdentifier)
		self.tableView.register(LabelFieldCell.self, forCellReuseIdentifier: labelFieldCellIdentifier)
		self.tableView.register(TextFieldPickerCell.self, forCellReuseIdentifier: textFieldPickerCellIdentifier)
		self.tableView.register(TextFieldNumberCell.self, forCellReuseIdentifier: textFieldNumberCellIdentifier)
		self.tableView.register(ButtonCell.self, forCellReuseIdentifier: buttonCellIdentifier)
		
		tableView.rowHeight = UITableView.automaticDimension
		tableView.estimatedRowHeight = 25
		
		tableView.tableFooterView = UIView()
		tableView.separatorStyle = .none
	}
	
	override func viewWillAppear(_ animated: Bool)
	{
		super.viewWillAppear(animated)
		self.title = "Начальный экран"
		tableView.reloadData()
	}
}


//MARK: - TableViewDataSource, TableViewDelegate

extension StartTableViewController
{
	override func numberOfSections(in tableView: UITableView) -> Int
	{
		return 1
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		return items.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
	{
		let item = items[indexPath.row]

		var cell = tableView.dequeueReusableCell(withIdentifier: item.cellId, for: indexPath) as! CellProtocol
		if cell is ButtonProtocol
		{
			var buttonCell = cell as! ButtonProtocol
			buttonCell.delegate = self
			cell = buttonCell as! CellProtocol
		}
		cell.setFieldItem(item: item)
		return cell as! UITableViewCell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
	{
		tableView.deselectRow(at: indexPath, animated: false)
	}
}

extension StartTableViewController
{
	func finishButtonPressed()
	{
		var dictionary: [String:Any] = [:]
		for item in items
		{
			if item is ItemWithValueProtocol
			{
				let itemWithValue = item as! ItemWithValueProtocol
				if let value = itemWithValue.getValue()
				{
					dictionary.updateValue(value, forKey: item.id)
				}
			}
		}
		//проверяем
		//дата начала
		guard dictionary[textFieldId_timestamp_interval_from] != nil else {
			self.showAlertWith(title: "Данные не введены", message: "Необходимо заполнить поле даты начала")
			return
		}
		//дата окончания
		guard dictionary[textFieldId_timestamp_interval_to] != nil else {
			self.showAlertWith(title: "Данные не введены", message: "Необходимо заполнить поле даты окончания")
			return
		}
		//агрегация по времени
		guard dictionary[textFieldId_aggregated_period] != nil else {
			self.showAlertWith(title: "Данные не введены", message: "Необходимо заполнить поле типа агрегации")
			return
		}
		
		//проверка latitude
		guard !self.checkThatOnlyOneFieldIsEmpty(dict: dictionary,
												id1: textFieldId_latitude_intervals_min,
												id2: textFieldId_latitude_intervals_max)
			else {
				self.showAlertWith(title: "Данные не введены", message: "Необходимо либо заполнить оба поля с данными о latitude, либо оставить их пустыми.")
				return
		}
		
		//проверка longitude
		guard !self.checkThatOnlyOneFieldIsEmpty(dict: dictionary,
												id1: textFieldId_longitude_intervals_min,
												id2: textFieldId_longitude_intervals_max)
			else {
				self.showAlertWith(title: "Данные не введены", message: "Необходимо либо заполнить оба поля с данными о longitude, либо оставить их пустыми.")
				return
		}
		
		//проверка altitude
		guard !self.checkThatOnlyOneFieldIsEmpty(dict: dictionary,
												id1: textFieldId_altitude_intervals_max,
												id2: textFieldId_altitude_intervals_min)
			else {
				self.showAlertWith(title: "Данные не введены", message: "Необходимо либо заполнить оба поля с данными о altitude, либо оставить их пустыми.")
				return
		}
		
		
		//Формируем и отправляем запрос
		let body = NetworkRequestBody(dictionary: dictionary)
		let choiceVC = ChooseGraphViewController(body:body)
		let backItem = UIBarButtonItem(title: "Назад", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
		navigationItem.backBarButtonItem = backItem
		self.navigationController?.pushViewController(choiceVC, animated: true)
	}
	
	func showAlertWith(title: String, message: String)
	{
		let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
		alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
		self.present(alert, animated: true, completion: nil)
	}
	
	func checkThatOnlyOneFieldIsEmpty(dict: Dictionary<String, Any>, id1: String, id2: String) -> Bool
	{
		let onlyFirstFiled: Bool = dict[id1] != nil && dict[id2] == nil
		let onlySecondFiled: Bool = dict[id1] == nil && dict[id2] != nil

		return onlyFirstFiled || onlySecondFiled
	}
}
