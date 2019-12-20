//
//  ViewGraphViewController.swift
//  Clickhouse-Project-ios
//
//  Created by Александр Плесовских on 08/12/2019.
//  Copyright © 2019 Alex. All rights reserved.
//


import UIKit


class ViewGraphViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
	private var tableView: UITableView!
	
	private var graphModel: [GraphElementProtocol]

	init(graphModel: [GraphElementProtocol])
	{
		self.graphModel = graphModel
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
	}
	
	override func viewWillAppear(_ animated: Bool)
	{
		super.viewWillAppear(animated)
		tableView.reloadData()
	}
}

//MARK: - PrepareUI and Layout
extension ViewGraphViewController
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
extension ViewGraphViewController
{
	//Возвращает тип ячейки в зависимости от секции
	func getGraphType(row: Int) -> GraphType
	{
		switch row
		{
		case 0, 1:
			return .avg
		case 2, 3:
			return .min
		case 4, 5:
			return .max
		case 6, 7:
			return .median
		default:
			return .variance
		}
	}
	
	//Количество секций
	func numberOfSections(in tableView: UITableView) -> Int
	{
		return 1
	}
	
	func isAvgRainGraph() -> Bool
	{
		return graphModel.first is GraphElementModelAvgRain
	}
	
	//Количество ячеек в секции
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		if (isAvgRainGraph())
		{
			return 2
		}
		else {
			return 10
		}
	}
	
	//Ячейки для элементов
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
	{
		if (isAvgRainGraph())
		{
			if (indexPath.row % 2 == 0)
			{
				let text = "Средние значения"
				return CellFactory.createPlainTextCell(tableView: tableView,
													   indexPath: indexPath,
													   text: text,
													   selectionStyle: .none,
													   accessoryType: .none)
			}
			else
			{
				return CellFactory.createGraphCell(tableView: tableView,
												   identifier: "graphCell",
												   indexPath: indexPath,
												   viewModel: graphModel,
												   graphType: .avg_rain)
			}
		}
		else
		{
			let type = getGraphType(row: indexPath.row)
			if (indexPath.row % 2 == 0)
			{
				var text: String = ""
				switch type
				{
				case .avg:
					text = "Средние значения"
				case .min:
					text = "Минимальные значения"
				case .max:
					text = "Максимальные значения"
				case .median:
					text = "Медианные значения"
				default:
					text = "Отклонение"
				}
				return CellFactory.createPlainTextCell(tableView: tableView,
													   indexPath: indexPath,
													   text: text,
													   selectionStyle: .none,
													   accessoryType: .none)
			}
			else
			{
				return CellFactory.createGraphCell(tableView: tableView,
												   identifier: "graphCell",
												   indexPath: indexPath,
												   viewModel: graphModel,
												   graphType: type)
			}
		}
	}
}
