//
//  EditProfileTableCell.swift
//  Recipify
//
//  Created by Ketan Aggarwal on 21/02/24.
//

import UIKit

class EditProfileTableCell: UITableViewCell {

    
    @IBOutlet weak var labelTxt: UILabel!
    @IBOutlet weak var TextField: UITextField!
    
    var firstName: String? {
           return TextField.text
       }
       
       var lastName: String? {
           return TextField.text
       }
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

   
    
}
