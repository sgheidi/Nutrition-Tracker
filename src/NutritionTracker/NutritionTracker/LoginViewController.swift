//
//  LoginViewController.swift
//  NutritionTracker
//
//  Created by alc29 on 2018-06-24.
//  Copyright © 2018 alc29. All rights reserved.
//
//	View Controller for the login screen.

import UIKit
import RealmSwift

class LoginViewController: UIViewController {

	@IBOutlet weak var continueButton: UIButton!
	@IBOutlet weak var firebaseIdLabel: UILabel!
	@IBOutlet weak var enabledSwitch: UISwitch!
	
	override func viewDidLoad() {
        super.viewDidLoad()

		continueButton.backgroundColor = UIColor.white

		//check if user enabeld firebase backup
		let realm = try! Realm()
		
		if let userInfo = realm.objects(UserInfo.self).first {
			if userInfo.firebaseId != "" {
				firebaseIdLabel.text = userInfo.firebaseId
			}
			enabledSwitch.isOn = userInfo.isFirebaseEnabled
		} else { print("Warning: no user info present.") }
    }
	
	
	@IBAction func continueButtonPressed(_ sender: Any) {
		let realm = try! Realm()
		if let userInfo = realm.objects(UserInfo.self).first {
			try! realm.write {
				userInfo.isFirebaseEnabled = enabledSwitch.isOn
			}
		}
	}
	
	
}
