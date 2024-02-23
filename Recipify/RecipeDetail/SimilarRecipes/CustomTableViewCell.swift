//
//  CustomTableViewCell.swift
//  Recipify
//
//  Created by Ketan Aggarwal on 07/02/24.
//

import UIKit
import SDWebImage

class CustomTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    private let recipeCellIdentifier = "RecipeCell"
    var viewModel: SimilarRecipeViewModel?
    var router: DiscoverRecipePrototcol?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
    }
    
    func setupCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "RecipeCell", bundle: nil), forCellWithReuseIdentifier: recipeCellIdentifier)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.similarRecipesList.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: recipeCellIdentifier, for: indexPath) as? RecipeCell else {
            return UICollectionViewCell()
        }
        
        if let viewModel = viewModel, indexPath.item < viewModel.similarRecipesList.count {
            let recipe = viewModel.similarRecipesList[indexPath.item]
            cell.titleLabel.text = recipe.title
            cell.prepTime.text = "Prep Time: \(recipe.readyInMinutes) mins" 
            if let imageUrlString = recipe.sourceUrl, let imageUrl = URL(string: imageUrlString) {
                print("hi\(imageUrlString)")
                cell.imageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder"))
            } else {
                // Handle the case when recipe.sourceUrl is nil
                cell.imageView.image = UIImage(named: "placeholder")
            }
            
            cell.rating.text = "Rating:3"
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("hello")
        let selectedId: Int
        let selectedTitle: String?
        let selectedImage: String?
        let selectedPrepTime: Int?
        let selectedHealth: Int?
        
        selectedId = viewModel?.similarRecipesList[indexPath.row].id ?? 0
        selectedTitle = viewModel?.similarRecipesList[indexPath.row].title
        selectedPrepTime = viewModel?.similarRecipesList[indexPath.row].readyInMinutes
        selectedHealth = viewModel?.similarRecipesList[indexPath.row].servings
        selectedImage = viewModel?.similarRecipesList[indexPath.row].sourceUrl
        
        router?.navigateToDetailPage(with: selectedId, selectedTitle: selectedTitle ?? "hello", selectedImage: selectedImage ??  "hi" , selectedPrepTime: selectedPrepTime ?? 0,selectedHealth: selectedHealth ?? 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           return CGSize(width: collectionView.bounds.width / 2, height: collectionView.bounds.height)
       }
}
