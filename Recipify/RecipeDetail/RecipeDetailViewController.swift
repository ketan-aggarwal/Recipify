//
//  RecipeDetailViewController.swift
//  Recipify
//
//  Created by Ketan Aggarwal on 25/01/24.


import UIKit
import CoreData
//import Swift_PageMenu

class RecipeDetailViewController: UIViewController, PageMenuHeightViewControllerDelegate, UIScrollViewDelegate{
    
    
   // static var itemId: Int?
    static var recipe: String?
    static var image: String?
    static var prep : Int?
    static var score: Int?
    var currHeight: CGFloat = 0.0
    var interactor : RecipeDetailInteractor?
    var isSavedInCoreData: Bool = false
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var prepTime: UILabel!
    @IBOutlet weak var pagingView: UIView!
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var calories: UILabel!
    @IBOutlet weak var servings: UILabel!
    @IBOutlet weak var childView: UIView!
    
    @IBOutlet weak var crossBtn: UIButton!
    @IBOutlet weak var LayoutContraintPageViewHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Recipe detail Controllr")
        
        let childController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PageMenuViewController") as! PageMenuViewController
        childController.heightDelegate = self
        print("interactor set\(interactor?.itemID)")
        if let itemID = interactor?.itemID{
            
            childController.itemID = itemID
        }
        
        if let itemID = interactor?.itemID {
                    isSavedInCoreData = isRecipeSavedInCoreData(recipeID: itemID)
                    updateLikeButtonAppearance()
                }
        addChild(childController)
        print("Interactor set in router: \(interactor)")
        scrollView.delegate = self
        pagingView.addSubview(childController.view)
        childController.didMove(toParent: self)
        recipeTitle.text = RecipeDetailViewController.recipe
        prepTime.text = "Prep Time: \(RecipeDetailViewController.prep ?? 0) min."
        calories.text = "Calories: \(RecipeDetailViewController.score ?? 0) "
        if let imageUrlString = RecipeDetailViewController.image, let imageUrl = URL(string: imageUrlString) {
            imageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder"))
        }
    
        
    }
//    @IBAction func crossBtnTapped(_ sender: Any) {
//        dismiss(animated: true)
//    }
    
    
    func isRecipeSavedInCoreData(recipeID: Int) -> Bool {
            let context = CoreDataStack.shared.managedObjectContext
            let fetchRequest: NSFetchRequest<SavedRecipe> = SavedRecipe.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %d", recipeID)
            
            do {
                let results = try context.fetch(fetchRequest)
                return !results.isEmpty // Return true if the recipe exists in CoreData
            } catch {
                print("Error fetching recipe from CoreData: \(error)")
                return false
            }
        }
        
        // Method to update the appearance of the like button based on CoreData status
        func updateLikeButtonAppearance() {
            let symbolName = isSavedInCoreData ? "heart.fill" : "heart"
            let image = UIImage(systemName: symbolName)?.withRenderingMode(.alwaysTemplate)
            likeBtn.setImage(image, for: .normal)
            likeBtn.tintColor = isSavedInCoreData ? UIColor.green : UIColor.lightGray
        }
    
    func pageMenuViewController(_ controller: PageMenuViewController, didSelectPageWithHeight height: CGFloat) {
        currHeight = height
        LayoutContraintPageViewHeight.constant = height
        self.view.layoutIfNeeded()
        self.view.layoutSubviews()
        print("currHeigt\(currHeight)")
    }
    

    @IBAction func likeBtnTapped(_ sender: Any) {
        isSavedInCoreData.toggle()
           updateLikeButtonAppearance()
           
           if isSavedInCoreData {
               guard let itemID = interactor?.itemID else { return }
               saveRecipeToCoreData(recipeID: itemID)
           } else {
               guard let itemID = interactor?.itemID else { return }
               deleteRecipeFromCoreData(recipeID: itemID)
           }
    }
    
    func saveRecipeToCoreData(recipeID: Int) {
        let context = CoreDataStack.shared.managedObjectContext
        let savedRecipe = SavedRecipe(context: context)
        savedRecipe.title = RecipeDetailViewController.recipe
        savedRecipe.prepTime = RecipeDetailViewController.prep != nil ? "Prep Time: \(RecipeDetailViewController.prep!) min." : nil
        savedRecipe.id = Int64(recipeID)
        savedRecipe.calories = Int16(RecipeDetailViewController.score ?? 0)
        savedRecipe.image = RecipeDetailViewController.image ?? ""
        
        do {
            try context.save()
            print("Recipe saved to CoreData.")
        } catch {
            print("Error saving recipe to CoreData: \(error)")
        }
    }

    func deleteRecipeFromCoreData(recipeID: Int) {
        let context = CoreDataStack.shared.managedObjectContext
        
        let fetchRequest: NSFetchRequest<SavedRecipe> = SavedRecipe.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", recipeID)
        
        do {
            let results = try context.fetch(fetchRequest)
            if let recipeToDelete = results.first {
                context.delete(recipeToDelete)
                try context.save()
                print("Recipe deleted from CoreData.")
            }
        } catch {
            print("Error deleting recipe from CoreData: \(error)")
        }
    }
}







