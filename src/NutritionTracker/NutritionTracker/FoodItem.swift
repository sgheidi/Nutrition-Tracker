//
//  FoodItem.swift
//  NutritionTracker
//
//  Created by alc29 on 2018-06-28.
//  Copyright © 2018 alc29. All rights reserved.
//
//	A class for representing a specific food.
//	Includes information about the amount of food,
//	as well as food's lookup id in the database.

/*
Since FoodItem is stored locally, variables must be initialized with default values.

*/
import Foundation
import RealmSwift

class FoodItem: Object {
	// MARK: Properties
	@objc private dynamic var id = UUID().uuidString
	@objc private dynamic var foodId = -1
	@objc private dynamic var name = "uninitialized"
	@objc private dynamic var amount: Float = Float(0)
	@objc private dynamic var unit: String = ""
	
	//Note: optional initializer FoodItem() works, but should be avoided.
	convenience init(_ foodId: Int, _ name: String, _ amount: Float = Float(0), _ unit: String = "g") {
		self.init()
		self.foodId = foodId
		self.name = name
		self.amount = amount
		self.unit = unit
	}
	
	// MARK: Setters
	func setAmount(_ amount: Float) {
		self.amount = amount
	}
	
	func setUnit(_ unit: String) {
		//TODO check for valid unit?
		self.unit = unit;
	}
	
//	//TODO consider moving to Database
//	// return the specified amount of nutrient contained in this food.
//	func getAmountOf(_ nutrient: Nutrient) -> Float {
//		//get nutrient amount info from cached food item in realm.
//
//		return Float(0)
//	}

	// MARK: Getters
	func getFoodId() -> Int { return foodId }
	func getName() -> String { return name }
	func getAmount() -> Float { return amount }
	func getUnit() -> String { return unit }
	
	
	//return the pid
	override static func primaryKey() -> String? {
		return "id";
	}
}
