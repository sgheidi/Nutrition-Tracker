//
//  FoodSearchViewController2.swift
//  NutritionTracker
//
//  Created by alc29 on 2018-07-02.
//  Copyright © 2018 alc29. All rights reserved.
//

import UIKit

/**
	Controls the search bar & search results displayed in the Search view.
	Passes a selected food to the FoodDetailViewController.
*/
class FoodSearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
	//MARK: Properties
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var searchFooter: SearchFooterView!
	
	var foodDetailViewController: FoodDetailViewController? = nil
	let searchController = UISearchController(searchResultsController: nil)
	
	//var filteredResults = [FoodItem]()
	var searchResults = [FoodItem]() {
		didSet {
			DispatchQueue.main.async {
				self.tableView.reloadData()
			}
		}
	}
	
	
	//MARK: - View Setup
    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup search controller
		// uncomment to update search results on any change in the search bar.
		//searchController.searchResultsUpdater = self
		searchController.obscuresBackgroundDuringPresentation = false
		searchController.searchBar.placeholder = "Search Foods"
		navigationItem.searchController = searchController
		definesPresentationContext = true
		
		//make sure search bar isn't hidden
		if #available(iOS 11.0, *) {
			self.navigationItem.searchController = self.searchController
			self.navigationItem.hidesSearchBarWhenScrolling = false
		} else {
			tableView.tableHeaderView = searchController.searchBar
			tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "FoodSearchResultCell")
		}
		
		//setup the scope bar
		//searchController.searchBar.scopeButtonTitles = ["All", "Meat", "Vegges"] TODO use for filtering results, if desired.
		searchController.searchBar.delegate = self

		//setup search footer
		tableView.tableFooterView = searchFooter
		
    }

	override func viewWillAppear(_ animated: Bool) {
		if let selectionIndexPath = tableView.indexPathForSelectedRow {
			tableView.deselectRow(at: selectionIndexPath, animated: animated)
		}
		super.viewWillAppear(animated)
	}
	
	// MARK: = Table View Delegate
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		//if isFiltering() {
		//	searchFooter.setIsFilteringToShow(filteredItemCount: filteredResults.count, of: results.count)
		//	return filteredResults.count
		//} 
		//searchFooter.setNotFiltering()
		//return results.count
		return searchResults.count
	}
	
	//called when a cell is tapped.
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if let indexPath = tableView.indexPathForSelectedRow {

			if self.foodDetailViewController == nil {
				self.foodDetailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FoodDetailView") as! FoodDetailViewController
			}

			foodDetailViewController!.foodItem = searchResults[indexPath.row]
			self.navigationController?.pushViewController(self.foodDetailViewController!, animated: true)
		}		
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "FoodSearchResultCell", for: indexPath) as UITableViewCell!
		let foodItem: FoodItem
//		if isFiltering() {
//			foodItem = filteredResults[indexPath.row]
//		} else {
//			foodItem = results[indexPath.row]
//		}
		
		foodItem = searchResults[indexPath.row]
		
		cell.textLabel!.text = foodItem.getName()
		//cell.detailTextLabel!.text = "todo FoodItem.getFoodGroup()"
		return cell
	}
		
	
//	//Mark: - private instance methods

	
	func searchBarIsEmpty() -> Bool {
		return searchController.searchBar.text?.isEmpty ?? true
	}
	func isFiltering() -> Bool {
		//let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
		//return searchController.isActive && (!searchBarIsEmpty() || searchBarScopeIsFiltering)
		return false
	}
	
	//MARK: - Search
	func searchAndUpdateResults(_ searchTerm: String) {
		Database5.search(searchTerm, searchCompletion)
	}
	
	func searchCompletion(_ foodItems: [FoodItem]) {
		searchResults.removeAll()
		searchResults = foodItems
		DispatchQueue.main.async {
			self.tableView.reloadData()
		}
	}

	
} //end of main class

//MARK: - UISearchBar Delegate
extension FoodSearchViewController: UISearchBarDelegate {
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
	//func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
		//filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
		searchAndUpdateResults(searchBar.text!)
	}
	
}

// MARK: Filtering Results
//	func filterContentForSearchText(_ searchText: String, scope: String = "All") {
//		filteredResults = results.filter({(foodItem: FoodItem) -> Bool in
//			//TODO implement if we want to filter results by a category (FoodGroup)
//			let doesCategoryMatch = (scope == "All") || (true) //|| (candy.category == scope)
//			if searchBarIsEmpty() {
//				return doesCategoryMatch
//			} else {
//				return doesCategoryMatch && foodItem.getName().lowercased().contains(searchText.lowercased())
//			}
//			return false
//		})
//		tableView.reloadData()
//	}

//uncomment to update search results on any change in the search bar.
//extension FoodSearchViewController: UISearchResultsUpdating {
//	// MARK: - UISearchResultsUpdating Delegate
//	func updateSearchResults(for searchController: UISearchController) {
//		//let searchBar = searchController.searchBar
//		//let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
//		//filterContentForSearchText(searchController.searchBar.text!, scope: scope)
//		searchAndUpdateResults(searchController.searchBar.text!)
//	}
//}

