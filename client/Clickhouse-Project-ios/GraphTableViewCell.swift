//
//  GraphTableViewCell.swift
//  Clickhouse-Project-ios
//
//  Created by Александр Плесовских on 08/12/2019.
//  Copyright © 2019 Alex. All rights reserved.
//


import UIKit

//перечислены все поля, кроме date
enum GraphType: String
{
	case min
	case max
	case avg
	case median
	case variance
	case avg_rain
}

class GraphTableViewCell: UITableViewCell
{
	//вью для графика
	var customView: GraphViewInCell
	
	private let moduleTitleBorder: CGFloat = 8
	
	private let stackTopBorder: CGFloat = 13
	private let stackBottomBorder: CGFloat = 27
	private let stackLeftRightBorder: CGFloat = 21
	
	private let customLeftRightBorder: CGFloat = 15
	private let customTopBottomBorder: CGFloat = 10
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String!)
	{
		customView = GraphViewInCell(frame: .zero)
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		customView.translatesAutoresizingMaskIntoConstraints = false
		//Внешнее вью в контенте
		self.contentView.addSubview(customView)
		//customViewConstraints
		NSLayoutConstraint.activate([
			customView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 0),
			customView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 0),
			customView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -0),
			customView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -0)
			])
	}
	
	required init?(coder aDecoder: NSCoder) {
		return nil
	}
	
	func setViewModel(elements: [GraphElementProtocol], graphType: GraphType)
	{
		var timeArray: [Date] = []
		var valueArray: [CGFloat] = []
		for element in elements
		{
			valueArray.append(element.getValueForType(type: graphType))
			timeArray.append(element.getTimestamp())
		}
		
		//обновить модель
		self.customView.setViewModel(dates: timeArray, values: valueArray)
		//обновить констрейнты
		self.needsUpdateConstraints()
	}
}
