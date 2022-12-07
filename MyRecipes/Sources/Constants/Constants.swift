//
//  Constants.swift
//  MyRecipes
//
//  Created by User on 07.12.2022.
//

import UIKit

enum Constants {

    enum Strings {
        static let baseURL = "https://test.kode-t.ru/recipes"
        static let recipeCellIdentifier = "RecipeCell"
        static let imageCellIdentifier = "ImageCollectionViewCell"
        static let recipeListSearchBarPlaceholder = "Search"
        static let recipeListNavigationBarTitle = "Recipes"
        static let instructionsLabel = "Instructions:"
    }

    enum FonSize {
        static let titleFontSize: CGFloat = 22
        static let descriptionFontSize: CGFloat = 17
    }

    enum Constraints {
        // RecipeListCell Constraints
        static let recipeCellTitleTop: CGFloat = 20
        static let recipeCellTitleLeading: CGFloat = 20
        static let recipeCellTitleTrailing: CGFloat = -10
        static let recipeCellImageWidthHeight: CGFloat = 100
        static let recipeCellImageTrailing: CGFloat = -20
        static let recipeCellDescriptionTop: CGFloat = 10
        static let recipeCellDescriptionTrailing: CGFloat = -10

        // DetailScreenConstraints
        static let imageCollectionHeight: CGFloat = 0.3
        static let imageIndicatorBottom: CGFloat = -10
        static let recipeTitleTop: CGFloat = 18
        static let recipeTitleLeading: CGFloat = 25
        static let recipeTitleTrailing: CGFloat = -25
        static let difficultyTitleTop: CGFloat = 20
        static let instructionsTitleTop: CGFloat = 20
        static let instructionDescriptionTop: CGFloat = 15
        static let instructionDescriptionBottom: CGFloat = -15
        static let instructionDescriptionWidth: CGFloat = -50
    }

    enum CellSizes {
        static let recipeCellHeight: CGFloat = 110
    }
}
