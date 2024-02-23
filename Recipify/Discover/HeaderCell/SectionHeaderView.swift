//
//  SectionHeaderView.swift
//  Recipify
//
//  Created by Ketan Aggarwal on 03/02/24.
//

import UIKit

class SectionHeaderView: UIView {
    
    
    @IBOutlet weak var LabelsectionHeader: UILabel!
    @IBOutlet weak var BtnSeeAll: UIButton!
    var searchText = ""
    
    @IBAction func seeAllButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
              if let fetchRecipeViewController = storyboard.instantiateViewController(withIdentifier: "FetchRecipeViewController") as? FetchRecipeViewController {
                  // Present the FetchRecipeViewController modally
                  fetchRecipeViewController.searchText = searchText
                  if let rootViewController = UIApplication.shared.keyWindow?.rootViewController {
                      rootViewController.present(fetchRecipeViewController, animated: true, completion: nil)
                  }
              }
        print("button clickeed")
        
    }
}
