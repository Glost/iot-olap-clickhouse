//
//  String+Extension.swift
//  Clickhouse-Project-ios
//
//  Created by Александр Плесовских on 08/12/2019.
//  Copyright © 2019 Alex. All rights reserved.
//


import UIKit


extension String
{
	func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat
	{
		let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
		let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
		
		return ceil(boundingBox.height)
	}
	
	func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat
	{
		let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
		let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
		
		return ceil(boundingBox.width)
	}
}
