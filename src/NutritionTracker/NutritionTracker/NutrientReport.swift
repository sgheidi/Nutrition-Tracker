//
//  NutrientReport.swift
//  NutritionTracker
//
//  Created by alc29 on 2018-07-15.
//  Copyright © 2018 alc29. All rights reserved.
//

import Foundation
import RealmSwift

/**
//Nutrient information about a food
Reference:
https://ndb.nal.usda.gov/ndb/doc/apilist/API-NUTRIENT-REPORT.md
*/
/*
class NutrientReport {
	
	//MARK: Json structs
	struct Result: Decodable {
		let report: Report?
	}
	struct Report: Decodable {
		let foods: [JFood]?
	}
	struct JFood: Decodable {
		let ndbno: String?
		let name: String?
		let weight: Float?
		let measure: String? //household measure represented by the nutrient value element
		let nutrients: [JNutrient]?
	}
	struct JNutrient: Decodable {
		let nutrient_id: String?
		let nutrient: String?
		let unit: String? //unit in which the nutrient value is expressed
		let value: String? //value of the nutrient for this food
		let gm: Float? //the 100 gram equivalent value for the nutrient
	}
	
	//MARK: Properties
	var foodId: Int = -1
	var foodItemNutrients = [FoodItemNutrient]()
	//let foodItemNutrients = List<FoodItemNutrient>()
	
	convenience init (_ foodId: Int, _ nutrients: [FoodItemNutrient]) {
		self.init()
		self.foodId = foodId
		self.foodItemNutrients.append(contentsOf: nutrients)
	}
	
	// MARK: public methods
	func contains(_ nutrient: Nutrient) -> Bool {
		//return foodItemNutrients.contains { n in nutrient.getId() == n.getNutrientId() }
		return false
	}
	
	func count() -> Int { return foodItemNutrients.count }
	func getFoodItemNutrients() -> [FoodItemNutrient] { return Array(foodItemNutrients) }
	
	//TODO use dictionary instead of for loop & test
	func getFoodItemNutrient(_ nutrient: Nutrient) -> FoodItemNutrient? {
		if !contains(nutrient) {
			return nil
		}
		for n in foodItemNutrients {
			if n.getNutrient().getId() == nutrient.getId() {
				return n
			}
		}
		return nil
	}
	
	//MARK: json Parsing
	
	//Factory method using json data
	static func fromJsonData(_ foodId: Int, _ jsonData: Data, _ debug: Bool = false) -> NutrientReport? {
		do {
			guard let result = try? JSONDecoder().decode(NutrientReport.Result.self, from: jsonData) else { print("json: result failed"); return nil }
			guard let report = result.report else { if debug {print("json: result.report failed")}; return nil }
			guard let foods = report.foods else { if debug {print("json: result.foods failed")}; return nil }
			guard let food = foods.first else { if debug{print("json: food.first failed")}; return nil }
			guard let jNutrients = food.nutrients else { if debug{print("json: food.nutrients failed")}; return nil }
			
			var nutrients = [FoodItemNutrient]()
			for jNut in jNutrients {
				if debug {print("nut: \(String(describing: jNut.nutrient))")}
				let foodItemNutrient = NutrientReport.jNutrientToFoodItemNutrient(jNut)
				nutrients.append(foodItemNutrient)
			}
			
			if debug { print("NutrientReport.fromJsonData: returning report") }
			return NutrientReport(foodId, nutrients)
			
		} catch let error {
			print(error)
		}
		if debug { print("NutrientReport.fromJsonData: returning nil") }
		return nil
	}
	
	//TODO
	private static func jNutrientToFoodItemNutrient(_ jNutrient: JNutrient) -> FoodItemNutrient {
		let nutrient = NutrientReport.jNutrientToNutrient(Int(jNutrient.nutrient_id!)!)
		let amountPer = AmountPer() //TODO
		return FoodItemNutrient(nutrient, amountPer)
	}
	
	private static func jNutrientToNutrient(_ id: Int) -> Nutrient {
		return Nutrient.get(id: id)
	}
}
*/
