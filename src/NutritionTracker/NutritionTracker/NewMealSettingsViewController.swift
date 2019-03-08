//
//  NewMealSettingsViewController.swift
//  NutritionTracker
//
//  Created by alc29 on 2018-07-24.
//  Copyright © 2018 alc29. All rights reserved.
//

import UIKit
import RealmSwift

class NewMealSettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

	@IBOutlet weak var mealTableView: UITableView!
	@IBOutlet weak var saveMealButton: UIButton!
	@IBOutlet weak var datePicker: UIDatePicker!
	
	var mealBuilder: MealBuilderViewController?
	var meal = Meal()
	
	typealias CachedFoodItemCompletion = (_ cachedFoodItem: CachedFoodItem?) -> Void
	typealias BoolCompletion = (_ success: Bool) -> Void
	
    override func viewDidLoad() {
        super.viewDidLoad()

		self.navigationController!.popViewController(animated: true)
		
		saveMealButton.backgroundColor = UIColor.white
		
		mealTableView.delegate = self
		mealTableView.dataSource = self
		mealTableView.register(FoodItemPortionTableViewCell.classForCoder(), forCellReuseIdentifier: "Cell")
    }
	
	// return to MealBuilderViewController to save meal.
	@IBAction func saveMealButtonPressed(_ sender: UIButton) {
		self.navigationController?.popViewController(animated: true)
		meal.setDate(datePicker.date)
		mealBuilder?.onReturnFromSavedMeal()
		
		
	}
	
	
	// MARK: - Table View Delegate
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	// Return the number of cells to display
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return meal.count()
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let foodItem = meal.getFoodItems()[indexPath.row]
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "FoodItemPortionCell", for: indexPath) as! FoodItemPortionTableViewCell
		
		cell.foodItem = foodItem
		cell.initPicker()
		//cell.textLabel!.text = foodItem.getName()
		
		return cell
	}
	
	//cell selected
//	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//		if let indexPath = tableView.indexPathForSelectedRow {
//			let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FoodDetailView") as! FoodDetailViewController
//			vc.foodItem = meal.get(indexPath.row)!
//			self.navigationController?.pushViewController(vc, animated: true)
//		}
//	}
	
	//cell hight
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 100.0
	}
	
	// MARK: deleting cells
	func removeFromMeal(_ index: Int) {
		meal.remove(index)
		DispatchQueue.main.async {
			self.mealTableView.reloadData()
		}
		saveMealButton.isEnabled = meal.count() > 0
	}
	
	func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		let action = UIContextualAction(style: .destructive, title: "Delete", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
			self.removeFromMeal(indexPath.row)
			success(true)
		})
		return UISwipeActionsConfiguration(actions: [action])
	}
	func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		let action = UIContextualAction(style: .destructive, title: "Delete", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
			self.removeFromMeal(indexPath.row)
			success(true)
		})
		return UISwipeActionsConfiguration(actions: [action])
	}
	

}
