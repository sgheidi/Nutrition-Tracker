//
//  FoodReportV1.swift
//  NutritionTracker
//
//  Created by alc29 on 2018-07-14.
//  Copyright © 2018 alc29. All rights reserved.
//

import Foundation
import RealmSwift

/**
*/
class FoodReportV1 {
	// Not legacy
	struct Result: Decodable {
		let report: Report?
		
		struct Report: Decodable {
			let sr: String? // legacy or other
			let food: JFood?
		}
		
		struct JFood: Decodable {
			let ndbno: String?
			let name: String?
			let nutrients: [JNutrient?]?
		}
		struct JNutrient: Decodable {
			let nutrient_id: String?
			let name: String?
			let derivation: String?
			let group: String?
			let unit: String?
			let value: String?
			let measures: [JMeasure?]?
		}
		struct JMeasure: Decodable {
			let label: String?
			let eqv: Float?
			let eunit: String?
			//let qty: Int? //TODO
			let qty: Float?
			let value: String? //gram equivalent value of the measure
		}
	}
	
	
	//Legacy
	struct LegacyResult: Decodable {
		let report: Report?
		
		struct Report: Decodable {
			let sr: String? // legacy or other
			let food: JFood?
		}
		
		struct JFood: Decodable {
			let ndbno: String?
			let name: String?
			let sd: String?
			let fg: String?
			let nutrients: [JNutrient?]?
		}
		struct JNutrient: Decodable {
			let nutrient_id: Int?
			let name: String?
			let derivation: String?
			let group: String?
			let unit: String?
			let value: Float?
			let measures: [JMeasure?]?
		}
		struct JMeasure: Decodable {
			let label: String?
			let eqv: Float?
			let eunit: String?
			//let qty: Int? //TODO
			let qty: Float?
			let value: Float? //gram equivalent value of the measure
		}
		
	}
	
	
	//MARK: Properties
//	var jFoods = [Result.JFood]()
	var result: Any?
	var toCache: CachedFoodItem?
	
	//cache food items & nutrient data
	
	static func nonLegacyDecoder(_ jsonData: Data, _ debug: Bool = false) -> FoodReportV1? {
		do {
			let result = try JSONDecoder().decode(FoodReportV1.Result.self, from: jsonData)
			
			let foodReportV1 = FoodReportV1()
			foodReportV1.result = result
			
			// get nutrients from jFood, convert to FoodItemNutrient; add to food item
			if let report = result.report,
				let jFood = report.food,
				let ndbno = jFood.ndbno,
				let foodId = Int(ndbno) {
				
				//let cachedFoodItem = CachedFoodItem(foodId)
				var nutrients = [FoodItemNutrient]()
				
				if let jNutrients = jFood.nutrients {
					for jNutrient in jNutrients {
						guard let jNutrient = jNutrient, let nutrient_id = jNutrient.nutrient_id else { continue }
						
						//TODO delegate nutrientId getter to another function; refactor this block
						let nutrientId = Int(nutrient_id)!
						let nutrient = Nutrient.get(id: nutrientId)
						
						//TODO handle nil values; move definitions into the guard let statement
						let amountValue = jNutrient.value!
						let amountUnit = Unit.get(jNutrient.unit!)!
						let amount = Float(amountValue)!
						let unit = "g"
						let perAmount = Float(100)
						let perUnit = "g"
						
						let foodItemNutrient = FoodItemNutrient(nutrientId, amount, unit, perAmount, perUnit)
						
						//append each measure
						if let jNutrientMeasures = jNutrient.measures {
							for jMeasure in jNutrientMeasures {
								if let jMeasure = jMeasure {
									//TODO
									let m_label = jMeasure.label!
									let m_eqv = jMeasure.eqv!
									let m_eunit = jMeasure.eunit!
									let m_qty = jMeasure.qty!
									let m_value = jMeasure.value!
									let measure = Measure(m_label, m_eqv, m_eunit, m_qty, Float(m_value)!)
									foodItemNutrient.measures.append(measure)
								}
								
							}
						}
						
						// add nutrient
						nutrients.append(foodItemNutrient)
					}
				}
				
				foodReportV1.toCache = CachedFoodItem(foodId, nutrients)
			} else if debug {
				print("could not attache cache")
			}
			return foodReportV1
			
		} catch let error {
			print(error)
		}
		
		return nil
	}
	
	static func legacyDecoder(_ jsonData: Data, _ debug: Bool = false) -> FoodReportV1? {
		//Try decoding legacy
		do {
			if debug {print("entering legacy decode")}
			let result = try JSONDecoder().decode(FoodReportV1.LegacyResult.self, from: jsonData)
			let foodReportV1 = FoodReportV1()
			foodReportV1.result = result
			
			// get nutrients from jFood, convert to FoodItemNutrient; add to food item
			if let report = result.report,
				let jFood = report.food,
				let ndbno = jFood.ndbno,
				let foodId = Int(ndbno) {
				var nutrients = [FoodItemNutrient]()
				
				if let jNutrients = jFood.nutrients {
					for jNutrient in jNutrients {
						guard let jNutrient = jNutrient, let nutrient_id = jNutrient.nutrient_id else { continue }
						
						let amount = jNutrient.value!
						let unit = "g"
						let perAmount = Float(100)
						let perUnit = "g"
						
						let foodItemNutrient = FoodItemNutrient(nutrient_id, amount, unit, perAmount, perUnit)
						//append each measure
						if let jNutrientMeasures = jNutrient.measures {
							for jMeasure in jNutrientMeasures {
								if let jMeasure = jMeasure {
									//TODO
									let m_label = jMeasure.label!
									let m_eqv = jMeasure.eqv!
									let m_eunit = jMeasure.eunit!
									let m_qty = jMeasure.qty!
									let m_value = jMeasure.value!
									let measure = Measure(m_label, m_eqv, m_eunit, m_qty, m_value)
									foodItemNutrient.measures.append(measure)
								}
								
							}
						}
						
						// add nutrient
						nutrients.append(foodItemNutrient)
					}
				}
				
				foodReportV1.toCache = CachedFoodItem(foodId, nutrients)
			} else if debug {
				print("legacy: could not attach cache. ")
			}
			
			return foodReportV1
			
		} catch let error {
			print(error)
		}
		
		if debug {print("returning nil")}
		return nil
	}
	
	//TODO refactor
	static func fromJsonData(_ jsonData: Data, _ debug: Bool = false) -> FoodReportV1? {
		//structs
		struct LegacyType: Decodable {
			let report: Report?
			
			struct Report: Decodable {
				let sr: String?
			}
		}
		
		do {
			let parsedResult = try JSONDecoder().decode(LegacyType.self, from: jsonData)
			guard let report = parsedResult.report else {
				if debug {
					print("parsedResult nil:)")
					Util.printJsonData(jsonData)
				}
				return nil
				
			}
			
			if let legacyType = report.sr {
				if legacyType == "Legacy" {
					if debug {print("decoding legacy")}
					return legacyDecoder(jsonData, debug)
				} else {
					if debug { print("decoding non legacy: \(legacyType)") }
					return nonLegacyDecoder(jsonData, debug)
				}
			} else {
				if debug { print("leagcyType failed") }
			}
		
			
		} catch let error {
			print(error)
		}
		
		if debug{ print("returning nil; never passed to decoder.") }
		return nil
	}
	
	
}


