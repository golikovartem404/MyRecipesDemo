//
//  RecipeTableViewCell.swift
//  MyRecipes
//
//  Created by User on 05.12.2022.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {

    static let identifier = "RecipeCell"

    var viewModel: RecipeCellViewModelProtocol? {
        didSet {
            title.text = viewModel?.recipeName
            recipeDescription.text = viewModel?.description
            if let url = viewModel?.imageURL {
                recipeImage.sd_setImage(with: url)
            }
        }
    }

    lazy var recipeImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 8
        image.clipsToBounds = true
        return image
    }()

    lazy var title: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .black
        label.numberOfLines = 2
        label.textAlignment = .left
        return label
    }()

    lazy var recipeDescription: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        setupHierarchy()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupHierarchy() {
        addSubview(title)
        addSubview(recipeImage)
        addSubview(recipeDescription)
    }

    private func setupLayout() {
        title.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(20)
            make.leading.equalTo(self.snp.leading).offset(25)
            make.trailing.equalTo(recipeImage.snp.leading).offset(-10)
        }

        recipeImage.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(5)
            make.bottom.equalTo(self.snp.bottom).offset(-5)
            make.centerY.equalTo(self.snp.centerY)
            make.trailing.equalTo(self.snp.trailing).offset(-25)
            make.width.equalTo(100)
        }

        recipeDescription.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(10)
            make.leading.equalTo(title.snp.leading)
            make.trailing.equalTo(recipeImage.snp.leading).offset(-10)
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        title.text = nil
        recipeImage.image = nil
    }

}
