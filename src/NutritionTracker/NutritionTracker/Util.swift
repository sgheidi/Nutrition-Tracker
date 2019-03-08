//
//  Util.swift
//  NutritionTracker
//
//  Created by alc29 on 2018-07-14.
//  Copyright © 2018 alc29. All rights reserved.
//

import Foundation

class Util {
	static func dataToString(_ data: Data) -> String {
		return String(data: data, encoding: .utf8)!
	}
	
	static func printJsonData(_ data: Data) {
		print("*")
		print(String(data: data, encoding:String.Encoding.ascii)!)
		print("*")
	}
	
	//re-add the leading zero's to food id's of length < 5.
	static func getProperFoodIdStr(_ foodId: Int) -> String {
		var foodIdStr = String(foodId)
		while foodIdStr.count < 5 { //TODO magic num
			//prefix with a zero
			foodIdStr = "0" + foodIdStr
		}
		return foodIdStr
	}
}
