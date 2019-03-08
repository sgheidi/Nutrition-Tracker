//
//  SearchFooterView.swift
//  NutritionTracker
//
//  Created by alc29 on 2018-07-02.
//  Copyright © 2018 alc29. All rights reserved.
//

import UIKit

class SearchFooterView: UIView {
	let label: UILabel = UILabel()
	
	override public init(frame: CGRect) {
		super.init(frame: frame)
		configureView()
	}
	required public init?(coder:NSCoder) {
		super.init(coder:coder)
		configureView()
	}
	func configureView() {
//		backgroundColor = UIColor.candyGreen
//		alpha = 0.0
		
		
		//config label
		label.textAlignment = .center
		//	label.textColor = UIColor.white
		addSubview(label)
	}

    override func draw(_ rect: CGRect) {
        // Drawing code
		label.frame = bounds
    }


	//MARK: - Animation
	fileprivate func hideFooter() {
		UIView.animate(withDuration: 0.7) {[unowned self] in
			self.alpha = 0.0
		}
	}
	fileprivate func showFooter() {
		UIView.animate(withDuration: 0.7) {[unowned self] in
			self.alpha = 1.0
		}
	}
}

extension SearchFooterView {
	//MARK: - Public API
	public func setNotFiltering() {
		label.text = ""
		hideFooter()
		
	}
	public func setIsFilteringToShow(filteredItemCount: Int, of totalItemCount: Int) {
		if (filteredItemCount == totalItemCount) {
			setNotFiltering()
		} else if (filteredItemCount == 0) {
			showFooter()
		} else {
			label.text = "Filtering \(filteredItemCount) of \(totalItemCount)"
			showFooter()
		}
	}
}
