//
//  EditProfileViewController.swift
//  Recipify
//
//  Created by Ketan Aggarwal on 14/02/24.
//

import UIKit

class EditProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var editProfileTable: UITableView!
    
    var viewModels: [EditProfileViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        viewModels = EditProfileViewModel.defaultViewModels()
    }
    
    func setupTable(){
        editProfileTable.delegate = self
        editProfileTable.dataSource = self
        editProfileTable.register(UINib(nibName: "EditProfileTableCell", bundle: nil), forCellReuseIdentifier: "EditTableCell")
        editProfileTable.register(UINib(nibName: "EditProfileBtnTableCell", bundle: nil), forCellReuseIdentifier: "EditProfileBtnCell")
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count + 1
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < viewModels.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EditTableCell", for: indexPath) as! EditProfileTableCell
            let viewModel = viewModels[indexPath.row]
            cell.labelTxt.text = viewModel.labelText
           
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EditProfileBtnCell", for: indexPath) as! EditProfileBtnTableCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row < viewModels.count {
            return 90
        } else {
            return 150
        }
    }
}
