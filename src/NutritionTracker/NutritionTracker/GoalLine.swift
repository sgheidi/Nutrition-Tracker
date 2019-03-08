//
//  GoalLine.swift
//  NutritionTracker
//
//  Created by Kainoa Seaman on 2018-07-29.
//  Copyright © 2018 alc29. All rights reserved.
//

import Foundation
import RealmSwift
import Charts

class GoalLine: Object {
    @objc private dynamic var nutrientId = 0
    @objc private dynamic var amount: Float = Float(0.0)
    @objc private dynamic var unit: String = ""
    
    convenience init(_ nutrientId: Int, _ amount: Float = Float(0), _ unit: String = "g") {
        self.init()
        self.nutrientId = nutrientId
        self.amount = amount
        self.unit = unit
    }
    
    // MARK: Setters
    func setNutrientId(_ nutrientId: Int) {
        self.nutrientId = nutrientId
    }
    
    func setAmount(_ amount: Float) {
        self.amount = amount
    }
    
    func setUnit(_ unit: String) {
        self.unit = unit
    }
    
    // MARK: Getters
    func getNutrientId() -> Int { return nutrientId }
    func getAmount() -> Float { return amount }
    func getUnit() -> String { return unit }
    
    // Make a Goal Line
    func makeLine() -> ChartLimitLine? {
        // Make name from id
        guard let name:String = Nutrient.dict[nutrientId]?.name else { print("no name for id"); return nil }
        
        // Return if no amount value
        if (amount == 0) { print("no amount"); return nil }
        
        // Create Line with default settings
        let gLine = ChartLimitLine(limit: Double(amount), label: name)
//		let gLine = ChartLimitLine(limit: 0.5, label: name)
        gLine.lineWidth = 4
        gLine.lineDashLengths = [5, 5]
        gLine.labelPosition = .rightTop
        gLine.valueFont = .systemFont(ofSize: 10)
        
        return gLine
    }
    
}
