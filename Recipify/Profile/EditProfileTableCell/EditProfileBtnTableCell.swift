//
//  EditProfileBtnTableCell.swift
//  Recipify
//
//  Created by Ketan Aggarwal on 21/02/24.
//


import UIKit

protocol EditProfileBtnTableCellDelegate: AnyObject {
    func saveButtonTapped()
}

class EditProfileBtnTableCell: UITableViewCell {

    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    
    weak var delegate: EditProfileBtnTableCellDelegate?
    
 
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func saveBtnTapped(_ sender: Any) {
        delegate?.saveButtonTapped()
    
    }
    
    @IBAction func cancelBtnTapped(_ sender: Any) {
        
    }
    
}
