//
//  FoodListTableViewController.swift
//  NutritionTracker
//
//  Created by alc29 on 2018-07-02.
//  Copyright © 2018 alc29. All rights reserved.
//

/**
Display the supplied list of FoodItems.
Allow for the selection of a FoodItem from the table.
*/

import UIKit

class FoodListTableViewController: UITableViewController {
	var foodDetailView: FoodDetailViewController? = nil
	
	var foodItems = [FoodItem]() {
		didSet {
			DispatchQueue.main.async {
				self.tableView.reloadData()
			}
		}
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
		self.tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "Cell")

    }
	
	override func viewWillAppear(_ animated: Bool) {
		if let selectionIndexPath = tableView.indexPathForSelectedRow {
			tableView.deselectRow(at: selectionIndexPath, animated: animated)
		}
		super.viewWillAppear(animated)
	}


    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

	// Return the number of cells to display
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodItems.count
    }
	
	// Called when a cell is tapped. present FoodDetailView when a FoodItem cell is tapped
	//TODO use custon foodDetailView if in MealBuilder
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if let indexPath = tableView.indexPathForSelectedRow {
			if self.foodDetailView != nil {
				self.foodDetailView!.foodItem = foodItems[indexPath.row]
				self.navigationController?.pushViewController(self.foodDetailView!, animated: true)
			} else {
				let storyboard = UIStoryboard(name: "Main", bundle: nil)
				let foodDetailView = storyboard.instantiateViewController(withIdentifier: "FoodDetailView") as! FoodDetailViewController
				foodDetailView.foodItem = foodItems[indexPath.row]
				self.navigationController?.pushViewController(foodDetailView, animated: true)
			}
		}
	}

	// Setup the cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//		let cellToUse = UITableViewCell()
//		let foodItem = foodItems[indexPath.row]
//		cellToUse.textLabel!.text = foodItem.getName()
//		return cellToUse
		
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
		cell.textLabel!.text = foodItems[indexPath.row].getName()
		return cell
    }
	

	
	// MARK: Provided template methods
	
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
