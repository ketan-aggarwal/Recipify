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
        textFieldSearch.attributedPlaceholder = NSAttributedString(string: "find recipes by cuisine, category, and ingredients...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])

    }
    
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//           // Clear placeholder text when the text field is selected
//        textField.placeholder = nil
//       }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            // Dismiss the keyboard when return key is pressed
            textField.resignFirstResponder()
            
            // Perform the desired action here
            print("Text entered: \(textField.text ?? "")")
            
            // Return false to not process any further
            return false
        }
    
}
