//
//  AppDelegate.swift
//  NutritionTracker
//
//  Created by alc29 on 2018-06-24.
//  Copyright © 2018 alc29. All rights reserved.
//

import UIKit
import RealmSwift
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?
	private let debug = false
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.
		FirebaseApp.configure()
		configureRealm()
		return true
	}
	
	//Testing - clear all persistent data
	//(note: if migration required, must erase all content from device & restart.)
	private func configureRealm() {
		DispatchQueue(label: "AppDelegate.configureRelam").async {
			let realm = try! Realm()
			let userInfoResult = realm.objects(UserInfo.self)

			try! realm.write {
				if self.debug {
					realm.deleteAll()
				}
				
				//check for existing UserInfo; if none, create new instance.
				if userInfoResult.count == 0 {
					let userInfo = UserInfo()
					
					//TODO handle no internet connection
					//create new database id
					let REF = Database.database().reference()
					let CONTAINER_KEY = "Users" //TODO promote to static class member
					let USERS = REF.child(CONTAINER_KEY)
					
					//create new account
					let id = USERS.childByAutoId()
					userInfo.firebaseId = id.key

					realm.add(userInfo)
					print("Creating new UserInfo: \(id.key)")

				} else {
					print("Loading existing UserInfo")
				}
				
			} // end write
		} //end async
	}

	func applicationWillResignActive(_ application: UIApplication) {
		// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
		// Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
	}

	func applicationDidEnterBackground(_ application: UIApplication) {
		// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
		// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	}

	func applicationWillEnterForeground(_ application: UIApplication) {
		// Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
	}

	func applicationDidBecomeActive(_ application: UIApplication) {
		// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	}

	func applicationWillTerminate(_ application: UIApplication) {
		// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
	}


}

