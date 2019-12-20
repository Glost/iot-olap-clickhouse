////
////  StartViewController.swift
////  Clickhouse-Project-ios
////
////  Created by Александр Плесовских on 16/12/2019.
////  Copyright © 2019 Alex. All rights reserved.
////
//
//
//import UIKit
//
//
//
//class StartViewController : UIViewController, UIPickerViewDataSource, UIPickerViewDelegate
//{
//	//Описание
//	var mainLabel: UILabel!
//	//От времени
//	var startDateLabel: UILabel!
//	var startDatePicker: UIDatePicker!
//	var startDateTextField: UITextField!
//	
//	//До времени
//	var finishDateLabel: UILabel!
//	var finishDatePicker: UIDatePicker!
//	var finishDateTextField: UITextField!
//	
//	//выбор чего?
//	var pickerGroupLabel: UILabel!
//	var pickerGroupTextField: UITextField!
//	
//	var startButton: UIButton!
//	
////	MINUTE - одна минута
////	HOUR - один час
////	DAY - один день
//	let salutations = [TimeGroupSetting(timeForRequest: "", timeForUser: "Задайте группировку по времени"),
//					   TimeGroupSetting(timeForRequest: "MINUTE", timeForUser: "Минута"),
//					   TimeGroupSetting(timeForRequest: "HOUR", timeForUser: "Час"),
//					   TimeGroupSetting(timeForRequest: "DAY", timeForUser: "День")]
//	
//	override func viewDidLoad() {
//		super.viewDidLoad()
//		
//		mainLabel = self.createLabel()
//		mainLabel.text = "Программа для работы с хранилищем данных - ClickHouse"
//		mainLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
//		
//		startDateLabel = self.createLabel()
//		startDateLabel.text = "Дата с которой начать группировать данные"
//		startDateTextField = self.createPickerGroupTextField(placeholder: "Выбрать дату начала")
//		startDatePicker = self.createDatePicker()
//		startDatePicker.addTarget(self, action: #selector(updateStartDate), for: .valueChanged)
//		startDateTextField.inputView = startDatePicker
//		
//		finishDateLabel = self.createLabel()
//		finishDateLabel.text = "Дата до которой группировать данные"
//		finishDateTextField = self.createPickerGroupTextField(placeholder: "Выбрать дату окончания")
//		finishDatePicker = self.createDatePicker()
//		finishDatePicker.addTarget(self, action: #selector(updateFinishDate), for: .valueChanged)
//		finishDateTextField.inputView = finishDatePicker
//		
//		pickerGroupLabel = self.createLabel()
//		pickerGroupLabel.text = "По каким отрезкам времени группировать данные"
//		pickerGroupTextField = self.createPickerGroupTextField(placeholder: "Задать время")
//		
//		let pickerView = UIPickerView()
//		pickerView.delegate = self
//		pickerView.backgroundColor = .white
//		pickerView.showsSelectionIndicator = true
//		pickerView.delegate = self
//		pickerView.dataSource = self
//		pickerGroupTextField.inputView = pickerView
//		
//		startButton = self.createStartButton()
//		startButton.setTitle("Отправить запрос", for: .normal)
//		startButton.setTitleColor(.black, for: .normal)
//		startButton.addTarget(self, action: #selector(self.buttonPressed), for: .touchUpInside)
//		//66, 245, 239
//		startButton.backgroundColor = UIColor.myBlueColor
//
//		self.view.addSubview(mainLabel)
//		self.view.addSubview(startDateLabel)
//		self.view.addSubview(startDateTextField)
//		self.view.addSubview(finishDateLabel)
//		self.view.addSubview(finishDateTextField)
//		self.view.addSubview(pickerGroupLabel)
//		self.view.addSubview(pickerGroupTextField)
//		self.view.addSubview(startButton)
//		
//		let mainTopShift: CGFloat = 20
//		let topShift: CGFloat = 20
//		let borderShift: CGFloat = 16
//		
////
////			image.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
////		} else {
////			image.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
////		}
//		if #available(iOS 11.0, *)
//		{
//			NSLayoutConstraint.activate(
//				[
//					self.mainLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: mainTopShift),
//					self.mainLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: borderShift),
//					self.mainLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -borderShift),
//					
//					self.startDateLabel.topAnchor.constraint(equalTo: self.mainLabel.bottomAnchor, constant: topShift+10),
//					self.startDateLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: borderShift),
//					self.startDateLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -borderShift),
//					
//					self.startDateTextField.topAnchor.constraint(equalTo: self.startDateLabel.bottomAnchor, constant: topShift),
//					self.startDateTextField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: borderShift),
//					self.startDateTextField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -borderShift),
//					
//					self.finishDateLabel.topAnchor.constraint(equalTo: self.startDateTextField.bottomAnchor, constant: topShift+10),
//					self.finishDateLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: borderShift),
//					self.finishDateLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -borderShift),
//					self.finishDateTextField.topAnchor.constraint(equalTo: self.finishDateLabel.bottomAnchor, constant: topShift),
//					self.finishDateTextField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: borderShift),
//					self.finishDateTextField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -borderShift),
//					
//					self.pickerGroupLabel.topAnchor.constraint(equalTo: self.finishDateTextField.bottomAnchor, constant: topShift+10),
//					self.pickerGroupLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: borderShift),
//					self.pickerGroupLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -borderShift),
//					
//					self.pickerGroupTextField.topAnchor.constraint(equalTo: self.pickerGroupLabel.bottomAnchor, constant: topShift),
//					self.pickerGroupTextField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: borderShift),
//					self.pickerGroupTextField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -borderShift),
//					
//					self.startButton.topAnchor.constraint(equalTo: self.pickerGroupTextField.bottomAnchor, constant: topShift+10),
//					self.startButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
//					self.startButton.heightAnchor.constraint(equalToConstant: 40),
//					self.startButton.widthAnchor.constraint(equalToConstant: 200)
//				]
//			)
//		}
//		
//	}
//	
//	@objc func donePicker()
//	{
//		pickerGroupTextField.resignFirstResponder()
//		finishDateTextField.resignFirstResponder()
//		startDateTextField.resignFirstResponder()
//	}
//	
//	func createLabel() -> UILabel
//	{
//		let label = UILabel()
//		label.numberOfLines = 0
//		label.isUserInteractionEnabled = false
//		label.translatesAutoresizingMaskIntoConstraints = false
//		label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
//		label.textColor = .black
//		label.textAlignment = .center
//		return label
//	}
//	
//	func createDatePicker() -> UIDatePicker
//	{
//		let pickerView = UIDatePicker()
//		pickerView.backgroundColor = .white
//		pickerView.translatesAutoresizingMaskIntoConstraints = false
//		pickerView.locale = Locale(identifier: "ru_RU")
//		return pickerView
//	}
//	
//	func createPickerGroupTextField(placeholder: String) -> UITextField
//	{
//		let toolBar = UIToolbar()
//		toolBar.barStyle = UIBarStyle.default
//		toolBar.isTranslucent = true
//		toolBar.tintColor = UIColor.myBlueColor
//		toolBar.sizeToFit()
//		
//		let doneButton = UIBarButtonItem(title: "Готово", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.donePicker))
//		toolBar.setItems([doneButton], animated: false)
//		toolBar.isUserInteractionEnabled = true
//
//		let pickerTextField = UITextField()
//		pickerTextField.translatesAutoresizingMaskIntoConstraints = false
//		pickerTextField.placeholder = placeholder
//		pickerTextField.inputAccessoryView = toolBar
//		pickerTextField.textAlignment = .center
//		return pickerTextField
//	}
//	
//	
//	func createStartButton() -> UIButton
//	{
//		let button = UIButton(type: .custom)
//		button.translatesAutoresizingMaskIntoConstraints = false
//		button.layer.cornerRadius = 10.0
//		return button
//	}
//	
//	
//	
//	var startTime: Date = Date()
//	var finishTime: Date = Date()
//	var timeGroupString: String = ""
//	
//	@objc func buttonPressed()
//	{
//		if (startTime < finishTime && timeGroupString != "")
//		{
//			//переход на след экран
//			let body = NetworkRequestBody(aggregatedPeriod: timeGroupString, timeFrom: startTime, timeTo: finishTime)
//			let vc = ChooseGraphViewController(body: body)
//			let backItem = UIBarButtonItem(title: "Назад", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
//			navigationItem.backBarButtonItem = backItem
//			self.navigationController?.pushViewController(vc, animated: true)
//		}
//	}
//	
//	
//
//	
//	@objc func updateStartDate()
//	{
//		let formatter = DateFormatter()
//		formatter.dateFormat = "yyyy-MM-dd HH:mm"
//		startTime = self.startDatePicker.date
//		self.startDateTextField.text = formatter.string(from: self.startDatePicker.date)
//	}
//	
//	@objc func updateFinishDate()
//	{
//		let formatter = DateFormatter()
//		formatter.dateFormat = "yyyy-MM-dd HH:mm"
//		finishTime = self.finishDatePicker.date
//		self.finishDateTextField.text = formatter.string(from: self.finishDatePicker.date)
//	}
//	
//	override func viewWillAppear(_ animated: Bool) {
//		
//		self.title = "ClickHouse"
//		super.viewWillAppear(animated)
//		
//	}
//	
//}
//
////pickerviewdelegate
//extension StartViewController
//{
//	// Sets number of columns in picker view
//	func numberOfComponents(in pickerView: UIPickerView) -> Int {
//		return 1
//	}
//	
//	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//		return salutations.count
//	}
//	
//	
//	// This function sets the text of the picker view to the content of the "salutations" array
//	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//		return salutations[row].timeForUser
//	}
//	
//	// When user selects an option, this function will set the text of the text field to reflect
//	// the selected option.
//	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//		pickerGroupTextField.text = salutations[row].timeForUser
//		timeGroupString = salutations[row].timeForRequest
//	}
//}
