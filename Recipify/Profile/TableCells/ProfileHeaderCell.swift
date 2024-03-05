//
//  ProfileHeaderCell.swift
//  Recipify
//
//  Created by Ketan Aggarwal on 12/02/24.
//

import UIKit

class ProfileHeaderCell: UITableViewCell, EditProfileViewControllerDelegate {
 

    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var editBtn: UIButton!
    weak var viewController: UIViewController?
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        if let fullName = UserDefaults.standard.string(forKey: "FullName") {
                    // Use the retrieved full name
                    userLabel.text = fullName
                    if let firstLetter = fullName.first {
                        let backgroundColor = UIColor(red: 155.0/255.0, green: 203.0/255.0, blue: 65.0/255.0, alpha: 1.0)
                        let letterImage = imageFromText(text: String(firstLetter), font: UIFont.systemFont(ofSize: 30), size: CGSize(width: 50, height: 50), textColor: UIColor.white, backgroundColor: backgroundColor)
                        userImg.image = letterImage
                    }
                }
    }
    
    func didUpdateFullName(_ fullName: String) {
        userLabel.text = fullName
        let firstLetter = fullName.prefix(1)
        print("FirstLetter: \(firstLetter)")
        
        let backgroundColor = UIColor(red: 155.0/255.0, green: 203.0/255.0, blue: 65.0/255.0, alpha: 1.0)
        let letterImage = imageFromText(text: String(firstLetter), font: UIFont.systemFont(ofSize: 30), size: CGSize(width: 50, height: 50), textColor: UIColor.white, backgroundColor: backgroundColor)
        userImg.image = letterImage
        
        UserDefaults.standard.set(fullName, forKey: "FullName")
    }
    
    func imageFromText(text: String, font: UIFont, size: CGSize, textColor: UIColor, backgroundColor: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        
        // Fill the background color
        backgroundColor.setFill()
        UIRectFill(rect)
        
        // Draw the text with specified attributes
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: textColor,
            .paragraphStyle: paragraphStyle
        ]
        let textSize = text.size(withAttributes: attributes)
        let textRect = CGRect(x: (size.width - textSize.width) / 2, y: (size.height - textSize.height) / 2, width: textSize.width, height: textSize.height)
        text.draw(in: textRect, withAttributes: attributes)
        
        // Create an image from context
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return image
    }
    
    @IBAction func editBtnTapped(_ sender: Any) {
       print("tapped")
        if let editProfileController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EditProfileViewController") as? EditProfileViewController {
            editProfileController.delegate = self
            viewController?.present(editProfileController, animated: true)
          
        }
        
    }
}
