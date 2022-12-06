//
//  ImageCollectionViewCell.swift
//  MyRecipes
//
//  Created by User on 06.12.2022.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {

    static let identifier = "ImageCollectionViewCell"

    var viewModel: ImageCellViewModelProtocol? {
        didSet {
            image.sd_setImage(with: URL(string: viewModel?.imageURL ?? ""))
        }
    }

    lazy var image: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupHierarchy() {
        addSubview(image)
    }

    private func setupLayout() {
        image.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(self)
        }
    }
}
