//
//  EntryViewController.swift
//  NutritionTracker
//
//  Created by alc29 on 2018-06-24.
//  Copyright © 2018 alc29. All rights reserved.
//
//	ViewController for the app entry/launch screen. Contains initialization logic.
// 	TODO add an interesting splash screen/logo/grpahic

import UIKit
import RealmSwift

class EntryViewController: UIViewController {

	@IBOutlet weak var continueButton: UIButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// if firebase id exists, continue to next view, else
		continueButton.backgroundColor = UIColor.white
	}
	
//	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//		if segue.identifier == "entryToLoginSegue" {
////			segue.destination
//		}
//	}
	
}

