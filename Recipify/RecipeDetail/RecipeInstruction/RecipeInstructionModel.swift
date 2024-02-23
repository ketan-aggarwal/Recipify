//
//  RecipeInstructionModel.swift
//  Recipify
//
//  Created by Ketan Aggarwal on 05/02/24.
//

import Foundation



struct RecipeInstruction: Codable {
    let name: String
    let steps: [[Step]]
}

struct Step: Codable {
    let equipment: [Ent]?
    let ingredients: [Ent]?
    let number: Int
    let step: String
    let length: Length?
}

struct Ent: Codable {
    let id: Int
    let image: String?
    let name: String
    let temperature: Length?
}

struct Length: Codable {
    let number: Int
    let unit: String
}

