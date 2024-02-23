//
//  DiscoverRecipeRouter.swift
//  Recipify
//
//  Created by Ketan Aggarwal on 05/02/24.
//

import Foundation
import UIKit

protocol DiscoverRecipePrototcol {
    func navigateToDetailPage(with itemId: Int, selectedTitle: String, selectedImage: String, selectedPrepTime: Int, selectedHealth: Int)
}

class DiscoverRouter: DiscoverRecipePrototcol {
    weak var viewController: UIViewController?

    func navigateToDetailPage(with itemId: Int, selectedTitle: String, selectedImage: String, selectedPrepTime: Int, selectedHealth: Int) {
        if let detailRecipeController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RecipeDetailViewController") as? RecipeDetailViewController {

            RecipeDetailViewController.recipe = selectedTitle
            RecipeDetailViewController.image = selectedImage
            RecipeDetailViewController.prep = selectedPrepTime
            RecipeDetailViewController.score = selectedHealth
            
            let interactor = RecipeDetailInteractor(itemID: itemId)
            detailRecipeController.interactor = interactor
            viewController?.present(detailRecipeController, animated: true, completion: nil)
        }
    }
}

