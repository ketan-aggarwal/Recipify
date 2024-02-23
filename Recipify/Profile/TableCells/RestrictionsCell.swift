//
//  RestrictionsCell.swift
//  Recipify
//
//  Created by Ketan Aggarwal on 12/02/24.
//

import UIKit
import TagListView




class RestrictionsCell: UITableViewCell, TagListViewDelegate{
    
    @IBOutlet weak var healthyBtn: UISwitch!
    @IBOutlet weak var popularBtn: UISwitch!
    
    static let healthySwitchDidChangeNotification = Notification.Name("RestrictionsCell.healthySwitchDidChange")
    static let popularSwitchDidChangeNotification = Notification.Name("RestrictionsCell.popularSwitchDidChange")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureSwitches()
    }
    
    func configureSwitches() {
        healthyBtn.isOn = false
        popularBtn.isOn = false
        
        healthyBtn.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
        popularBtn.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
    }
    
    @objc func switchValueChanged(_ sender: UISwitch) {
          if sender == healthyBtn {
              NotificationCenter.default.post(name: RestrictionsCell.healthySwitchDidChangeNotification, object: sender.isOn)
          } else if sender == popularBtn {
              NotificationCenter.default.post(name: RestrictionsCell.popularSwitchDidChangeNotification, object: sender.isOn)
          }
      }
    
   
}
