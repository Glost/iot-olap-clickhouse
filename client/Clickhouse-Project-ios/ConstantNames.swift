//
//  ConstantNames.swift
//  Clickhouse-Project-ios
//
//  Created by Александр Плесовских on 17/12/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation

let textFieldDatePickerCellIdentifier = "textFieldDatePickerCellIdentifier"
let textFieldPickerCellIdentifier = "textFieldPickerCellIdentifier"
let textFieldNumberCellIdentifier = "textFieldNumberCellIdentifier"
let buttonCellIdentifier = "buttonCellIdentifier"

let labelFieldCellIdentifier = "labelFieldCellIdentifier"


//latitude_intervals - массив объектов типа CoordinateInterval для широты (в градусах), на которой расположен датчик - тип CoordinateInterval[] - необязательное (если null или не задано, то широта, на которой расположен датчик, не ограничивается)
let textFieldId_latitude_intervals_max = "latitude_intervals_max"
let textFieldId_latitude_intervals_min = "latitude_intervals_min"


//longitude_intervals - массив объектов типа CoordinateInterval для долготы (в градусах), на которой расположен датчик - тип CoordinateInterval[] - необязательное (если null или не задано, то долгота, на которой расположен датчик, не ограничивается)
let textFieldId_longitude_intervals_max = "longitude_intervals_max"
let textFieldId_longitude_intervals_min = "longitude_intervals_min"


//altitude_intervals - массив объектов типа CoordinateInterval для высоты над уровнем моря (в метрах), на которой расположен датчик - тип CoordinateInterval[] - необязательное (если null или не задано, то высота над уровнем моря, на которой расположен датчик, не ограничивается)
let textFieldId_altitude_intervals_max = "altitude_intervals_max"
let textFieldId_altitude_intervals_min = "altitude_intervals_min"


//aggregated_period - период времени, по которому производится агрегация данных - тип AggregatedPeriod (в JSON представлен как строка - String) - обязательное
let textFieldId_aggregated_period = "aggregated_period"


//timestamp_interval - объект типа TimestampInterval для времени произведения замера показаний на датчике - тип TimestampInterval - обязательное
let textFieldId_timestamp_interval_from = "timestamp_interval_from"
let textFieldId_timestamp_interval_to = "timestamp_interval_to"
