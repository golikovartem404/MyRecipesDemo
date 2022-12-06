//
//  RecipeListViewModel.swift
//  MyRecipes
//
//  Created by User on 06.12.2022.
//

import Foundation

protocol RecipesListViewModelProtocol: AnyObject {
    var recipes: [RecipeListElement] { get }
    var filteredRecipes: [RecipeListElement]? { get set }
    func fetchRecipesData(completion: @escaping() -> Void)
    func numberOfRows() -> Int
    func cellViewModel(at indexPath: IndexPath) -> RecipeCellViewModelProtocol
    func filteredCellViewModel(at indexPath: IndexPath) -> RecipeCellViewModelProtocol?
    func viewDetailScreenSelectedRow(at indexPath: IndexPath)
    func viewDetailScreenFilteredRow(at indexPath: IndexPath)
    func searchRecipe(withText text: String)
}

class RecipesListViewModel: RecipesListViewModelProtocol {

    var recipes: [RecipeListElement] = []
    var filteredRecipes: [RecipeListElement]?
    var router: RouterProtocol?

    init(router: RouterProtocol) {
        self.router = router
    }

    func fetchRecipesData(completion: @escaping() -> Void) {
        NetworkTask.shared.getAllRecipes { result in
            switch result {
            case .success(let data):
                self.recipes = data.recipes
                completion()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func numberOfRows() -> Int {
        return recipes.count
    }

    func numberOfFilteringRows() -> Int {
        return filteredRecipes?.count ?? 0
    }

    func cellViewModel(at indexPath: IndexPath) -> RecipeCellViewModelProtocol {
        let recipeElement = recipes[indexPath.row]
        return RecipeCellViewModel(recipe: recipeElement)
    }

    func filteredCellViewModel(at indexPath: IndexPath) -> RecipeCellViewModelProtocol? {
        if let recipeElement = filteredRecipes?[indexPath.row] {
            return RecipeCellViewModel(recipe: recipeElement)
        }
        return nil
    }

    func viewDetailScreenSelectedRow(at indexPath: IndexPath) {
        let recipeElement = recipes[indexPath.row]
        router?.showDetailedPerson(recipe: recipeElement)
    }

    func viewDetailScreenFilteredRow(at indexPath: IndexPath) {
        if let recipeElement = filteredRecipes?[indexPath.row] {
            router?.showDetailedPerson(recipe: recipeElement)
        }
    }

    func searchRecipe(withText text: String) {
        if text == "" {
            filteredRecipes = recipes
        } else {
            filteredRecipes = recipes.filter({ $0.name.lowercased().contains(text.lowercased())})
        }
    }
}
