//
//  ProfileHeaderCell.swift
//  Recipify
//
//  Created by Ketan Aggarwal on 12/02/24.
//

import UIKit

class ProfileHeaderCell: UITableViewCell {
    
   
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var editBtn: UIButton!
    weak var viewController: UIViewController?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func editBtnTapped(_ sender: Any) {
       print("tapped")
        if let editProfileController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EditProfileViewController") as? EditProfileViewController {
            viewController?.present(editProfileController, animated: true)
          
        }
        
    }
}
