//
//  MealBuilderViewController.swift
//  NutritionTracker
//
//  Created by alc29 on 2018-06-30.
//  Copyright © 2018 alc29. All rights reserved.
//

import UIKit
import RealmSwift
import FirebaseDatabase

protocol FoodSelector {
	func addFood(foodItem: FoodItem)
}

/*
LEFT OFF HERE
move saveMeal functionality to other view
on save meal, return to meal builder; display mealSaved alert
*/

class MealBuilderViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, FoodSelector {
	// MARK: Properties
	@IBOutlet weak var mealTableView: UITableView!
	@IBOutlet weak var saveMealButton: UIButton!
	@IBOutlet weak var buttonStack: UIStackView!
	static var testInit = false; //TEST NOTE: set to true to add sample items
	var meal = Meal()

	var mealSavedAlertPopup:UIView?
	var mealSavedAlertLabel:UILabel = UILabel(frame: CGRect(x:100, y:400, width:200, height:50))

	typealias CachedFoodItemCompletion = (_ cachedFoodItem: CachedFoodItem?) -> Void
	typealias BoolCompletion = (_ success: Bool) -> Void
	
	
	
	// MARK: - VC Methods
    override func viewDidLoad() {
        super.viewDidLoad()

		//format buttons
		for button in buttonStack.arrangedSubviews {
			button.backgroundColor = UIColor.white
		}
		saveMealButton.backgroundColor = UIColor.white
		
		mealSavedAlertLabel.text = "Meal Saved"
		//mealSavedAlertLabel.isHidden = true
		mealSavedAlertLabel.alpha = 0
		mealSavedAlertLabel.isUserInteractionEnabled = false
		mealSavedAlertLabel.backgroundColor = UIColor.black
		mealSavedAlertLabel.textColor = UIColor.white
		mealSavedAlertLabel.textAlignment = NSTextAlignment.center
		mealSavedAlertLabel.layer.cornerRadius = 4.0
		mealSavedAlertLabel.layer.masksToBounds = true
		self.view.addSubview(mealSavedAlertLabel)
		
		mealTableView.delegate = self
		mealTableView.dataSource = self
		mealTableView.register(MealBuilderTableViewCell.classForCoder(), forCellReuseIdentifier: "Cell")

		// sample food items for testing
		if MealBuilderViewController.testInit {
			meal.add(FoodItem(45144608, "Poop candy", 0, "g"))
			meal.add(FoodItem(11683, "Carot"))
			MealBuilderViewController.testInit = false;
		}
		asyncReloadData()
		saveMealButton.isEnabled = meal.count() > 0
	}
	
	//deselect selected cell, on returning to this view.
	override func viewWillAppear(_ animated: Bool) {
		if let selectionIndexPath = mealTableView.indexPathForSelectedRow {
			mealTableView.deselectRow(at: selectionIndexPath, animated: animated)
		}
		super.viewWillAppear(animated)
	}
	
	//MARK: - Actions

