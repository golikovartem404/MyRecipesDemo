//
//  Router.swift
//  MyRecipes
//
//  Created by User on 06.12.2022.
//

import UIKit

protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: BuilderProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
    func initialViewController()
    func showDetailedPerson(recipe: RecipeListElement)
}

final class Router: RouterProtocol {

    var navigationController: UINavigationController?
    var assemblyBuilder: BuilderProtocol?

    init(navigationController: UINavigationController, assemblyBuilder: BuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }

    func initialViewController() {
        if let navigationController = navigationController {
            guard let mainViewController = assemblyBuilder?.createMainModule(router: self) else { return }
            navigationController.viewControllers = [mainViewController]
        }
    }

    func showDetailedPerson(recipe: RecipeListElement) {
        if let navigationController = navigationController {
            guard let detailedViewController = assemblyBuilder?.createDetailedModule(recipe: recipe, router: self) else { return }
            navigationController.pushViewController(detailedViewController, animated: true)
        }
    }
}
