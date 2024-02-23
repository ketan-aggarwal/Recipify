//
//  EditProfileViewModel.swift
//  Recipify
//
//  Created by Ketan Aggarwal on 21/02/24.
//

import Foundation

struct EditProfileViewModel {
    let labelText: String
    
    static func defaultViewModels() -> [EditProfileViewModel] {
        return [
            EditProfileViewModel(labelText: "First Name"),
            EditProfileViewModel(labelText: "Last Name"),
            EditProfileViewModel(labelText: "Email")
        ]
    }
}