	@IBAction func catalogButtonPressed(_ sender: UIButton) {
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let vc = CategoryTableViewController()
		
		let foodListTableVC = storyboard.instantiateViewController(withIdentifier: "FoodListTableViewController") as! FoodListTableViewController
		
		let foodDetailView = storyboard.instantiateViewController(withIdentifier: "FoodDetailView") as! FoodDetailViewController
		let addButton = UIBarButtonItem(title: "Add", style: .plain, target: foodDetailView, action: #selector(foodDetailView.addButtonPressed(sender:)))
		foodDetailView.navigationItem.rightBarButtonItem = addButton
		foodDetailView.foodSelector = self
		
		foodListTableVC.foodDetailView = foodDetailView
		
		vc.foodListTableVC = foodListTableVC
		
		self.navigationController?.pushViewController(vc, animated: true)
	}
	
	@IBAction func foodSearchButtonPressed(_ sender: UIButton) {
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let foodDetailView = storyboard.instantiateViewController(withIdentifier: "FoodDetailView") as! FoodDetailViewController
		let vc = storyboard.instantiateViewController(withIdentifier: "FoodSearchView") as! FoodSearchViewController
		vc.foodDetailViewController = foodDetailView
		
		let addButton = UIBarButtonItem(title: "Add", style: .plain, target: foodDetailView, action: #selector(foodDetailView.addButtonPressed(sender:)))
		foodDetailView.navigationItem.rightBarButtonItem = addButton
		foodDetailView.foodSelector = self
		
		self.navigationController?.pushViewController(vc, animated: true)
	}
    
    @IBAction func visionButtonPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let foodDetailView = storyboard.instantiateViewController(withIdentifier: "FoodDetailView") as! FoodDetailViewController
		
		let addButton = UIBarButtonItem(title: "Add", style: .plain, target: foodDetailView, action: #selector(foodDetailView.addButtonPressed(sender:)))
        foodDetailView.navigationItem.rightBarButtonItem = addButton
        foodDetailView.foodSelector = self
		
		let foodSearchView = storyboard.instantiateViewController(withIdentifier: "FoodSearchView") as! FoodSearchViewController
		foodSearchView.foodDetailViewController = foodDetailView
        
        let visionController = storyboard.instantiateViewController(withIdentifier: "VisionView") as! ImageClassificationViewController
        visionController.searchViewController = foodSearchView
        
        self.navigationController?.pushViewController(visionController, animated: true)
    }
	
	// MARK: - Meal Saving
	
	//TODO present NewMealSettingsVC before saving meal.
	@IBAction func saveMealButtonPressed(_ sender: UIButton) {
		//TODO present new meal settings
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let newMealSettingsViewController = storyboard.instantiateViewController(withIdentifier: "NewMealSettingsVC") as! NewMealSettingsViewController
		newMealSettingsViewController.meal = self.meal
		newMealSettingsViewController.mealBuilder = self
		self.navigationController?.pushViewController(newMealSettingsViewController, animated:true)
	}
	
	//called from NewMealSettingsViewController
	func onReturnFromSavedMeal() {
		//let mealCopy = self.meal.clone()
		let emptyCompletion: (Bool) -> Void = { (success: Bool) -> Void in }
		
		//saveMeal(mealCopy, emptyCompletion)
		saveMeal(meal, emptyCompletion)
		
		for foodItem in meal.getFoodItems() {
			cacheFoodItem(foodItem, emptyCompletion)
		}
		
		saveMealButton.isEnabled = false
		self.resetMeal()
		self.displayMealSavedAlert()
	}


	// Save new Meal to list of user's meals
	func saveMeal(_ meal: Meal, _ completion: @escaping BoolCompletion, _ debug: Bool = false) {
		
		let mealCopy = meal.clone() //TODO remove clone?
		saveMealToRealm(mealCopy, completion)
	}

	func saveMealToRealm(_ meal: Meal, _ completion: @escaping BoolCompletion) {
		DispatchQueue(label: "MealBuilderVC.saveMealToRealm").async {
			autoreleasepool {
				let realm = try! Realm()
				
				//check for save to firebase
				let results = realm.objects(UserInfo.self)
				if results.count == 0 {
					print("Warning: no UserInfo instance detected")
				} else if results.count == 1 {
					let userInfo = results.first!
					if userInfo.isFirebaseEnabled {
						self.saveMealToFirebase(meal, userInfo.firebaseId)
					}
				} else { print("Warning: multiple UserInfo instances found"); }

				//save to realm
				try! realm.write {
					realm.add(meal)
				}
			}
			completion(true)

		}
	}
	
	func saveMealToFirebase(_ meal: Meal, _ firebaseId: String) {
		
		
		var foodItems = [[String: Any]]()
		for foodItem in meal.getFoodItems() {
			let foodName = foodItem.getName()
			let foodId = foodItem.getFoodId()
			let foodUnit = foodItem.getUnit()
			let foodAmount = foodItem.getAmount()
			
			let jFoodItem = ["name": foodName,
							 "id": foodId,
							 "amount:": foodAmount,
							 "unit": foodUnit] as [String : Any]
			foodItems.append(jFoodItem)
		}
		
		//TODO delegate firebase logic to a manager class
		let ref = Database.database().reference()
		let container = ref.child("Users")
		let user = container.child(firebaseId)
		let userMeals = user.child("/meals")
		let newMealData = ["date": meal.getDate().description, "foodItems":foodItems] as [String : Any]
		let newMeal = userMeals.child("\(meal.getId())")
		newMeal.setValue(newMealData)
	}

	//MARK: save & cache singular food items
	func cacheFoodItem(_ foodItem: FoodItem, _ completion: @escaping BoolCompletion, _ debug: Bool = false) {
		
		//get & cache nutrient info for each food item.
		let reportCompletion: (FoodReportV1?) -> Void = { (report: FoodReportV1?) -> Void in
			if debug {print("completion for: \(foodItem.getFoodId())")}
			
			// saved cahced food item from report
			if let toCache = report?.toCache {
				self.saveCachedFoodItemToRealm(toCache, completion)

			} else {
				if debug {print("could not cache item.")}
			}
		}
		
		Database5.requestFoodReportV1(foodItem, reportCompletion, debug)
	}

	func saveCachedFoodItemToRealm(_ toCache: CachedFoodItem, _ completion: @escaping BoolCompletion, _ debug: Bool = false) {
		if debug {print("caching food item: \(toCache.getFoodId())")}
		DispatchQueue(label: "MealBuilderVC.saveCachedFoodItemToRealm").async {
			autoreleasepool {
				let realm = try! Realm()
				//TODO check for duplicates
				try! realm.write {
					realm.add(toCache)
					completion(true)
					if debug {print("cached food item successfully saved")}
				}
			}
		}
	}
	
	func displayMealSavedAlert() {
		mealSavedAlertLabel.isHidden = false
		mealSavedAlertLabel.alpha = 0.5
		UIView.animate(withDuration: 2.0, animations: { () -> Void in
			self.mealSavedAlertLabel.alpha = 0
		})
	}
	
	//reset with new empty meal
	func resetMeal() {
		self.meal = Meal()
		asyncReloadData()
	}
	
	func addToMeal(_ foodItem: FoodItem) {
		meal.add(foodItem)
		asyncReloadData()
		saveMealButton.isEnabled = true
	}
	
	func removeFromMeal(_ index: Int) {
		meal.remove(index)
		asyncReloadData()
		saveMealButton.isEnabled = meal.count() > 0
	}
	
	func asyncReloadData() {
		DispatchQueue.main.async {
			self.mealTableView?.reloadData()
		}
	}
	
	// MARK: - FoodSelector protocol
	func addFood(foodItem: FoodItem) {
		addToMeal(foodItem)
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
		
		var cell: UITableViewCell
		if let reuseCell = tableView.dequeueReusableCell(withIdentifier: "MealFoodItemCell", for: indexPath) as UITableViewCell! {
		//if let reuseCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell! {
			cell = reuseCell
		} else {
			cell = MealBuilderTableViewCell(foodItem)
		}

		cell.textLabel!.text = foodItem.getName() //TODO move to cell initializer
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if let indexPath = tableView.indexPathForSelectedRow {
			let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FoodDetailView") as! FoodDetailViewController
			vc.foodItem = meal.get(indexPath.row)!
			self.navigationController?.pushViewController(vc, animated: true)
		}
	}
	
	// MARK: - Table View Swiping gestures
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
		//action.backgroundColor = .red
		return UISwipeActionsConfiguration(actions: [action])
	}

}
