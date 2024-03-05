//
//  SavedRecipesCell.swift
//  Recipify
//
//  Created by Ketan Aggarwal on 13/02/24.
//

import UIKit
import CoreData
import SDWebImage

class SavedRecipesCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var savedRecipes: [SavedRecipe] = []
    private let recipeCellIdentifier = "RecipeCell"
    var router: DiscoverRecipePrototcol?
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollection()
        fetchRecipesFromCoreData()
        NotificationCenter.default.addObserver(self, selector: #selector(handleCoreDataChanges(_:)), name: NSNotification.Name.NSManagedObjectContextObjectsDidChange, object: nil)
    }

    deinit {
           // Remove observer when cell is deallocated
           NotificationCenter.default.removeObserver(self)
       }
    func setupCollection(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "RecipeCell", bundle: nil), forCellWithReuseIdentifier: recipeCellIdentifier)
    }
    func fetchRecipesFromCoreData() {
        let context = CoreDataStack.shared.managedObjectContext
        let fetchRequest: NSFetchRequest<SavedRecipe> = SavedRecipe.fetchRequest()
        
        do {
            savedRecipes = try context.fetch(fetchRequest)
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            
        } catch {
            print("Error fetching recipes from Core Data: \(error)")
        }
    }

    @objc func handleCoreDataChanges(_ notification: Notification) {
          
           fetchRecipesFromCoreData()
       }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return savedRecipes.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: recipeCellIdentifier, for: indexPath) as! RecipeCell
        let recipe = savedRecipes[indexPath.item]
        cell.titleLabel.text = recipe.title
        cell.prepTime.text = "Prep Time\(recipe.prepTime)"
        cell.rating.text =  "\(recipe.calories)"
        cell.savedButton.isHidden = true
        if let imageURLString = recipe.image, let imageURL = URL(string: imageURLString) {
                cell.imageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "placeholderImage"))
            } else {
                cell.imageView.image = UIImage(named: "placeholderImage")
            }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("tapped")
        let selectedRecipe = savedRecipes[indexPath.row]

        let itemId = Int(selectedRecipe.id)
        let selectedTitle = selectedRecipe.title ?? ""
        let selectedImage = selectedRecipe.image ?? ""
        let selectedPrepTime = Int(selectedRecipe.prepTime)
        let selectedHealth = Int(selectedRecipe.calories)

        router?.navigateToDetailPage(with: itemId, selectedTitle: selectedTitle, selectedImage: selectedImage, selectedPrepTime: selectedPrepTime, selectedHealth: selectedHealth)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
}
