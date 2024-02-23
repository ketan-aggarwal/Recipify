//
//  ShimmeringTableViewCell.swift
//  Recipify
//
//  Created by Ketan Aggarwal on 09/02/24.
//

import UIKit

class ShimmeringTableViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var shimmerCalories: UILabel!
    @IBOutlet weak var shimmerPrepTime: UILabel!
    @IBOutlet weak var shimmerTitle: UILabel!
    @IBOutlet weak var shimmerImage: UIImageView!
    
    let gradientLayer = CAGradientLayer()
    var gradientColorOne : CGColor = UIColor(white: 0.6, alpha: 1.0).cgColor
    var gradientColorTwo : CGColor = UIColor(white: 0.8, alpha: 1.0).cgColor
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
        startAnimating()
    }
    

    
    func startAnimating() {
    
      gradientLayer.frame = self.bounds
   
      gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
      gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
      gradientLayer.colors = [gradientColorOne, gradientColorTwo,   gradientColorOne]
      gradientLayer.locations = [0.0, 0.5, 1.0]
    
      self.layer.addSublayer(gradientLayer)
        
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [-1.0, -0.5, 0.0]
        animation.toValue = [1.0, 1.5, 2.0]
        animation.duration = 8
        animation.repeatCount = .infinity
        gradientLayer.add(animation, forKey: animation.keyPath)
       
    }
       
       func stopShimmerAnimation() {
           gradientLayer.removeAllAnimations()
       }
    
}
