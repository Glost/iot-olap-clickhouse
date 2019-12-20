//
//  LabelFieldCell.swift
//  Clickhouse-Project-ios
//
//  Created by Александр Плесовских on 17/12/2019.
//  Copyright © 2019 Alex. All rights reserved.
//


import UIKit


class LabelFieldCell: UITableViewCell
{
	var label: UILabel
	
	private let leftRigthShift: CGFloat = 16
	private let topBottomShift: CGFloat = 10
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String!)
	{
		label = UILabel()
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		label = self.createLabel()
		//Внешнее вью в контенте
		self.contentView.addSubview(label)
		//customViewConstraints
		NSLayoutConstraint.activate([
			label.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: leftRigthShift),
			label.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: topBottomShift),
			label.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -topBottomShift),
			label.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -leftRigthShift)
			])
		self.isUserInteractionEnabled = false
	}
	
	required init?(coder aDecoder: NSCoder) {
		return nil
	}
	
	func createLabel() -> UILabel
	{
		let label = UILabel()
		label.numberOfLines = 0
		label.isUserInteractionEnabled = false
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = .black
		label.textAlignment = .left
		return label
	}
}

extension LabelFieldCell: CellProtocol
{
	func setFieldItem(item: ItemProtocol)
	{
		if (item is LabelFieldItem)
		{
			let labelFieldItem = item as! LabelFieldItem
			self.label.text = labelFieldItem.text
			self.label.font = labelFieldItem.font
		}
	}
	
	//Ничего не делать
	func updateValue(value: String) {}
}
