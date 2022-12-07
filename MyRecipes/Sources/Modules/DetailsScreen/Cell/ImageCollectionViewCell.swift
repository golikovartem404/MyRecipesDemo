//
//  ImageCollectionViewCell.swift
//  MyRecipes
//
//  Created by User on 06.12.2022.
//

import UIKit

final class ImageCollectionViewCell: UICollectionViewCell {

    // MARK: - Properties

    static let identifier = Constants.Strings.imageCellIdentifier

    var viewModel: ImageCellViewModelProtocol? {
        didSet {
            image.sd_setImage(with: URL(string: viewModel?.imageURL ?? ""))
        }
    }

    // MARK: - Outlets

    lazy var image: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - ViewSetups

    private func setupHierarchy() {
        addSubview(image)
    }

    private func setupLayout() {
        image.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(self)
        }
    }
}
