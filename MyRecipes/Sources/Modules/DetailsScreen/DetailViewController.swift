//
//  DetailViewController.swift
//  MyRecipes
//
//  Created by User on 05.12.2022.
//

import UIKit

final class DetailViewController: UIViewController {

    // MARK: - Properties

    var viewModel: DetailesViewModelProtocol? {
        didSet {
            recipeTitle.text = viewModel?.recipeName
            difficultyTitle.text = viewModel?.recipeDifficulty
            instructionsDescription.text = viewModel?.recipeInstructions
        }
    }

    // MARK: - Outlets

    private lazy var scroll: UIScrollView = {
        let scroll = UIScrollView()
        scroll.backgroundColor = .white
        return scroll
    }()

    private lazy var imageCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        let collection = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collection.register(
            ImageCollectionViewCell.self,
            forCellWithReuseIdentifier: ImageCollectionViewCell.identifier
        )

        collection.isPagingEnabled = true
        collection.showsHorizontalScrollIndicator = false
        collection.delegate = self
        collection.dataSource = self
        return collection
    }()

    private lazy var imageIndicator: UIPageControl = {
        let control = UIPageControl()
        if viewModel?.imageData.count ?? 0 > 1 {
            control.numberOfPages = viewModel?.imageData.count ?? 0
        } else {
            control.numberOfPages = 0
        }
        return control
    }()

    private lazy var recipeImage: UIImageView = {
        let image = UIImageView()
        return image
    }()

    private lazy var recipeTitle: UILabel = {
        let label = UILabel(textColor: .black)
        label.font = UIFont.systemFont(
            ofSize: Constants.FonSize.titleFontSize,
            weight: .bold
        )
        label.numberOfLines = 0
        return label
    }()

    private lazy var difficultyTitle: UILabel = {
        let label = UILabel(textColor: .black)
        return label
    }()

    private lazy var instructionsTitle: UILabel = {
        let label = UILabel(textColor: .black)
        label.text = Constants.Strings.instructionsLabel
        return label
    }()

    private lazy var instructionsDescription: UILabel = {
        let label = UILabel(textColor: .black)
        label.font = UIFont.systemFont(
            ofSize: Constants.FonSize.descriptionFontSize,
            weight: .regular
        )
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.textAlignment = .justified
        return label
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupHierarchy()
        setupLayout()
    }

    // MARK: - ViewSetups

    private func setupView() {
        view.backgroundColor = .white
        navigationItem.largeTitleDisplayMode = .never
    }

    private func setupHierarchy() {
        view.addSubview(scroll)
        scroll.addSubview(imageCollection)
        scroll.addSubview(imageIndicator)
        scroll.addSubview(recipeTitle)
        scroll.addSubview(difficultyTitle)
        scroll.addSubview(instructionsTitle)
        scroll.addSubview(instructionsDescription)
    }

    private func setupLayout() {

        scroll.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(view)
        }

        imageCollection.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(scroll)
            make.height.equalTo(view.snp.height).multipliedBy(Constants.Constraints.imageCollectionHeight)
        }

        imageIndicator.snp.makeConstraints { make in
            make.bottom.equalTo(imageCollection.snp.bottom).offset(Constants.Constraints.imageIndicatorBottom)
            make.centerX.equalTo(imageCollection.snp.centerX)
        }

        recipeTitle.snp.makeConstraints { make in
            make.top.equalTo(imageCollection.snp.bottom).offset(Constants.Constraints.recipeTitleTop)
            make.leading.equalTo(scroll.snp.leading).offset(Constants.Constraints.recipeTitleLeading)
            make.trailing.equalTo(scroll.snp.trailing).offset(Constants.Constraints.recipeTitleTrailing)
        }

        difficultyTitle.snp.makeConstraints { make in
            make.top.equalTo(recipeTitle.snp.bottom).offset(Constants.Constraints.difficultyTitleTop)
            make.leading.equalTo(recipeTitle.snp.leading)
        }

        instructionsTitle.snp.makeConstraints { make in
            make.top.equalTo(difficultyTitle.snp.bottom).offset(Constants.Constraints.instructionsTitleTop)
            make.leading.equalTo(difficultyTitle.snp.leading)
        }

        instructionsDescription.snp.makeConstraints { make in
            make.top.equalTo(instructionsTitle.snp.bottom).offset(Constants.Constraints.instructionDescriptionTop)
            make.leading.equalTo(recipeTitle.snp.leading)
            make.trailing.equalTo(recipeTitle.snp.trailing)
            make.bottom.equalTo(scroll.snp.bottom).offset(Constants.Constraints.instructionDescriptionBottom)
            make.width.equalTo(scroll.snp.width).offset(Constants.Constraints.instructionDescriptionWidth)
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollPosition = scrollView.contentOffset.x / view.frame.width
        imageIndicator.currentPage = Int(scrollPosition)
    }

}

// MARK: - UICollectionView Extension

extension DetailViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.imageData.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ImageCollectionViewCell.identifier,
                for: indexPath
            ) as? ImageCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        cell.viewModel = viewModel?.cellViewModel(at: indexPath)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: imageCollection.frame.width, height: imageCollection.frame.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

}
