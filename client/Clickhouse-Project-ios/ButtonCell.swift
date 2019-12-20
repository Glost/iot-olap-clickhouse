//
//  ButtonCell.swift
//  Clickhouse-Project-ios
//
//  Created by Александр Плесовских on 18/12/2019.
//  Copyright © 2019 Alex. All rights reserved.
//


import UIKit


class ButtonCell: UITableViewCell, CellProtocol
{
	var button: UIButton
	
	private let leftRigthShift: CGFloat = 16
	private let topBottomShift: CGFloat = 10
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String!)
	{
		button = UIButton()
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.layer.cornerRadius = 10
		button.backgroundColor = UIColor.myBlueColor
		//Внешнее вью в контенте
		self.contentView.addSubview(button)
		
		NSLayoutConstraint.activate([
			button.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: leftRigthShift),
			button.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -leftRigthShift),
			button.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: topBottomShift),
			button.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -topBottomShift)
			])
		
		//self.selectionStyle = .none
		//self.isUserInteractionEnabled = false
	}
	
	required init?(coder aDecoder: NSCoder) {
		return nil
	}
	
	//протокол
	func setFieldItem(item: ItemProtocol)
	{
		if (item is ButtonItem)
		{
			let buttonItem = item as! ButtonItem
			button.setTitle(buttonItem.buttonTitle, for: .normal)
			button.addTarget(buttonItem, action: #selector(buttonItem.buttonPressed), for: UIControl.Event.touchUpInside)
		}
	}
}
