//
//  ImageCellViewModel.swift
//  MyRecipes
//
//  Created by User on 06.12.2022.
//

import Foundation

protocol ImageCellViewModelProtocol {
    var imageURL: String? { get }
    init(imageURL: String)
}

final class ImageCellViewModel: ImageCellViewModelProtocol {
    var imageURL: String?

    required init(imageURL: String) {
        self.imageURL = imageURL
    }
}
