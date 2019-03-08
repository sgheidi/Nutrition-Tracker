//
//  FoodItemNutrient.swift
//  NutritionTracker
//
//  Created by alc29 on 2018-07-01.
//  Copyright © 2018 alc29. All rights reserved.
//
//	Represents the amount of a specific nutrient within a specific food.

import Foundation
import RealmSwift

class FoodItemNutrient: Object {
	// MARK: Properties
	@objc private dynamic var nutrientId: Int = -1
	@objc private dynamic var amount: Float = Float(-1)
	@objc private dynamic var unit: String = "uninitialized"
	@objc private dynamic var perAmount: Float = Float(-1)
	@objc private dynamic var perUnit: String = "g"
	let measures = List<Measure>()

	convenience init(_ nutrientId: Int, _ amount: Float, _ unit: String, _ perAmount: Float, _ perUnit: String) {
		self.init()
		self.nutrientId = nutrientId
		self.amount = amount
		self.unit = unit
		self.perAmount = perAmount
		self.perUnit = perUnit
	}
	
	func clone() -> FoodItemNutrient {
		return FoodItemNutrient(nutrientId, amount, unit, perAmount, perUnit)
	}
	
	// MARK: Setters
	//TODO
//	func setNutrient(_ nutrient: Nutrient) {
//		self.nutrient! = nutrient
//	}
//	func setBaseAmount(_ amount: Float) {
//		amountPer!.setBaseAmount(amount)
//	}
	
	// MARK: Getters
	func getNutrientId() -> Int { return nutrientId}
	func getAmount() -> Float { return amount }
	func getUnit() -> String { return unit }
	func getPerAmount() -> Float { return perAmount }
	func getPerUnit() -> String { return perUnit }
	
}
