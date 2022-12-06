//
//  DetailsViewModel.swift
//  MyRecipes
//
//  Created by User on 06.12.2022.
//

import Foundation

protocol DetailesViewModelProtocol: AnyObject {
    init(recipe: RecipeListElement)
    var recipeName: String { get }
    var imageData: [String?] { get }
    var recipeDifficulty: String { get }
    var recipeInstructions: String { get }
    func cellViewModel(at indexPath: IndexPath) -> ImageCellViewModelProtocol
}

class DetailesViewModel: DetailesViewModelProtocol {

    private let recipe: RecipeListElement

    required init(recipe: RecipeListElement) {
        self.recipe = recipe
    }

    var recipeName: String {
        return recipe.name
    }

    var imageData: [String?] {
        return recipe.images
    }

    var recipeDifficulty: String {
        return "Difficulty: \(recipe.difficulty)/5"
    }

    var recipeInstructions: String {
        let instructions = recipe.instructions
        let updatedInstruction = instructions.replacingOccurrences(of: "<br>", with: "\n")
        return updatedInstruction
    }

    func cellViewModel(at indexPath: IndexPath) -> ImageCellViewModelProtocol {
        let imageURL = imageData[indexPath.row] ?? ""
        return ImageCellViewModel(imageURL: imageURL)
    }
}
