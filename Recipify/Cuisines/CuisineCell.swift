//
//  CuisineCell.swift
//  Recipify
//
//  Created by Ketan Aggarwal on 29/01/24.
//

import UIKit

class CuisineCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    static let cellHeight: CGFloat = 370.0
    static let cellWidth: CGFloat = 200.0

    static let cellPadding: CGFloat = 10.0
    
    func configure(withCuisineItem cuisineItem: CollectionCuisineViewItem) {
            titleLabel.text = cuisineItem.title
       
        }
}
