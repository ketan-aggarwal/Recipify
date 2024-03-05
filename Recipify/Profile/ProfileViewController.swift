//
//  ProfileViewController.swift
//  Recipify
//
//  Created by Ketan Aggarwal on 12/02/24.
//

import UIKit

protocol EditProfileViewControllerDelegate: AnyObject {
    func didUpdateFullName(_ fullName: String)
}

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var profileTable: UITableView!
    
    var discoverRouter: DiscoverRouter?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabe()
        setupCycle()
        
    }
    
    func setupCycle(){
        let router = DiscoverRouter()
        let viewController = self
        viewController.discoverRouter = router
        router.viewController = viewController
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
            cell.router = discoverRouter
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "RestrictionCell", for: indexPath) as! RestrictionsCell
            return cell
        }
    }
    
    
//    func didUpdateFullName(_ fullName: String) {
//        if let headerCell = profileTable.cellForRow(at: IndexPath(row: 0, section: 0)) as? ProfileHeaderCell {
//            headerCell.userLabel.text = fullName
//            headerCell.userImg =
//
//        }
//    }
    func didUpdateFullName(_ fullName: String) {
        if let headerCell = profileTable.cellForRow(at: IndexPath(row: 0, section: 0)) as? ProfileHeaderCell {
//            headerCell.userLabel.text = fullName
            headerCell.userLabel.text = ""
            print("ImageFullName\(fullName)")
            
            let firstLetter = fullName.prefix(1)
            print("FirstLetter\(firstLetter)")
            
            // Generate or find an image representing the first letter
            let letterImage = imageFromText(text: String(firstLetter), font: UIFont.systemFont(ofSize: 30), size: CGSize(width: 50, height: 50), color: UIColor.black)
            
            // Set the image to the header cell's user image view
            headerCell.userImg.image = letterImage
        }
    }

    // Function to generate an image from a given text
    func imageFromText(text: String, font: UIFont, size: CGSize, color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        text.draw(in: rect, withAttributes: [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: color])
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }


    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row{
        case 0:
            return 100
        case 1:
            return RecipeCell.cellHeight - 20
        default:
            return 200
        }
    }
    
    

}
