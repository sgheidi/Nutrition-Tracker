//
//  MealBuilderTableViewCell.swift
//  NutritionTracker
//
//  Created by alc29 on 2018-07-07.
//  Copyright © 2018 alc29. All rights reserved.
//

import UIKit

class MealBuilderTableViewCell: UITableViewCell {

	var foodItem: FoodItem?
	
	init(_ foodItem: FoodItem) {
		super.init(style: UITableViewCellStyle.default, reuseIdentifier: "MealFoodItemCell")
		self.foodItem = foodItem
	}
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
		
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		
		// Configure the view for the selected state
	}
}
