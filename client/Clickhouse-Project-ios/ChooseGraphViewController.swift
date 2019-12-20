//
//  TableViewGraph.swift
//  Clickhouse-Project-ios
//
//  Created by Александр Плесовских on 03/12/2019.
//  Copyright © 2019 Alex. All rights reserved.
//


import UIKit


class ChooseGraphViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
	private var tableView: UITableView!
	private let activityIndicator = UIActivityIndicatorView()
	private let operationQueue = OperationQueue()
	private var isSuccess: Bool = false
	private var requestTime: Int = 0
	private var graphs: AggregatedGraphModel!
	var body: NetworkRequestBody
	var placeHolder: String = "Выполнение запроса..."
	init(body: NetworkRequestBody) {
		self.body = body
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		
		prepareUIViews();
		setupLayout();
		
		let operation = NetworkOperation(body: self.body) { (response) in
			guard let response = response, response.is_success else
			{
				self.placeHolder = "Ошибка при выполнении запроса!"
				DispatchQueue.main.async {
					self.tableView.reloadData()
				}
				return
			}
			guard response.sensor_aggregated_values != nil else
			{
				self.placeHolder = "Нет данных для таких ограничений!"
				DispatchQueue.main.async {
					self.tableView.reloadData()
				}
				return
			}
			self.isSuccess = response.is_success
			self.requestTime = response.click_house_query_execution_time
			if let values = response.sensor_aggregated_values
			{
				if values.count > 0 && (values.first != nil)
				{
					self.graphs = values.first!.aggregated_values
				}
			}
			DispatchQueue.main.async {
				self.tableView.reloadData()
			}
		}
		operationQueue.addOperation(operation)
	}
	
	override func viewWillAppear(_ animated: Bool)
	{
		super.viewWillAppear(animated)
		self.title = "Просмотр данных"
		tableView.reloadData()
	}
}

//MARK: - PrepareUI and Layout
extension ChooseGraphViewController
{
	//Подготовка элементов UI экрана
	func prepareUIViews()
	{
		//Таблица
		tableView = UITableView(frame: self.view.bounds, style: .plain)
		tableView.backgroundColor = .white
		tableView.dataSource = self
		tableView.delegate = self
		tableView.tableFooterView = UIView()
		
		//Ячейки
		tableView.register(GraphTableViewCell.self, forCellReuseIdentifier: "graphCell")
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "textCell")
		
		//		tableView.sectionHeaderHeight = UITableView.automaticDimension
		//		tableView.estimatedSectionHeaderHeight = 25
		tableView.rowHeight = UITableView.automaticDimension
		tableView.estimatedRowHeight = 25
		self.view.addSubview(tableView)
	}
	
	//Устанавливает расположение элементов
	func setupLayout()
	{
		tableView.translatesAutoresizingMaskIntoConstraints = false
		
		let constraint = [
			tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
			tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
			tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
		]
		self.view.addConstraints(constraint)
		self.view.needsUpdateConstraints()
	}
}

//MARK: - TableViewDataSource
//Данные для таблицы
extension ChooseGraphViewController
{
	enum ParameterType {
		case air_temp, air_hum, wind, illumiance, rains, success, requestTime
	}
	//Возвращает тип ячейки в зависимости от секции
	func getParameterType(row: Int) -> ParameterType
	{
		switch row
		{
		case 0:
			return .success
		case 1:
			return .requestTime
		case 2:
			return .air_temp
		case 3:
			return .air_hum
		case 4:
			return .wind
		case 5:
			return .illumiance
		case 6:
			return .rains
		default:
			return .success
		}
	}
	
	//Количество секций
	func numberOfSections(in tableView: UITableView) -> Int
	{
		return 1;
	}
	
	//Количество ячеек в секции
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		return self.isSuccess ? 7 : 1
	}
	
	//Ячейки для элементов
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
	{
		let type = getParameterType(row: indexPath.row)
		var text: String = ""
		var accessoryType: UITableViewCell.AccessoryType = .none
		var selectionStyle: UITableViewCell.SelectionStyle = .none
		switch type
		{
		case .success:
			text = isSuccess ? "Данные успешно получены" : placeHolder //"Ошибка при получении данных"
		case .requestTime:
			text = "Время выполнения запроса: \(requestTime) миллисекунд"
		case .air_temp:
			text = "Температура воздуха (°C)"
			accessoryType = .disclosureIndicator
			selectionStyle = .default
		case .air_hum:
			text = "Влажность воздуха (%)"
			accessoryType = .disclosureIndicator
			selectionStyle = .default
		case .wind:
			text = "Скорость ветра (м/c)"
			accessoryType = .disclosureIndicator
			selectionStyle = .default
		case .illumiance:
			text = "Освещенность (лк)"
			accessoryType = .disclosureIndicator
			selectionStyle = .default
		case .rains:
			text = "Дождливость (кол-во дождей за период)"
			accessoryType = .disclosureIndicator
			selectionStyle = .default
		default:
			text = isSuccess ? "Данные успешно получены" : "Ошибка при получении данных"
		}
		return CellFactory.createPlainTextCell(tableView: tableView,
											   indexPath: indexPath,
											   text: text,
											   selectionStyle: selectionStyle,
											   accessoryType: accessoryType)
	}
}

//Делегат
extension ChooseGraphViewController
{
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let type = getParameterType(row: indexPath.row)
		var title = "";
		var graphModel: [GraphElementProtocol]
		switch type
		{
		case .air_temp:
			title = "Температура воздуха (°C)"
			graphModel = graphs.air_temperature
		case .air_hum:
			title = "Влажность воздуха (%)"
			graphModel = graphs.air_humidity
		case .wind:
			title = "Скорость ветра (м/c)"
			graphModel = graphs.wind_speed
		case .illumiance:
			title = "Освещенность (лк)"
			graphModel = graphs.illuminance
		case .rains:
			title = "Дождливость (кол-во дождей за период)"
			graphModel = graphs.avg_rains_values
		default:
			return
		}
		let backItem = UIBarButtonItem(title: "Назад", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
		navigationItem.backBarButtonItem = backItem
		let graphViewVC = ViewGraphViewController(graphModel: graphModel)
		graphViewVC.title = title
		self.navigationController?.pushViewController(graphViewVC, animated: true)
	}
}
