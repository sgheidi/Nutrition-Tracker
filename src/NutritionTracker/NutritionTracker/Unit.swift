//
//  Unit.swift
//  NutritionTracker
//
//  Created by alc29 on 2018-06-29.
//  Copyright © 2018 alc29. All rights reserved.
//
//	An enum for representing all possible units of measurement.

import Foundation

enum Unit: String {
	case GRAM
	case MILIGRAM
	case MICROGRAM
	case IU //international unit
	case KJ
	case KCAL
	
	case G
	case MG
	
	static func get(_ rawValue: String) -> Unit? {
		var unit = Unit(rawValue: rawValue.uppercased())
		if unit == nil {
			return Unit.GRAM
		}
		return unit
	}
	
	static func getDefault() -> Unit {
		return Unit.GRAM
	}
}
