//
//  FoodGroup.swift
//  NutritionTracker
//
//  Created by alc29 on 2018-07-02.
//  Copyright © 2018 alc29. All rights reserved.
//
// A struct for representing a food group
// Contains static instances of all possible food groups in the database.


import Foundation


struct FoodGroup {
	// MARK: Properties
	let id: Int
	let name: String
	
	init (_ id: Int, _ name: String) {
		self.id = id
		self.name = name
	}
	
	// Return the food group id as as string: must be 4 digits
	public func getIdStr() -> String {
		if (id <= 9) { // 1 digit
			return "0\(id)00"
		} else {
			return "\(id)00"
		}
	}
	
	//static predefined food groups
	//TODO convert id's to strings.
	//TODO format names, or write func to replace _ with spaces
	static let Dairy_and_Egg_Products = FoodGroup(1, "Dairy_and_Egg_Products") //0100
	static let American_Indian_Alaska_Native_Foods = FoodGroup(24, "American_Indian_Alaska_Native_Foods") //24
	static let Baby_Foods = FoodGroup(3, "Baby_Foods") //3
	static let Baked_Products = FoodGroup(18, "Baked_Products") //18
	static let Beef_Products = FoodGroup(13, "Beef_Products")
	static let Beverages = FoodGroup(14, "Beverages")
	static let Breakfast_Cereals = FoodGroup(8, "Breakfast_Cereals")
	static let Cereal_Grains_and_Pasta = FoodGroup(20, "Cereal_Grains_and_Pasta")
	static let Fast_Foods = FoodGroup(21, "Fast_Foods")
	static let Fats_and_Oils = FoodGroup(4, "Fats_and_Oils")
	static let Finfish_and_Shellfish_Products = FoodGroup(15, "Finfish_and_Shellfish_Products")
	static let Fruits_and_Fruit_Juices = FoodGroup(9, "Fruits_and_Fruit_Juices")
	static let Lamb_Veal_and_Game_Products = FoodGroup(17, "Lamb_Veal_and_Game_Products")
	static let Legumes_and_Legume_Products = FoodGroup(16, "Legumes_and_Legume_Products")
	static let Meals_Entrees_and_Side_Dishes = FoodGroup(22, "Meals_Entrees_and_Side_Dishes")
	static let Nut_and_Seed_Products = FoodGroup(12, "Nut_and_Seed_Products")
	static let Pork_Products = FoodGroup(10, "Pork_Products")
	static let Poultry_Products = FoodGroup(5, "Poultry_Products")
	static let Restaurant_Foods = FoodGroup(25, "Restaurant_Foods")
	static let Sausages_and_Luncheon_Meats = FoodGroup(7, "Sausages_and_Luncheon_Meats")
	static let Snacks = FoodGroup(23, "Snacks") //TODO 23
	static let Soups_Sauces_and_Gravies = FoodGroup(6, "Soups_Sauces_and_Gravies")
	static let Spices_and_Herbs = FoodGroup(2, "Spices_and_Herbs")
	static let Sweets = FoodGroup(19, "Sweets") //19
	//static let Vegetables_and_Vegetable_Products = FoodGroup(11, "Vegetables_and_Vegetable_Products")
	static let Vegetables = FoodGroup(11, "Vegetables")	
}




// Ver B
/*
struct FoodGroup {
	// MARK: Properties
	//	let id: Int
	let id: String
	let name: String

//	private init (_ id: Int, _ name: String) {
//		self.id = id
//		self.name = name
//	}

	private init (_ id: String, _ name: String) {
		self.id = id
		self.name = name
	}

// Return the food group id as as string: must be 4 digits
//	public func getIdStr() -> String {
//		if (id <= 9) { // 1 digit
//			return "0\(id)00"
//		} else {
//			return "\(id)00"
//		}
//	}

	public func getIdStr() -> String {
		return id
	}

	//static predefined food groups
	//TODO convert id's to strings.
	//TODO format names, or write func to replace _ with spaces
	static let Dairy_and_Egg_Products = FoodGroup("1", "Dairy_and_Egg_Products")
	static let American_Indian_Alaska_Native_Foods = FoodGroup("24", "American_Indian_Alaska_Native_Foods")
	static let Baby_Foods = FoodGroup("3", "Baby_Foods")
	static let Baked_Products = FoodGroup("18", "Baked_Products")
	static let Beef_Products = FoodGroup("13", "Beef_Products")
	static let Beverages = FoodGroup("14", "Beverages")
	static let Breakfast_Cereals = FoodGroup("8", "Breakfast_Cereals")
	static let Cereal_Grains_and_Pasta = FoodGroup("20", "Cereal_Grains_and_Pasta")
	static let Fast_Foods = FoodGroup("21", "Fast_Foods")
	static let Fats_and_Oils = FoodGroup("4", "Fats_and_Oils")
	static let Finfish_and_Shellfish_Products = FoodGroup("15", "Finfish_and_Shellfish_Products")
	static let Fruits_and_Fruit_Juices = FoodGroup("9", "Fruits_and_Fruit_Juices")
	static let Lamb_Veal_and_Game_Products = FoodGroup("17", "Lamb_Veal_and_Game_Products")
	static let Legumes_and_Legume_Products = FoodGroup("16", "Legumes_and_Legume_Products")
	static let Meals_Entrees_and_Side_Dishes = FoodGroup("22", "Meals_Entrees_and_Side_Dishes")
	static let Nut_and_Seed_Products = FoodGroup("12", "Nut_and_Seed_Products")
	static let Pork_Products = FoodGroup("10", "Pork_Products")
	static let Poultry_Products = FoodGroup("5", "Poultry_Products")
	static let Restaurant_Foods = FoodGroup("25", "Restaurant_Foods")
	static let Sausages_and_Luncheon_Meats = FoodGroup("7", "Sausages_and_Luncheon_Meats")
	static let Snacks = FoodGroup("23", "Snacks")
	static let Soups_Sauces_and_Gravies = FoodGroup("6", "Soups_Sauces_and_Gravies")
	static let Spices_and_Herbs = FoodGroup("2", "Spices_and_Herbs")
	static let Sweets = FoodGroup("19", "Sweets")
	static let Vegetables = FoodGroup("11", "Vegetables")
	//static let Vegetables_and_Vegetable_Products = FoodGroup(11, "Vegetables_and_Vegetable_Products")
}
*/

