//
//  Nutrient.swift
//  NutritionTracker
//
//  Created by alc29 on 2018-06-30.
//  Copyright © 2018 alc29. All rights reserved.
//
// A Struct for representing a nutrient.
// Contains static instances of all possible nutrients.

import Foundation
import RealmSwift

class Nutrient: Object {
	// MARK: Properties
	@objc dynamic var nutrientId: Int = -1
	@objc dynamic var name: String = "nil"
	@objc dynamic var unit = Unit.IU.rawValue
	var unitEnum: Unit {
		get {
			return Unit(rawValue: unit)!
		}
		set {
			unit = newValue.rawValue
		}
	}
	
	convenience init(_ nutrientId: Int, _ name: String, _ unit: Unit) {
		self.init()
		self.nutrientId = nutrientId
		self.name = name
		self.unit = unit.rawValue
	}
	
	//TODO remove, or make properties private
	func getId() -> Int { return nutrientId }
	
	static func get(id: Int) -> Nutrient {
		let nutrient = Nutrient.dict[id]
		if nutrient != nil {
			return nutrient!
		}
		return Nutrient.Nil
	}
	
	//Static predefined Nutrients
	static let Water = Nutrient(255, "Water", Unit.GRAM)
	static let Energy_KCAL = Nutrient(208, "Energy", Unit.KCAL)
	static let Energy_KJ = Nutrient(268, "Energy", Unit.KJ)
	static let Protein = Nutrient(203, "Protein", Unit.GRAM)
	static let Total_lipid = Nutrient(204, "Total_lipid (fat)", Unit.GRAM)
	static let Ash = Nutrient(207, "Ash", Unit.GRAM)
	static let Carbohydrate = Nutrient(205, "Carbohydrate_by_difference", Unit.GRAM)
	static let Fiber_total_dietary = Nutrient(291, "Fiber_total_dietary", Unit.GRAM)
	static let Fiber_soluble = Nutrient(295, "Fiber_soluble", Unit.GRAM)
	static let Fiber_insoluble = Nutrient(297, "Fiber_insoluble", Unit.GRAM)
	static let Sugars_total = Nutrient(269, "Sugars_total", Unit.GRAM)
	static let Sugars_added = Nutrient(539, "Sugars_added", Unit.GRAM)
	static let Sucrose = Nutrient(210, "Sucrose", Unit.GRAM)
	static let Glucose = Nutrient(211, "Glucose (dextrose)", Unit.GRAM)
	static let Fructose = Nutrient(212, "Fructose", Unit.GRAM)
	static let Lactose = Nutrient(213, "Lactose", Unit.GRAM)
	static let Maltose = Nutrient(214, "Maltose", Unit.GRAM)
	static let Galactose = Nutrient(287, "Galactose", Unit.GRAM)
	static let Sugar_alcohols = Nutrient(299, "Sugar_alcohols", Unit.GRAM)
	static let Starch = Nutrient(209, "Starch", Unit.GRAM)
	static let Calcium = Nutrient(301, "Calcium", Unit.MILIGRAM)
	static let Iron = Nutrient(303, "Iron", Unit.MILIGRAM)
	static let Magnesium = Nutrient(304, "Magnesium", Unit.MILIGRAM)
	static let Phosphorus = Nutrient(305, "Phosphorus", Unit.MILIGRAM)
	static let Potassium = Nutrient(306, "Potassium", Unit.MILIGRAM)
	static let Sodium = Nutrient(307, "Sodium", Unit.MILIGRAM)
	static let Zinc = Nutrient(309, "Zinc", Unit.MILIGRAM)
	static let Copper = Nutrient(312, "Copper", Unit.MILIGRAM)
	static let Manganese = Nutrient(315, "Manganese", Unit.MILIGRAM)
	static let Selenium = Nutrient(317, "Selenium", Unit.MICROGRAM)
	static let Fluoride = Nutrient(313, "Fluoride", Unit.MICROGRAM)
	static let Iodine = Nutrient(314, "Iodine", Unit.IU)
	static let Vitamin = Nutrient(401, "Vitamin C", Unit.MILIGRAM)
	static let Thiamin = Nutrient(404, "Thiamin", Unit.MILIGRAM)
	static let Riboflavin = Nutrient(405, "Riboflavin", Unit.MILIGRAM)
	static let Niacin = Nutrient(406, "Niacin", Unit.MILIGRAM)
	static let Pantothenic = Nutrient(410, "Pantothenic acid", Unit.MILIGRAM)
	static let VitaminB6 = Nutrient(415, "VitaminB6", Unit.MILIGRAM)
	static let Folate_total = Nutrient(417, "Folate_total", Unit.MICROGRAM)
	static let Folic_acid = Nutrient(431, "Folic_acid", Unit.MICROGRAM)
	static let Folate_food = Nutrient(432, "Folate_food", Unit.MICROGRAM)
	static let Folate_DFE = Nutrient(435, "Folate_DFE", Unit.MICROGRAM)
	static let Choline_total = Nutrient(421, "Choline_total", Unit.MILIGRAM)
	static let Betaine = Nutrient(454, "Betaine", Unit.MILIGRAM)
	static let VitaminB12 = Nutrient(418, "VitaminB12", Unit.MICROGRAM)
	static let VitaminB12_added = Nutrient(578, "VitaminB12_added", Unit.MICROGRAM)
	static let Biotin = Nutrient(416, "Biotin", Unit.IU)
	static let VitaminA_RAE = Nutrient(320, "VitaminA_RAE", Unit.MICROGRAM)
	static let Retinol = Nutrient(319, "Retinol", Unit.MICROGRAM)
	static let Carotene_beta = Nutrient(321, "Carotene_beta", Unit.MICROGRAM)
	static let Carotene_alpha = Nutrient(322, "Carotene_alpha", Unit.MICROGRAM)
	static let Cryptoxanthin_beta = Nutrient(334, "Cryptoxanthin_beta", Unit.MICROGRAM)
	static let VitaminA_IU = Nutrient(318, "VitaminA_IU", Unit.IU)
	static let Lycopene = Nutrient(337, "Lycopene", Unit.MICROGRAM)
	static let Lutein_and_zeaxanthin = Nutrient(338, "Lutein_and_zeaxanthin", Unit.MICROGRAM)
	static let VitaminE = Nutrient(323, "VitaminE_alpha_tocopherol", Unit.MILIGRAM)
	static let VitaminE_added = Nutrient(573, "VitaminE_added", Unit.MILIGRAM)
	static let Tocopherol_beta = Nutrient(341, "Tocopherol_beta", Unit.MILIGRAM)
	static let Tocopherol_gamma = Nutrient(342, "Tocopherol_gamma", Unit.MILIGRAM)
	static let Tocopherol_delta = Nutrient(343, "Tocopherol_delta", Unit.MILIGRAM)
	static let Tocotrienol_alpha = Nutrient(344, "Tocotrienol_alpha", Unit.MILIGRAM)
	static let Tocotrienol_beta = Nutrient(345, "Tocotrienol_beta", Unit.MILIGRAM)
	static let Tocotrienol_gamma = Nutrient(346, "Tocotrienol_gamma", Unit.MILIGRAM)
	static let Tocotrienol_delta = Nutrient(347, "Tocotrienol_delta", Unit.MILIGRAM)
	static let Vitamin_D_D2_and_D3 = Nutrient(328, "Vitamin_D_D2_and_D3", Unit.MICROGRAM)
	static let Vitamin_D2_ergocalciferol = Nutrient(325, "Vitamin_D2_ergocalciferol", Unit.MICROGRAM)
	static let Vitamin_D3_cholecalciferol = Nutrient(326, "Vitamin_D3_cholecalciferol", Unit.MICROGRAM)
	static let Vitamin_D = Nutrient(324, "Vitamin_D", Unit.IU)
	static let Vitamin_K_phylloquinone = Nutrient(430, "Vitamin_K_phylloquinone", Unit.MICROGRAM)
	static let Dihydrophylloquinone = Nutrient(429, "Dihydrophylloquinone", Unit.MICROGRAM)
	static let Menaquinone_4 = Nutrient(428, "Menaquinone_4", Unit.MICROGRAM)
	static let Fatty_acids_total_saturated = Nutrient(606, "Fatty_acids_total_saturated", Unit.GRAM)
	static let Fatty_acids_total_monounsaturated = Nutrient(645, "Fatty_acids_total_monounsaturated", Unit.GRAM)
	static let Fatty_acids_total_polyunsaturated = Nutrient(646, "Fatty_acids_total_polyunsaturated", Unit.GRAM)
	static let Fatty_acids_total_trans = Nutrient(605, "Fatty_acids_total_trans", Unit.GRAM)
	static let Fatty_acids_total_trans_monoenoic = Nutrient(693, "Fatty_acids_total_trans_monoenoic", Unit.GRAM)
	static let Fatty_acids_total_trans_polyenoic = Nutrient(695, "Fatty_acids_total_trans_polyenoic", Unit.GRAM)
	static let Cholesterol = Nutrient(601, "Cholesterol", Unit.MILIGRAM)
	static let Phytosterols = Nutrient(636, "Phytosterols", Unit.MILIGRAM)
	static let Stigmasterol = Nutrient(638, "Stigmasterol", Unit.MILIGRAM)
	static let Campesterol = Nutrient(639, "Campesterol", Unit.MILIGRAM)
	static let Beta_sitosterol = Nutrient(641, "Beta_sitosterol", Unit.MILIGRAM)
	static let Tryptophan = Nutrient(501, "Tryptophan", Unit.GRAM)
	static let Threonine = Nutrient(502, "Threonine", Unit.GRAM)
	static let Isoleucine = Nutrient(503, "Isoleucine", Unit.GRAM)
	static let Leucine = Nutrient(504, "Leucine", Unit.GRAM)
	static let Lysine = Nutrient(505, "Lysine", Unit.GRAM)
	static let Methionine = Nutrient(506, "Methionine", Unit.GRAM)
	static let Cystine = Nutrient(507, "Cystine", Unit.GRAM)
	static let Phenylalanine = Nutrient(508, "Phenylalanine", Unit.GRAM)
	static let Tyrosine = Nutrient(509, "Tyrosine", Unit.GRAM)
	static let Valine = Nutrient(510, "Valine", Unit.GRAM)
	static let Arginine = Nutrient(511, "Arginine", Unit.GRAM)
	static let Histidine = Nutrient(512, "Histidine", Unit.GRAM)
	static let Alanine = Nutrient(513, "Alanine", Unit.GRAM)
	static let Aspartic_acid = Nutrient(514, "Aspartic_acid", Unit.GRAM)
	static let Glutamic_acid = Nutrient(515, "Glutamic_acid", Unit.GRAM)
	static let Glycine = Nutrient(516, "Glycine", Unit.GRAM)
	static let Proline = Nutrient(517, "Proline", Unit.GRAM)
	static let Serine = Nutrient(518, "Serine", Unit.GRAM)
	static let Hydroxyproline = Nutrient(521, "Hydroxyproline", Unit.GRAM)
	static let Alcohol_ethyl = Nutrient(221, "Alcohol_ethyl", Unit.GRAM)
	static let Caffeine = Nutrient(262, "Caffeine", Unit.MILIGRAM)
	static let Theobromine = Nutrient(263, "Theobromine", Unit.MILIGRAM)
	
