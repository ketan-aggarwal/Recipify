//
//  RecipeCell.swift
//  Recipify
//
//  Created by Ketan Aggarwal on 29/01/24.
//

import UIKit
import SDWebImage
import CoreData

class RecipeCell: UICollectionViewCell {
    
    static let cellID = "RecipeCellID"
    static let cellHeight: CGFloat = 370.0
    static let cellWidth: CGFloat = 360.0
    static let cellPadding: CGFloat = 10.0
    let colorSchemeGreen = UIColor(red: 153, green: 204, blue: 51, alpha: 1)
    let lightTextColor = UIColor(red: 164, green: 165, blue: 166, alpha: 1)
    var isSaved = false
    var recipeItem: CollectionRecipeViewItem?
    
    @IBOutlet weak var savedButton: UIButton!
    @IBOutlet weak var prepTime: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var rating: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        savedButton.addTarget(self, action: #selector(savedButtonTapped), for: .touchUpInside)
    }
    
//    func configure(withRecipeItem recipeItem: CollectionRecipeViewItem) {
//        self.recipeItem = recipeItem
//        titleLabel.text = recipeItem.title
//        prepTime.text = "Prep Time: \(recipeItem.readyInMinutes ?? 0) mins"
//        rating.text = "Rating: \(recipeItem.healthScore ?? 0)"
//        if let imageUrlString = recipeItem.image, let imageUrl = URL(string: imageUrlString) {
//            imageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder"))
//        }
//    }
    
    func configure(withRecipeItem recipeItem: CollectionRecipeViewItem) {
        self.recipeItem = recipeItem
        titleLabel.text = recipeItem.title
        prepTime.text = "Prep Time: \(recipeItem.readyInMinutes ?? 0) mins"
        rating.text = "Rating: \(recipeItem.healthScore ?? 0)"
        if let imageUrlString = recipeItem.image, let imageUrl = URL(string: imageUrlString) {
            imageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder"))
        }
        
        // Check if the recipe exists in CoreData
        if isRecipeSavedInCoreData(recipeItem: recipeItem) {
            // Recipe exists, set the button's image to filled heart
            savedButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            savedButton.tintColor = UIColor.green
            isSaved = true
        } else {
            // Recipe doesn't exist, set the button's image to empty heart
            savedButton.setImage(UIImage(systemName: "heart"), for: .normal)
            savedButton.tintColor = UIColor.lightGray
            isSaved = false
        }
    }
    
    func isRecipeSavedInCoreData(recipeItem: CollectionRecipeViewItem) -> Bool {
        let context = CoreDataStack.shared.managedObjectContext
        let fetchRequest: NSFetchRequest<SavedRecipe> = SavedRecipe.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", recipeItem.id ?? -1)
        
        do {
            let results = try context.fetch(fetchRequest)
            return !results.isEmpty // Return true if the recipe exists in CoreData
        } catch {
            print("Error fetching recipe from CoreData: \(error)")
            return false
        }
    }
    
    @objc func savedButtonTapped() {
        isSaved.toggle()
        let symbolName = isSaved ? "heart.fill" : "heart"
        let image = UIImage(systemName: symbolName)?.withRenderingMode(.alwaysTemplate)
        savedButton.setImage(image, for: .normal)
        savedButton.tintColor = isSaved ? UIColor.green : UIColor.lightGray
        
        if isSaved{
            guard let recipeItem = self.recipeItem else {
                return
            }
            saveRecipeToCoreData(recipeItem: recipeItem)
        }else{
            deleteRecipeFromCoreData()
        }
        
    }
    
    func saveRecipeToCoreData(recipeItem: CollectionRecipeViewItem) {
        let context = CoreDataStack.shared.managedObjectContext
        let fetchRequest: NSFetchRequest<SavedRecipe> = SavedRecipe.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", recipeItem.id ?? -1)

        do {
            let results = try context.fetch(fetchRequest)
            if results.isEmpty {
                // Recipe does not exist in CoreData, so save it
                let savedRecipe = SavedRecipe(context: context)
                savedRecipe.title = recipeItem.title
                
                savedRecipe.prepTime = Int64(recipeItem.readyInMinutes ?? 0)

                if let id = recipeItem.id {
                    savedRecipe.id = Int64(id)
                }
                //savedRecipe.calories = Int16(recipeItem.healthScore ?? 0)
                savedRecipe.calories = Int64(recipeItem.healthScore ?? 0)
                savedRecipe.image = recipeItem.image ?? ""
                try context.save()
            } else {
                // Recipe already exists in CoreData, do nothing
                print("Recipe with ID \(recipeItem.id ?? -1) already exists in CoreData")
            }
        } catch {
            print("Error saving or fetching recipe from CoreData: \(error)")
        }
    }

//    func saveRecipeToCoreData(recipeItem: CollectionRecipeViewItem) {
//        let context = CoreDataStack.shared.managedObjectContext
//        let fetchRequest: NSFetchRequest<SavedRecipe> = SavedRecipe.fetchRequest()
//        fetchRequest.predicate = NSPredicate(format: "id == %d", recipeItem.id ?? -1)
//
//        do {
//            let results = try context.fetch(fetchRequest)
//            if results.isEmpty {
//                // Recipe does not exist in CoreData, so save it
//                let savedRecipe = SavedRecipe(context: context)
//                savedRecipe.title = recipeItem.title
//                savedRecipe.prepTime = recipeItem.readyInMinutes != nil ? "Prep Time: \(recipeItem.readyInMinutes!) mins" : nil
//                savedRecipe.prepTime
//
//                if let id = recipeItem.id {
//                    savedRecipe.id = Int64(id)
//                }
//                savedRecipe.calories = Int16(recipeItem.healthScore ?? 0)
//                savedRecipe.image = recipeItem.image ?? ""
//                try context.save()
//            } else {
//                // Recipe already exists in CoreData, do nothing
//                print("Recipe with ID \(recipeItem.id ?? -1) already exists in CoreData")
//            }
//        } catch {
//            print("Error saving or fetching recipe from CoreData: \(error)")
//        }
//    }

   
    
    func deleteRecipeFromCoreData(){
        let context = CoreDataStack.shared.managedObjectContext
        guard let recipeItem = self.recipeItem else {
            return
        }
        
        let fetchRequest: NSFetchRequest<SavedRecipe> = SavedRecipe.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", recipeItem.id ?? -1)
        
        do {
            let results = try context.fetch(fetchRequest)
            if let recipeToDelete = results.first {
                context.delete(recipeToDelete)
                try context.save()
            }
        } catch {
            print("Error deleting recipe from CoreData: \(error)")
        }
        
    }
}
