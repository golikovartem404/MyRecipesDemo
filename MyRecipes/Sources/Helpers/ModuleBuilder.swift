//
//  ModuleBuilder.swift
//  MyRecipes
//
//  Created by User on 06.12.2022.
//

import UIKit

protocol BuilderProtocol {
    func createMainModule(router: RouterProtocol) -> UIViewController
    func createDetailedModule(recipe: RecipeListElement, router: RouterProtocol) -> UIViewController
}

final class ModuleBuilder: BuilderProtocol {

    func createMainModule(router: RouterProtocol) -> UIViewController {
        let view = RecipesListViewController()
        view.viewModel = RecipesListViewModel(router: router)
        return view
    }

    func createDetailedModule(recipe: RecipeListElement, router: RouterProtocol) -> UIViewController {
        let view = DetailViewController()
        view.viewModel = DetailesViewModel(recipe: recipe)
        return view
    }
}
