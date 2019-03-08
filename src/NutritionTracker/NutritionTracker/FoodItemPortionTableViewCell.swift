//
//  FoodItemPortionTableViewCell.swift
//  NutritionTracker
//
//  Created by alc29 on 2018-07-24.
//  Copyright © 2018 alc29. All rights reserved.
//

import UIKit

class FoodItemPortionTableViewCell: UITableViewCell, UIPickerViewDelegate, UIPickerViewDataSource {

	@IBOutlet weak var picker: UIPickerView!
	@IBOutlet weak var foodNameLabel: UILabel!
	var foodItem: FoodItem?
	
	//unit, multiplier, scale
	let UNIT = 2
	let MULT = 0
	let SCALE = 1
	let rowSize = [47, 100, 47]
	var pickerData: [[String]] = [[],[],[]]
	var currentValue = [String](repeating:"", count: 3)
	
	// initialize picker values
	//NOTE: FoodItem must be assigned before this is invoked
	func initPicker() {
		picker.delegate = self
		picker.dataSource = self
		picker.layer.borderColor = UIColor.black.cgColor
		picker.layer.borderWidth = 1
		
		foodNameLabel.text = foodItem!.getName()
		self.backgroundColor = UIColor.white
		
		// Set units. TODO add other units
		pickerData[UNIT].append(Unit.G.rawValue)
		pickerData[UNIT].append(Unit.MG.rawValue)
		
		//set multipliers
		for i in 1...9 {
			pickerData[MULT].append(String(i))
		}
		
		//set scales
		for i in 2...4 {
			let power = pow(10, Float(i))
			pickerData[SCALE].append(String(Int(power)))
		}
		
		self.reloadInputViews()
		picker.reloadAllComponents()

		//init current values of picker
		for i in 0...2 {
			currentValue[i] = pickerData[i][0]
		}
		updateFoodItem()
	}

	// MARK: - UIPickerViewDataSource Delegate
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 3
	}
	
	// MARK: - UIPickerView Delegate
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return pickerData[component].count
	}
	
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		if component == MULT {
			return "\(pickerData[component][row])x"
		} else {
			return pickerData[component][row]
		}
	}

	//set component width
	func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
		return CGFloat(rowSize[component])
	}
	
	//update food item amount when row is selected
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		currentValue[component] = pickerData[component][row]
		updateFoodItem()
	}
	
	func updateFoodItem() {
		let mult = Float(currentValue[MULT])!
		let scale = Float(currentValue[SCALE])!
		let unit = currentValue[UNIT]
		
		let amount = Float(mult * scale)
		foodItem!.setAmount(amount)
		foodItem!.setUnit(unit)
	}
	
//	//uncomment to set row height
//	func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
//		return 20.0
//	}


//	override func setSelected(_ selected: Bool, animated: Bool) {
//		print("set selected")
//	}
//
//	override func setHighlighted(_ highlighted: Bool, animated: Bool) {
//		print("set hilighted")
//	}
	
}
