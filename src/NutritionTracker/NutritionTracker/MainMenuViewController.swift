//
//  MainMenuViewController.swift
//  NutritionTracker
//
//  Created by alc29 on 2018-06-24.
//  Copyright © 2018 alc29. All rights reserved.
//
//	ViewController for the main menu.
//	Transition logic is handled by segues in the storyboard.

import UIKit
import RealmSwift

class MainMenuViewController: UIViewController {
	@IBOutlet weak var buttonStack: UIStackView!
	@IBOutlet weak var firebaseIdLabel: UILabel!
	
	override func viewDidLoad() {
        super.viewDidLoad()
		for view in buttonStack.arrangedSubviews {
			view.backgroundColor = UIColor.white
		}
		
		let realm = try! Realm()
		let userInfo = realm.objects(UserInfo.self).first!
		firebaseIdLabel.text = "firebase id: \(userInfo.firebaseId)"
		
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
	}
	

	
	// MARK: Button actions
	
	@IBAction func catalogButtonPressed(_ sender: UIButton) {
		let vc = CategoryTableViewController()
		self.navigationController?.pushViewController(vc, animated: true)
	}
	
	@IBAction func foodSearchButtonPressed(_ sender: UIButton) {
		//let vc = FoodSearchViewController()
		//self.navigationController?.pushViewController(vc, animated: true)
		//let foodDetailView = FoodDetailViewController()
		
		let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FoodSearchView")
		self.navigationController?.pushViewController(vc, animated: true)
	}
	
	@IBAction func visionButtonPressed(_ sender: UIButton) {
		
		let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "VisionView")
		self.navigationController?.pushViewController(vc, animated: true)
	}
	
}
