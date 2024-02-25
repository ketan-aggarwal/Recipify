//
//  CustomTableCell.swift
//  Recipify
//
//  Created by Ketan Aggarwal on 29/01/24.
//

import UIKit

protocol CustomTableCellDelegate: AnyObject {
    func didSelectCuisine(with searchText: String)
}


class CustomTableCell: UITableViewCell, UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    private let cuisineCellIdentifier = "CuisineCell"
    private let recipeCellIdentifier = "RecipeCell"
    private let shimmeringCellIdentifier = "ShimmeringCell"
    
    var router: DiscoverRecipePrototcol?
    var shimmerCell: ShimmeringTableViewCell?
    var dashboardItems: [ItemTypeDashBoardProtocol] = []
    weak var delegate: CustomTableCellDelegate?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
        collectionView.reloadData()
    }
    
   
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "CuisineCell", bundle: nil), forCellWithReuseIdentifier: cuisineCellIdentifier)
        collectionView.register(UINib(nibName: "RecipeCell", bundle: nil), forCellWithReuseIdentifier: recipeCellIdentifier)
        collectionView.register(UINib(nibName: "ShimmeringTableViewCell", bundle: nil), forCellWithReuseIdentifier: shimmeringCellIdentifier)
    }
    

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dashboardItems.count
        //return returnCount()
        }
    

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard !dashboardItems.isEmpty else {
               // Display shimmering cell if data is not available
               let cell = collectionView.dequeueReusableCell(withReuseIdentifier: shimmeringCellIdentifier, for: indexPath) as! ShimmeringTableViewCell
               return cell
           }
        let item = dashboardItems[indexPath.item]
        print("Dashboard items: \(dashboardItems)")
        switch item.itemType {
        case .cuisine:
            let cuisineItem = item as! CollectionCuisineViewItem
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cuisineCellIdentifier, for: indexPath) as! CuisineCell
            cell.configure(withCuisineItem: cuisineItem)
            cell.backgroundColor = .black
            return cell
        case .recipe:
            let recipeItem = item as! CollectionRecipeViewItem
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: recipeCellIdentifier, for: indexPath) as! RecipeCell
            cell.configure(withRecipeItem: recipeItem)
            cell.backgroundColor = .darkGray
            return cell
        case .loading:
            print("Shimmer cells Displayed")
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: shimmeringCellIdentifier, for: indexPath) as! ShimmeringTableViewCell
            return cell
        }
    }

   

   
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           let item = dashboardItems[indexPath.item]
           
           switch item.itemType {
           case .cuisine:
               guard let cuisineItem = item as? CollectionCuisineViewItem, let searchText = cuisineItem.title else { return }
               delegate?.didSelectCuisine(with: searchText)
               
           case .recipe:
               guard let recipeItem = item as? CollectionRecipeViewItem else { return }
               router?.navigateToDetailPage(with: recipeItem.id ?? 0, selectedTitle: recipeItem.title ?? "", selectedImage: recipeItem.image ?? "", selectedPrepTime: recipeItem.readyInMinutes ?? 0, selectedHealth: recipeItem.healthScore ?? 0)
               
           case .loading:
               break
           }
       }
    

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }


}
