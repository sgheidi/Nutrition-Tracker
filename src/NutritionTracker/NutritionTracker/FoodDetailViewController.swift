//
//  FoodDetailViewController.swift
//  NutritionTracker
//
//  Created by alc29 on 2018-07-02.
//  Copyright © 2018 alc29. All rights reserved.
//
//    Display a bar chart of what nutrients are in a given FoodItem.
//    The specific nutrients to display can be set by the user.
//
//    TODO cocoapod thread minor warning, ignore for now - Main Thread Checker: UI API called on a background thread: -[UIView setNeedsDisplay]
import UIKit
import RealmSwift
import Charts

class FoodDetailViewController: UIViewController {
	
	// Declaration of buttons and charts
	@IBOutlet weak var foodNameLabel: UILabel!
	@IBOutlet weak var barGraph: BarChartView!
	//var nutrientsToDisplay = [Nutrient]()
	var foodSelector: FoodSelector?
	var foodItem = FoodItem(0, "default food item", 0, "g")
	var graphSettings = GraphSettings() //if no settings found, use default settings & save
	
	let DEFAULT_TAGS = [Nutrient.Sugars_total, Nutrient.Calcium, Nutrient.Sodium] //TODO load tags from user settings
	
	override func viewDidLoad() {
		super.viewDidLoad()
		barGraphSetup()
		reloadBarGraphData()
		
	}
	
	func reloadBarGraphData() {
		print("reloading bar graph data..")
		
		// Sets label to food name
		foodNameLabel!.text = foodItem.getName()
		
		// declares variable to hold chart data
		var dataSets = [ChartDataSet]()
		
		// counts through each nutrient
		var testCount = -1
		
		// function to be run while accessing food database
		let completion: (CachedFoodItem?) -> Void = { (cachedFoodItem: CachedFoodItem?) -> Void in
			guard let cachedFoodItem = cachedFoodItem else { print("no such cachedFoodItem, id: \(self.foodItem.getFoodId())"); return }
			
			for tag in self.DEFAULT_TAGS { //for each nutrient tag
				testCount = testCount + 1
				
				//gets nutrient name and amount for each nutrition tag
				let foodItemNutrient = cachedFoodItem.getFoodItemNutrient(tag)
				let amountOfNutrient = foodItemNutrient?.getAmount()
				
				// takes care of nil values and sets to zero
				var yVal:Float? = 0
				if amountOfNutrient != nil {
					yVal = amountOfNutrient!
				}
				
				// bar chart data entry: x is nutrient # and y is nutrient amount
				var barEntrys = [BarChartDataEntry]()
				barEntrys.append(BarChartDataEntry(x:Double(testCount), y: Double(yVal!)))
				
				// adds barchart data entry into a set
				var set1 = BarChartDataSet()
				// adds nutrient name to legend
				set1 = BarChartDataSet(values: barEntrys, label: "\(tag.name)")
				// sets bar to random colour
				let colour:NSUIColor = self.randColor()
				set1.colors = [colour]
				
				dataSets.append(set1)
				// Animation upon opening
				self.barGraph.animate(xAxisDuration: 1)
			}
			
			// adds dataset to bar chart object
			let data = BarChartData(dataSets: dataSets)
			self.barGraph.data = data
			self.barGraph.notifyDataSetChanged()
		}
		
		// where database is accessed
		Database5.getUnsavedCachedFoodItem(foodItem.getFoodId(), completion)
		
	}
	
	func getCachedFoodItem(_ foodId: Int, _ cachedFoodItems: [CachedFoodItem]) -> CachedFoodItem? {
		for cached in cachedFoodItems {
			if cached.getFoodId() == foodId {
				return cached
			}
		}
		print("returned nil")
		return nil
	}
	
	// set graph appearance
	func barGraphSetup() {

		let xAxis = barGraph.xAxis
		xAxis.enabled = false
		
		let leftAxisFormatter = NumberFormatter()
		leftAxisFormatter.minimumFractionDigits = 0
		leftAxisFormatter.maximumFractionDigits = 1
		leftAxisFormatter.maximum = 10
		leftAxisFormatter.negativeSuffix = " g"
		leftAxisFormatter.positiveSuffix = " g"
		
		let leftAxis = barGraph.leftAxis
		leftAxis.labelFont = .systemFont(ofSize: 10)
		leftAxis.labelCount = 8
		leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: leftAxisFormatter)
		leftAxis.labelPosition = .outsideChart
		leftAxis.spaceTop = 0.15
		leftAxis.axisMinimum = 0 // FIXME: HUH?? this replaces startAtZero = YES
		
		let rightAxis = barGraph.rightAxis
		rightAxis.enabled = false
		
		
		//TODO - bug - Legend sometimes throws index out of range:
//		if direction == .leftToRight {
//			posX += calculatedLabelSizes[i].width
//		}
//		let l = barGraph.legend
//		l.horizontalAlignment = .left
//		l.verticalAlignment = .bottom
//		l.orientation = .horizontal
//		l.drawInside = false
//		l.form = .circle
//		l.formSize = 9
//		l.font = UIFont(name: "HelveticaNeue-Light", size: 11)!
//		l.xEntrySpace = 4
		
		barGraph.chartDescription?.text = ""
		barGraph.backgroundColor = UIColor.white
		
		barGraph.pinchZoomEnabled          = true
		barGraph.drawGridBackgroundEnabled = true
		barGraph.fitBars                   = false
	}
	
	
	@objc func addButtonPressed(sender: UIBarButtonItem) {
		foodSelector?.addFood(foodItem: foodItem)
		sender.isEnabled = false
	}
	
	//AKN: https://stackoverflow.com/questions/25050309/swift-random-float-between-0-and-1
	func randColor() -> UIColor {
		let r = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
		let g = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
		let b = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
		return UIColor(red: r, green: g, blue: b, alpha: 1.0)
	}
	
	
}

// Method Graveyard
//test Values
//let values:[Double] = [ 3, 5, 7]
//        xAxis.labelPosition = .bottom
//        xAxis.labelFont = .systemFont(ofSize: 10)
//        xAxis.granularity = 1
//        xAxis.labelCount = 7
//        xAxis.valueFormatter = DayAxisValueFormatter(chart: chartView)