	static let Test = Nutrient(-1, "Test Nutrient", Unit.IU)
	static let Nil = Nutrient(-2, "Nil", Unit.IU)
	
	static let dict = [
		255 : Nutrient.Water,
		208 : Nutrient.Energy_KCAL,
		268 : Nutrient.Energy_KJ,
		203 : Nutrient.Protein,
		204 : Nutrient.Total_lipid,
		207 : Nutrient.Ash,
		205 : Nutrient.Carbohydrate,
		291 : Nutrient.Fiber_total_dietary,
		295 : Nutrient.Fiber_soluble,
		297 : Nutrient.Fiber_insoluble,
		269 : Nutrient.Sugars_total,
		539 : Nutrient.Sugars_added,
		210 : Nutrient.Sucrose,
		211 : Nutrient.Glucose,
		212 : Nutrient.Fructose,
		213 : Nutrient.Lactose,
		214 : Nutrient.Maltose,
		287 : Nutrient.Galactose,
		299 : Nutrient.Sugar_alcohols,
		209 : Nutrient.Starch,
		301 : Nutrient.Calcium,
		303 : Nutrient.Iron,
		304 : Nutrient.Magnesium,
		305 : Nutrient.Phosphorus,
		306 : Nutrient.Potassium,
		307 : Nutrient.Sodium,
		309 : Nutrient.Zinc,
		312 : Nutrient.Copper,
		315 : Nutrient.Manganese,
		317 : Nutrient.Selenium,
		313 : Nutrient.Fluoride,
		314 : Nutrient.Iodine,
		401 : Nutrient.Vitamin,
		404 : Nutrient.Thiamin,
		405 : Nutrient.Riboflavin,
		406 : Nutrient.Niacin,
		410 : Nutrient.Pantothenic,
		415 : Nutrient.VitaminB6,
		417 : Nutrient.Folate_total,
		431 : Nutrient.Folic_acid,
		432 : Nutrient.Folate_food,
		435 : Nutrient.Folate_DFE,
		421 : Nutrient.Choline_total,
		454 : Nutrient.Betaine,
		418 : Nutrient.VitaminB12,
		578 : Nutrient.VitaminB12_added,
		416 : Nutrient.Biotin,
		320 : Nutrient.VitaminA_RAE,
		319 : Nutrient.Retinol,
		321 : Nutrient.Carotene_beta,
		322 : Nutrient.Carotene_alpha,
		334 : Nutrient.Cryptoxanthin_beta,
		318 : Nutrient.VitaminA_IU,
		337 : Nutrient.Lycopene,
		338 : Nutrient.Lutein_and_zeaxanthin,
		323 : Nutrient.VitaminE,
		573 : Nutrient.VitaminE_added,
		341 : Nutrient.Tocopherol_beta,
		342 : Nutrient.Tocopherol_gamma,
		343 : Nutrient.Tocopherol_delta,
		344 : Nutrient.Tocotrienol_alpha,
		345 : Nutrient.Tocotrienol_beta,
		346 : Nutrient.Tocotrienol_gamma,
		347 : Nutrient.Tocotrienol_delta,
		328 : Nutrient.Vitamin_D_D2_and_D3,
		325 : Nutrient.Vitamin_D2_ergocalciferol,
		326 : Nutrient.Vitamin_D3_cholecalciferol,
		324 : Nutrient.Vitamin_D,
		430 : Nutrient.Vitamin_K_phylloquinone,
		429 : Nutrient.Dihydrophylloquinone,
		428 : Nutrient.Menaquinone_4,
		606 : Nutrient.Fatty_acids_total_saturated,
		645 : Nutrient.Fatty_acids_total_monounsaturated,
		646 : Nutrient.Fatty_acids_total_polyunsaturated,
		605 : Nutrient.Fatty_acids_total_trans,
		693 : Nutrient.Fatty_acids_total_trans_monoenoic,
		695 : Nutrient.Fatty_acids_total_trans_polyenoic,
		601 : Nutrient.Cholesterol,
		636 : Nutrient.Phytosterols,
		638 : Nutrient.Stigmasterol,
		639 : Nutrient.Campesterol,
		641 : Nutrient.Beta_sitosterol,
		501 : Nutrient.Tryptophan,
		502 : Nutrient.Threonine,
		503 : Nutrient.Isoleucine,
		504 : Nutrient.Leucine,
		505 : Nutrient.Lysine,
		506 : Nutrient.Methionine,
		507 : Nutrient.Cystine,
		508 : Nutrient.Phenylalanine,
		509 : Nutrient.Tyrosine,
		510 : Nutrient.Valine,
		511 : Nutrient.Arginine,
		512 : Nutrient.Histidine,
		513 : Nutrient.Alanine,
		514 : Nutrient.Aspartic_acid,
		515 : Nutrient.Glutamic_acid,
		516 : Nutrient.Glycine,
		517 : Nutrient.Proline,
		518 : Nutrient.Serine,
		521 : Nutrient.Hydroxyproline,
		221 : Nutrient.Alcohol_ethyl,
		262 : Nutrient.Caffeine,
		263 : Nutrient.Theobromine,
		-1 : Nutrient.Test,
		-2 : Nutrient.Nil
	]


	// Test nutrients
//	static let TestBitterNutrientA = Nutrient(276, "TestBitterNutrientA", Unit.MILIGRAM)
//	static let TestBitterNutrientB = Nutrient(277, "TestBitterNutrientB", Unit.MILIGRAM)
}
