//
//  Date+Extension.swift
//  Clickhouse-Project-ios
//
//  Created by Александр Плесовских on 08/12/2019.
//  Copyright © 2019 Alex. All rights reserved.
//


import Foundation


extension Date
{
	//удаляет точность даты до дней
	var zeroHours: Date {
		get {
			let calender = Calendar.current
			var dateComponents = calender.dateComponents([.year, .month, .day], from: self)
			dateComponents.timeZone = TimeZone(secondsFromGMT: 0)
			return calender.date(from: dateComponents)!
		}
	}
	//удаляет точность даты до недель
	var zeroWeek: Date {
		get {
			let calender = Calendar.current
			let dateComponents = calender.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)
			return calender.date(from: dateComponents)!
		}
	}
	//добавляет 1 день к дате
	var addOneDay: Date {
		get {
			return Calendar.current.date(byAdding: .day, value: 1, to: self)!
		}
	}
	//добавляет 1 неделю к дате
	var addOneWeek: Date {
		get {
			return Calendar.current.date(byAdding: .weekOfYear, value: 1, to: self)!
		}
	}
	//добавляет 1 месяц к дате
	var addOneMonth: Date {
		get {
			return Calendar.current.date(byAdding: .month, value: 1, to: self)!
		}
	}
	//добавляет 1 час к дате
	var addOneHour: Date {
		get {
			return Calendar.current.date(byAdding: .hour, value: 1, to: self)!
		}
	}
}
