//
//  ProfileViewController.swift
//  Recipify
//
//  Created by Ketan Aggarwal on 12/02/24.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var profileTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabe()
    }
    

    func setupTabe(){
        profileTable.delegate = self
        profileTable.dataSource = self
        let nib = UINib(nibName: "ProfileHeaderCell", bundle: nil)
        profileTable.register(nib, forCellReuseIdentifier: "ProfileHeaderCell")
        let nib2 = UINib(nibName: "SavedRecipesCell", bundle: nil)
        profileTable.register(nib2, forCellReuseIdentifier: "SavedRecipeCell")
        let nib3 = UINib(nibName: "RestrictionsCell", bundle: nil)
        profileTable.register(nib3, forCellReuseIdentifier: "RestrictionCell")
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileHeaderCell", for: indexPath) as! ProfileHeaderCell
            cell.viewController = self
            return cell
        } else if (indexPath.row == 1){
            let cell = tableView.dequeueReusableCell(withIdentifier: "SavedRecipeCell", for: indexPath) as! SavedRecipesCell
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "RestrictionCell", for: indexPath) as! RestrictionsCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row{
        case 0:
            return 100
        case 1:
            return RecipeCell.cellHeight - 100
        default:
            return 400
        }
    }

}
