//
//  UserInfo.swift
//  NutritionTracker
//
//  Created by alc29 on 2018-07-30.
//  Copyright © 2018 alc29. All rights reserved.
//

import Foundation
import RealmSwift

class UserInfo: Object {
	@objc dynamic var firebaseId: String = "" //user's firebase id
	@objc dynamic var isFirebaseEnabled: Bool = false //true if user wants their meals archived
	
}
