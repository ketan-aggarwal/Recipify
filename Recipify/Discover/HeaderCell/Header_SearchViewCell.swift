//
//  Header&SearchViewCell.swift
//  Recipify
//
//  Created by Ketan Aggarwal on 29/01/24.
//

import UIKit

class Header_SearchViewCell: UITableViewCell , UITextFieldDelegate{

    @IBOutlet weak var textFieldSearch: UITextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textFieldSearch.delegate = self
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            // Dismiss the keyboard when return key is pressed
            textField.resignFirstResponder()
            
            // Perform the desired action here
            print("Text entered: \(textField.text ?? "")")
            
            // Return false to not process any further
            return false
        }
    
}
