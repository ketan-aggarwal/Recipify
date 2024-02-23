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



enum CellType {
    case cuisine
    case recipe
}



class CustomTableCell: UITableViewCell, UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    private let cuisineCellIdentifier = "CuisineCell"
    private let recipeCellIdentifier = "RecipeCell"
    private let shimmeringCellIdentifier = "ShimmeringCell"
    
    var isLoading: Bool = true
    var recipeItems: [CollectionRecipeViewItem] = []
    var cuisineItems: [CollectionCuisineViewItem] = []
    var cellType: CellType = .cuisine
    var router: DiscoverRecipePrototcol?
    var shimmerCell: ShimmeringTableViewCell?
    
 
   
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
    
    func returnCount() -> Int {
        if !recipeItems.isEmpty {
            return recipeItems.count
        }else if !cuisineItems.isEmpty {
            return cuisineItems.count
        }else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return returnCount()
        }
    
    func getCellType() -> CellType {
        if !recipeItems.isEmpty {
            return .recipe
        }else if !cuisineItems.isEmpty {
            return .cuisine
        }else{
            return .recipe
        }
    }
    
   

   
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//            switch getCellType() {
//            case .cuisine:
//                let cuisineItem = cuisineItems[indexPath.row]
//                print("Customcell\(cuisineItem)")
//                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cuisineCellIdentifier, for: indexPath) as! CuisineCell
//                cell.configure(withCuisineItem: cuisineItem)
//                cell.backgroundColor = .black
//               // print("Sstate\(isLoading)")
//                return cell
//            case .recipe:
//
//                let recipeItem = recipeItems[indexPath.row]
//                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: recipeCellIdentifier, for: indexPath) as! RecipeCell
//                cell.configure(withRecipeItem: recipeItem)
//                cell.backgroundColor = .darkGray
////                    print("Rstate\(isLoading)")
//
//                return cell
//            }
//        }
   
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                switch getCellType() {
                case .cuisine:
                    let cuisineItem = cuisineItems[indexPath.row]
                    print("Customcell\(cuisineItem)")
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cuisineCellIdentifier, for: indexPath) as! CuisineCell
                    cell.configure(withCuisineItem: cuisineItem)
                    cell.backgroundColor = .black
                   print("stateS\(isLoading)")
                    return cell
                case .recipe:
                    if isLoading{
                        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: shimmeringCellIdentifier, for: indexPath) as! ShimmeringTableViewCell
                    return cell
                    } else {
                        let recipeItem = recipeItems[indexPath.row]
                        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: recipeCellIdentifier, for: indexPath) as! RecipeCell
                        cell.configure(withRecipeItem: recipeItem)
                        cell.backgroundColor = .darkGray
                        print("stateR\(isLoading)")
                        return cell
                    }
                }
            }
                   
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedId: Int
        let selectedTitle: String?
        let selectedImage: String?
        let selectedPrepTime: Int?
        let selectedHealth: Int?
      

           switch getCellType() {
           case .cuisine:
               guard let searchText = cuisineItems[indexPath.row].title else { return }
                  delegate?.didSelectCuisine(with: searchText)
               print(searchText)
               return
              
           case .recipe:
               selectedId = recipeItems[indexPath.row].id ?? 0
               selectedTitle = recipeItems[indexPath.row].title
               selectedImage = recipeItems[indexPath.row].image
               selectedPrepTime = recipeItems[indexPath.row].readyInMinutes
               selectedHealth = recipeItems[indexPath.row].healthScore
           }

           
        router?.navigateToDetailPage(with: selectedId, selectedTitle: selectedTitle ?? "hello", selectedImage: selectedImage ??  "hi" , selectedPrepTime: selectedPrepTime ?? 0,selectedHealth: selectedHealth ?? 0)
       }

    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }


}
