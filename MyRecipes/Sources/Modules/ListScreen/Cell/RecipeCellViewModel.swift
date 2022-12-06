//
//  RecipeCellViewModel.swift
//  MyRecipes
//
//  Created by User on 06.12.2022.
//

import Foundation

protocol RecipeCellViewModelProtocol: AnyObject {
    var recipeName: String { get }
    var description: String { get }
    var imageURL: URL? { get }
    var imageData: Data? { get set }
    init(recipe: RecipeListElement)
}

class RecipeCellViewModel: RecipeCellViewModelProtocol {

    private let recipe: RecipeListElement

    var recipeName: String {
        recipe.name
    }

    var description: String {
        guard let description = recipe.description else { return "" }
        return description
    }

    var imageURL: URL? {
        let url = URL(string: recipe.images.first!)
        return url
    }

    var imageData: Data?

    required init(recipe: RecipeListElement) {
        self.recipe = recipe
    }
}
