//
//  RecipesList.swift
//  MyRecipes
//
//  Created by User on 05.12.2022.
//

import Foundation

struct RecipeListResponse: Codable {
    let recipes: [RecipeListElement]
}

// MARK: - Recipe
struct RecipeListElement: Codable {
    let uuid, name: String
    let images: [String]
    let lastUpdated: Int
    let description: String?
    let instructions: String
    let difficulty: Int
}
