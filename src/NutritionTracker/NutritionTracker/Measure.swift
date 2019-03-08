//
//  Measure.swift
//  NutritionTracker
//
//  Created by alc29 on 2018-07-27.
//  Copyright © 2018 alc29. All rights reserved.
//

import Foundation
import RealmSwift

class Measure: Object {
	@objc dynamic var label: String? = ""
	@objc dynamic var eqv: Float = 0
	@objc dynamic var eunit: String = Unit.G.rawValue
	@objc dynamic var qty: Float = 0
	@objc dynamic var value: Float = 0
	
	convenience init(_ label: String, _ eqv: Float, _ eunit: String, _ qty: Float, _ value: Float) {
		self.init()
		self.label = label
		self.eqv = eqv
		self.eunit = eunit
		self.qty = qty
		self.value = value
	}
}
