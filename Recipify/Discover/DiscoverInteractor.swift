//
//  DiscoverInteractor.swift
//  Recipify
//
//  Created by Ketan Aggarwal on 31/01/24.
//

import Foundation
import UIKit

protocol DiscoverRecipesBusinessLogic {
    func fetchRecipes(query: String, type: String)
}

protocol DiscoverRecipesDataStore {
    var recipeCategories: [[RecipeElement]] {get set}
}

class DiscoverInteractor: DiscoverRecipesBusinessLogic, DiscoverRecipesDataStore {
    
    var recipeCategories: [[RecipeElement]] = []
    var worker: DiscoverRecipesWorker?
    var presenter: DashBoardPresenter?
    var numberOfExpectedCategories = 4
    var isHealthy = false {
        didSet {
            print("Healthy: \(isHealthy)")
            checkAndPresentData()
        }
    }
    var isPopular = false {
        didSet {
            print("Popular: \(isPopular)")
            checkAndPresentData()
        }
    }
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleHealthySwitchDidChange(_:)), name: RestrictionsCell.healthySwitchDidChangeNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handlePopularSwitchDidChange(_:)), name: RestrictionsCell.popularSwitchDidChangeNotification, object: nil)
    }
    
    
    @objc func handlePopularSwitchDidChange(_ notification: Notification) {
        if let isPopular = notification.object as? Bool {
            self.isPopular = isPopular
            
        }
    }
    
    @objc func handleHealthySwitchDidChange(_ notification: Notification) {
        if let isHealthy = notification.object as? Bool {
            self.isHealthy = isHealthy
        }
    }
    
    
    
    func fetchRecipes(query: String, type: String) {
        worker?.fetchRecipes(query: query) { [weak self] fetchedRecipes in
            var categoryIndex = 0
            
            switch type {
            case "vegan":
                categoryIndex = 0
            case "desserts":
                categoryIndex = 1
            case "salad":
                categoryIndex = 2
            case "StirFry":
                categoryIndex = 3
            default:
                break
            }
            
            while self?.recipeCategories.count ?? 0 <= categoryIndex {
                self?.recipeCategories.append([])
            }
            
            self?.recipeCategories[categoryIndex] = fetchedRecipes ?? []
            
            if self?.recipeCategories.count == self?.numberOfExpectedCategories {
                self?.checkAndPresentData()
                
            }
            
        }
    }
    
    private func checkAndPresentData() {
        if isHealthy || isPopular {
            presenter?.presentFilteredData(isHealthy: isHealthy, isPopular: isHealthy, recipeCategories: recipeCategories)
        } else {
            presenter?.presentFetchedData(recipeCategories: recipeCategories)
        }
    }
    
}
