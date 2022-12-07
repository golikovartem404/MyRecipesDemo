//
//  RecipeTableViewCell.swift
//  MyRecipes
//
//  Created by User on 05.12.2022.
//

import UIKit

final class RecipeTableViewCell: UITableViewCell {

    // MARK: - Properties

    static let identifier = Constants.Strings.recipeCellIdentifier

    var viewModel: RecipeCellViewModelProtocol? {
        didSet {
            title.text = viewModel?.recipeName
            recipeDescription.text = viewModel?.description
            if let url = viewModel?.imageURL {
                recipeImage.sd_setImage(with: url)
            }
        }
    }

    // MARK: - Outlets

    lazy var recipeImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 8
        image.clipsToBounds = true
        return image
    }()

    lazy var title: UILabel = {
        let label = UILabel(textColor: .black)
        label.font = UIFont.systemFont(
            ofSize: Constants.FonSize.titleFontSize,
            weight: .semibold
        )
        label.numberOfLines = 2
        label.textAlignment = .left
        return label
    }()

    lazy var recipeDescription: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(
            ofSize: Constants.FonSize.descriptionFontSize,
            weight: .regular
        )
        label.textColor = .gray
        return label
    }()

    // MARK: - Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        setupHierarchy()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Setups

    private func setupHierarchy() {
        addSubview(title)
        addSubview(recipeImage)
        addSubview(recipeDescription)
    }

    private func setupLayout() {
        title.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(Constants.Constraints.recipeCellTitleTop)
            make.leading.equalTo(self.snp.leading).offset(Constants.Constraints.recipeCellTitleLeading)
            make.trailing.equalTo(recipeImage.snp.leading).offset(Constants.Constraints.recipeCellTitleTrailing)
        }

        recipeImage.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.trailing.equalTo(self.snp.trailing).offset(Constants.Constraints.recipeCellImageTrailing)
            make.width.height.equalTo(Constants.Constraints.recipeCellImageWidthHeight)
        }

        recipeDescription.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(Constants.Constraints.recipeCellDescriptionTop)
            make.leading.equalTo(title.snp.leading)
            make.trailing.equalTo(recipeImage.snp.leading).offset(Constants.Constraints.recipeCellDescriptionTrailing)
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        title.text = nil
        recipeImage.image = nil
    }
}
