//
//  CellFactory.swift
//  Clickhouse-Project-ios
//
//  Created by Александр Плесовских on 03/12/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

import UIKit


//Класс - фабрика для ячеек таблиц (tableView)
class CellFactory
{
	//ячейка с графиком
	static func createGraphCell(tableView: UITableView, identifier: String, indexPath: IndexPath, viewModel:[GraphElementProtocol], graphType:GraphType) -> UITableViewCell
	{
		let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! GraphTableViewCell
		cell.setViewModel(elements: viewModel, graphType: graphType)
		
		cell.accessoryType = .none
		cell.selectionStyle = .none
		return cell
	}
	
	static func createPlainTextCell(tableView: UITableView, indexPath: IndexPath, text: String,
									selectionStyle: UITableViewCell.SelectionStyle,
									accessoryType: UITableViewCell.AccessoryType) -> UITableViewCell
	{
		//Создание ячейки
		let cell = tableView.dequeueReusableCell(withIdentifier: "textCell", for: indexPath)
		//Заполнение данных
		cell.textLabel?.text = text
		cell.textLabel?.numberOfLines = 0
		cell.textLabel?.textColor = UIColor.black
		cell.accessoryType = accessoryType
		cell.selectionStyle = selectionStyle
		return cell
	}
}
