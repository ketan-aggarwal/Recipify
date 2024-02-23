//
//  FetchRecipeTableCell.swift
//  Recipify
//
//  Created by Ketan Aggarwal on 08/02/24.
//

import UIKit

class FetchRecipeTableCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private let recipeCellIdentifier = "RecipeCell"
    var viewModel : FetchRecipeViewModel?
    var router: DiscoverRecipePrototcol?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()

    }
    

    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
       
        
        collectionView.register(UINib(nibName: "RecipeCell", bundle: nil), forCellWithReuseIdentifier: recipeCellIdentifier)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("count\(viewModel?.searchList.count)")
        return viewModel?.searchList.count ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: recipeCellIdentifier, for: indexPath) as? RecipeCell else {
            return UICollectionViewCell()
        }
        
        let recipe = viewModel?.searchList[indexPath.row]
        cell.titleLabel.text = recipe?.title
        cell.prepTime.text = "Prep TIme: \(recipe?.readyInMinutes ?? 0)"
        cell.rating.text = "Calories: \(recipe?.healthScore ?? 0)"
        if let imageUrlString = recipe?.image, let imageUrl = URL(string: imageUrlString) {
            cell.imageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder"))
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
        
        selectedId = viewModel?.searchList[indexPath.row].id ?? 0
        selectedTitle = viewModel?.searchList[indexPath.row].title
        selectedPrepTime = viewModel?.searchList[indexPath.row].readyInMinutes
        selectedHealth = viewModel?.searchList[indexPath.row].healthScore
        selectedImage = viewModel?.searchList[indexPath.row].image
        
        router?.navigateToDetailPage(with: selectedId, selectedTitle: selectedTitle ?? "hello", selectedImage: selectedImage ??  "hi" , selectedPrepTime: selectedPrepTime ?? 0,selectedHealth: selectedHealth ?? 0)
    }
    

}

