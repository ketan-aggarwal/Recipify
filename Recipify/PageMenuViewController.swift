//
//  PageMenuViewController.swift
//  Recipify
//
//  Created by Ketan Aggarwal on 06/02/24.
//

import Foundation
import UIKit
import Swift_PageMenu

protocol PageMenuHeightViewControllerDelegate: AnyObject {
    
    func pageMenuViewController(_ controller: PageMenuViewController, didSelectPageWithHeight height: CGFloat)
}


class PageMenuViewController: PageMenuController, PageMenuControllerDelegate {
    
    var itemID: Int?
    
    let items: [[String]] = [["Instructions"], ["Ingredients"], ["Similar Recipes"]]
    let titles: [String] = ["Instructions", "Ingredients","Similar Recipes"]
    var currentPageHeight: CGFloat = 0.0
    var ingridentHeight: CGFloat = 0.0
    var instructionHeight: CGFloat = 0.0
    var similarRecipeHeight: CGFloat = 0.0
    weak var heightDelegate: PageMenuHeightViewControllerDelegate?
    var selectedViewController: UIViewController?
    
    lazy var instructionsViewController: RecipeInstructionViewController = {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RecipeInstructionViewController") as! RecipeInstructionViewController
        let instructionInteractor = RecipeInstructionInteractor(itemID: self.itemID ?? 0)
        viewController.interactor = instructionInteractor
        viewController.setupCycle()
        viewController.delegate = self
        
        return viewController
    }()
    
    lazy var ingredientsViewController: RecipeIngrdientsViewController = {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RecipeIngrdientsViewController") as! RecipeIngrdientsViewController
       
        let ingridientInteractor = RecipeIngridientInteractor(itemID: self.itemID ?? 0 )
        viewController.interactor = ingridientInteractor
        viewController.setupCycle()
        viewController.delegate = self
        return viewController
    }()
    
    lazy var similarRecipeViewController: SimilarRecipesViewController = {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SimilarRecipeViewController") as! SimilarRecipesViewController
        let similarRecipeInteractor = SimilarRecipesInteractor(itemID: self.itemID ?? 0)
        viewController.interactor = similarRecipeInteractor
        viewController.setupCycle()
        viewController.delegate = self
        return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.dataSource = self
        
    }
    
    
    func pageMenuController(_ pageMenuController: PageMenuController, didSelectMenuItem index: Int, direction: PageMenuNavigationDirection) {
        switch index {
        case 0:
            currentPageHeight = instructionHeight
        case 1:
            currentPageHeight = ingridentHeight
        case 2:
//            currentPageHeight = similarRecipeHeight
//            print("currentHeight\(currentPageHeight)")
            currentPageHeight = 670
        default:
            currentPageHeight = 0
        }
        
        heightDelegate?.pageMenuViewController(self, didSelectPageWithHeight: currentPageHeight)
    }
    
}

extension PageMenuViewController: PageMenuControllerDataSource {
    
    func viewControllers(forPageMenuController pageMenuController: PageMenuController) -> [UIViewController] {
        return [instructionsViewController, ingredientsViewController, similarRecipeViewController]
    }
    
    
    func menuTitles(forPageMenuController pageMenuController: PageMenuController) -> [String] {
        return ["Instructions", "Ingredients", "Similar Recipes"]
    }
    
    func defaultPageIndex(forPageMenuController pageMenuController: PageMenuController) -> Int {
        return 0
    }
}

extension PageMenuViewController: RecipeInstructionDelegate ,RecipeIngridientDelegate, SimilarRecipeDelegate{
    func SimilarRecipeTableHeightDidChange(height: CGFloat) {
        print("SimilarRecipe Table Height\(height)")
        similarRecipeHeight = height
        
    }
    
    func ingridientTableHeightDidChange(height: CGFloat) {
        print("IngridientTable Height\(height)")
        ingridentHeight = height
    }
    
    func instructionTableHeightDidChange(height: CGFloat) {
        print("InstructionTable height\(height)")
        instructionHeight = height
        heightDelegate?.pageMenuViewController(self, didSelectPageWithHeight: instructionHeight)
    }
    
}


