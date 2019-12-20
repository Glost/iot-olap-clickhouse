//
//  TextFieldCell.swift
//  Clickhouse-Project-ios
//
//  Created by Александр Плесовских on 18/12/2019.
//  Copyright © 2019 Alex. All rights reserved.
//


import UIKit


class TextFieldCell: UITableViewCell
{
	var textField: UITextField
	
	private let leftRigthShift: CGFloat = 16
	private let topBottomShift: CGFloat = 10
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String!)
	{
		textField = UITextField()
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		textField = self.createTextFieldWithToolBar()
		textField.translatesAutoresizingMaskIntoConstraints = false
		textField.borderStyle = UITextField.BorderStyle.roundedRect
		//Внешнее вью в контенте
		self.contentView.addSubview(textField)
		
		NSLayoutConstraint.activate([
			textField.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: leftRigthShift),
			textField.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -leftRigthShift),
			textField.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: topBottomShift),
			textField.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -topBottomShift)
			])
		
		self.selectionStyle = .none
	}
	
	required init?(coder aDecoder: NSCoder) {
		return nil
	}
	
	func createTextFieldWithToolBar() -> UITextField
	{
		let toolBar = UIToolbar()
		toolBar.barStyle = UIBarStyle.default
		toolBar.isTranslucent = true
		toolBar.tintColor = UIColor.myBlueColor
		toolBar.sizeToFit()
		
		let doneButton = UIBarButtonItem(title: "Готово", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.donePressed))
		toolBar.setItems([doneButton], animated: false)
		toolBar.isUserInteractionEnabled = true
		
		let textField = UITextField()
		textField.translatesAutoresizingMaskIntoConstraints = false
		textField.inputAccessoryView = toolBar
		textField.textAlignment = .center
		return textField
	}
	
	@objc func donePressed()
	{
		self.textField.resignFirstResponder()
	}
}
