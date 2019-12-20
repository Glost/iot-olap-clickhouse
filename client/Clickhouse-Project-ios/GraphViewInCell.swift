//
//  GraphViewInCell.swift
//  Clickhouse-Project-ios
//
//  Created by Александр Плесовских on 08/12/2019.
//  Copyright © 2019 Alex. All rights reserved.
//


import UIKit


class GraphViewInCell: UIView
{
	override init(frame: CGRect)
	{
		scrollView = UIScrollView(frame: .zero)
		super.init(frame: frame)
		
		scrollView.translatesAutoresizingMaskIntoConstraints = false
		//Внешнее вью в контенте
		self.addSubview(scrollView)
		//customViewConstraints
		NSLayoutConstraint.activate([
			scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
			scrollView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
			scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
			scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
			self.heightAnchor.constraint(equalToConstant: scrollViewHeight)
			])
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	var scrollView: UIScrollView
	private let leftShiftConst: CGFloat = 20
	private var leftShift: CGFloat = 20
	private let rightShift: CGFloat = 20
	private let defaultColumnWidth: CGFloat = 20
	private let maxColumnHeight: CGFloat = 250
	private let bottomShift: CGFloat = 20
	private let topShift: CGFloat = 25
	private let scrollViewHeight: CGFloat = 330
	let labelFont = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
	
	func clearBeforeReuse()
	{
		// деактивируем констрейнты
		NSLayoutConstraint.deactivate(self.scrollView.subviews.flatMap({ $0.constraints }))
		// Удаляем привязку к супервью
		scrollView.subviews.forEach({ $0.removeFromSuperview() })
		self.needsUpdateConstraints()
	}
	
	func setViewModel(dates: [Date], values:[CGFloat])
	{
		clearBeforeReuse()
		
		let leftLabels = calculateLeftBorderLabels(values: values)
		//Задаем правильную ширину скролл вью
		let scrollViewWidth = leftShift + CGFloat(values.count) * defaultColumnWidth + rightShift
		scrollView.contentSize = CGSize(width: scrollViewWidth, height: scrollViewHeight)
		//продолжаем
		for label in leftLabels
		{
			scrollView.addSubview(label)
		}
		
		let columns:[CGRect] = calculateColumns(values: values)
		for rect in columns
		{
			let view = UIView(frame: rect)
			view.translatesAutoresizingMaskIntoConstraints = false
			view.backgroundColor = UIColor.myBlueColor
			scrollView.addSubview(view)
		}
		
		let bottomLabels = calculateBottomLabels(dates: dates)
		for label in bottomLabels
		{
			scrollView.addSubview(label)
		}
		
		self.needsUpdateConstraints()
	}
	
	func calculateColumns(values:[CGFloat]) -> [CGRect]
	{
		let max = values.max()
		//сопоставим 0 с 0, а макс с максимальной высотой столбца (maxHeight)
		guard let maxValue = max else {
			return []
		}
		let coef = maxColumnHeight/maxValue;
		
		var rectArray:[CGRect] = []
		var currentX: CGFloat = leftShift
		for value in values
		{
			let height = value*coef
			let rect = CGRect(x: currentX+1,
							  y: topShift + maxColumnHeight - height,
							  width: defaultColumnWidth-1,
							  height: height)
			rectArray.append(rect)
			currentX += defaultColumnWidth
		}
		return rectArray;
	}

	func calculateBottomLabels(dates: [Date]) -> [UIView]
	{
		let formatter = DateFormatter()
		//"timestamp":"2019-12-01 17:00:00.000+0300",
		formatter.dateFormat = "HH:mm\ndd-MM"
		//formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
		
		var labels: [UIView] = []
		for index in dates.indices
		{
			if (index % 5 == 0)
			{
				//Здесь должен быть центр
				let centerOfLabel: CGFloat = CGFloat(index) * defaultColumnWidth + defaultColumnWidth/2 + leftShift
				//текст лейбла
				let stringDate = formatter.string(from: dates[index])
				//ширина и высота текста лейбла
				let textWidth = stringDate.width(withConstrainedHeight: 99999.0, font: labelFont)
				let textHeight = stringDate.height(withConstrainedWidth: textWidth, font: labelFont)
				
				let label = UILabel(frame: CGRect(x: 0, y: 0, width: textWidth, height: textHeight))
				label.numberOfLines = 2
				label.center = CGPoint(x: centerOfLabel,
									   y: topShift + maxColumnHeight + bottomShift + textHeight/2)
				label.text = stringDate
				label.textAlignment = .center
				label.font = labelFont
				labels.append(label)
				//И небольшой штрих от столбца вниз к подписи
				let viewWidth: CGFloat = 4.0
				let view = UIView(frame: CGRect(x: centerOfLabel-viewWidth/2,
												y:maxColumnHeight + topShift,
												width: viewWidth, height: bottomShift/2));
				view.backgroundColor = UIColor.gray;
				labels.append(view);
			}
		}
		return labels
	}
	
	func calculateLeftBorderLabels(values: [CGFloat]) -> [UIView]
	{
		guard let max = values.max() else {
			return []
		}
		var views: [UIView] = []
		//Самая широкая строка:
		let maxValueString = stringFromCGFloat(value: max)
		let textWidth = maxValueString.width(withConstrainedHeight: 99999.0, font: labelFont)
		leftShift = leftShiftConst + textWidth
		//Минимум
		views.append(contentsOf: createLabelWith(labelText: "0", shiftFromBottom: 0))
		//Максимум
		views.append(contentsOf: createLabelWith(labelText: stringFromCGFloat(value: max), shiftFromBottom: maxColumnHeight))
		//3 средних значения (1/4, 2/4, 3/4 от максимума)
		views.append(contentsOf: createLabelWith(labelText: stringFromCGFloat(value: max/2), shiftFromBottom: maxColumnHeight/2))
		views.append(contentsOf: createLabelWith(labelText: stringFromCGFloat(value: max/4), shiftFromBottom: maxColumnHeight/4))
		views.append(contentsOf: createLabelWith(labelText: stringFromCGFloat(value: max*3/4), shiftFromBottom: maxColumnHeight*3/4))
		return views
	}
	
	func createLabelWith(labelText: String, shiftFromBottom: CGFloat) -> [UIView]
	{
		var views: [UIView] = []
		//Здесь должен быть центр
		let centerOfLabel: CGFloat = leftShift/2
		//текст лейбла
		//ширина и высота текста лейбла
		let textWidth = labelText.width(withConstrainedHeight: 99999.0, font: labelFont)
		let textHeight = labelText.height(withConstrainedWidth: textWidth, font: labelFont)
		
		let label = UILabel(frame: CGRect(x: 0, y: 0, width: textWidth, height: textHeight))
		label.numberOfLines = 1
		label.center = CGPoint(x: centerOfLabel,
							   y: topShift + maxColumnHeight - textHeight/2 - shiftFromBottom)
		label.text = labelText
		label.textAlignment = .center
		label.font = labelFont
		views.append(label)
		//И небольшой штрих от столбца влево к подписи
		let viewHeight: CGFloat = 4.0
		let view = UIView(frame: CGRect(x:leftShift - bottomShift/2,
										y:topShift + maxColumnHeight - textHeight/2 - shiftFromBottom - viewHeight/2,
										width: bottomShift/2, height: viewHeight));
		view.backgroundColor = UIColor.gray;
		views.append(view);
		
		return views
	}
	
	func stringFromCGFloat(value: CGFloat) -> String
	{
		let formatter = NumberFormatter()
		formatter.numberStyle = .decimal
		formatter.minimumFractionDigits = 2
		formatter.maximumFractionDigits = 2
		let number = NSNumber(value: Float(value))
		return formatter.string(from: number) ?? ""
	}
}
