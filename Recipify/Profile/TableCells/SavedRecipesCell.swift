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
        cell.prepTime.text = recipe.prepTime
        cell.rating.text =  "\(recipe.calories)"
        if let imageURLString = recipe.image, let imageURL = URL(string: imageURLString) {
                cell.imageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "placeholderImage"))
            } else {
                cell.imageView.image = UIImage(named: "placeholderImage")
            }
        return cell
    }
    
  

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedId: Int64?
        let selectedTitle: String?
        let selectedImage: String?
        let selectedPrepTime: String?
        let selectedHealth: Int16?

        selectedId = savedRecipes[indexPath.row].id
        selectedTitle = savedRecipes[indexPath.row].title
        selectedImage = savedRecipes[indexPath.row].image
        selectedPrepTime = savedRecipes[indexPath.row].prepTime
        selectedHealth = savedRecipes[indexPath.row].calories

//        router?.navigateToDetailPage(with: Int(selectedId ?? 0), selectedTitle: selectedTitle ?? "hello", selectedImage: selectedImage ??  "hi" , selectedPrepTime: selectedPrepTime ?? 0,selectedHealth: Int(selectedHealth ?? 0))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
}
