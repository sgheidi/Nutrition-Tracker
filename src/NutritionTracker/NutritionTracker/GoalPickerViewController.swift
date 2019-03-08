//
//  GoalPickerViewController.swift
//  NutritionTracker
//
//  Created by Kainoa Seaman on 2018-07-28.
//  Copyright © 2018 alc29. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift
import Charts


class GoalPickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var nutrientPicker: UIPickerView!
	
    let NUTRIENT = 0
    let AMOUNT = 1
    let UNIT = 2
    let rowSize = [200 ,100, 47]
	
	var nutrients = [Nutrient]()
    var pickerData: [[String]] = [[],[],[]]
    var currentValue = [String](repeating: "", count: 3)
	var currentNutrient = Nutrient.Nil
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.nutrientPicker.delegate = self
		self.nutrientPicker.dataSource = self
		initPicker()
	}
	
    func initPicker() {
        nutrientPicker.layer.borderColor = UIColor.black.cgColor
        nutrientPicker.layer.borderWidth = 1
		
        // Set units
        pickerData[UNIT].append(Unit.G.rawValue)
        pickerData[UNIT].append(Unit.MG.rawValue)
        
        //set amunts
        for i in 1...100 {
            let value = i * 10
            pickerData[AMOUNT].append(String(Int(value)))
        }
        
        // set nutrients
		var n = 0
        for (id, nutrient) in Nutrient.dict {
            if (id != -1 && id != -2) {
				n += 1
                nutrients.append(nutrient)
				pickerData[NUTRIENT].append(nutrient.name)
            }
        }
        
		
        //init current values of picker
        for i in 0...2 {
            currentValue[i] = pickerData[i][0]
        }
		currentNutrient = nutrients[0]
		
		self.reloadInputViews()
		nutrientPicker.reloadAllComponents()
		
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[component][row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData[component].count
    }
    
    //called when picker is changed
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		currentValue[component] = pickerData[component][row]
		currentNutrient = nutrients[component]
    }
	

    // return to MealBuilderViewController to save goal
    @IBAction func enterBtnPressed(_ sender: UIButton) {
		
		let id = currentNutrient.getId()
		let amount = Float(currentValue[AMOUNT])!
		let unit = currentValue[UNIT]
		let goalLine = GoalLine(id, amount, unit)
		
        saveGoalToRealm(goalLine)
        self.navigationController?.popViewController(animated: true)
    }
    
}

func saveGoalToRealm(_ goal: GoalLine) {
    DispatchQueue(label: "GoalPickerVC.saveGoalToRealm").async {
        autoreleasepool {
            let realm = try! Realm()
            try! realm.write {
                realm.add(goal)
            }
        }
    }
}
