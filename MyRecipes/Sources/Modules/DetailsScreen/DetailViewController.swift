//
//  DetailViewController.swift
//  MyRecipes
//
//  Created by User on 05.12.2022.
//

import UIKit

class DetailViewController: UIViewController {

    var viewModel: DetailesViewModelProtocol? {
        didSet {
            recipeTitle.text = viewModel?.recipeName
            difficultyTitle.text = viewModel?.recipeDifficulty
            instructionsDescription.text = viewModel?.recipeInstructions
        }
    }

    private lazy var scroll: UIScrollView = {
        let scroll = UIScrollView()
        scroll.backgroundColor = .white
        return scroll
    }()

    private lazy var imageCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
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

    private lazy var pageIndicator: UIPageControl = {
        let pageIndicator = UIPageControl()
        pageIndicator.numberOfPages = viewModel?.imageData.count ?? 1
        return pageIndicator
    }()

    private lazy var recipeTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()

    private lazy var difficultyTitle: UILabel = {
        let label = UILabel()
        return label
    }()

    private lazy var instructionsTitle: UILabel = {
        let label = UILabel()
        label.text = "Instructions:"
        return label
    }()

    private lazy var instructionsDescription: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.textAlignment = .justified
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.largeTitleDisplayMode = .never
        setupHierarchy()
        setupLayout()
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
            make.height.equalTo(view.snp.height).multipliedBy(0.3)
        }

        imageIndicator.snp.makeConstraints { make in
            make.bottom.equalTo(imageCollection.snp.bottom).offset(-10)
            make.centerX.equalTo(imageCollection.snp.centerX)
        }

        recipeTitle.snp.makeConstraints { make in
            make.top.equalTo(imageCollection.snp.bottom).offset(18)
            make.leading.equalTo(view.snp.leading).offset(25)
            make.trailing.equalTo(view.snp.trailing).offset(-25)
        }

        difficultyTitle.snp.makeConstraints { make in
            make.top.equalTo(recipeTitle.snp.bottom).offset(20)
            make.leading.equalTo(view.snp.leading).offset(25)
        }

        instructionsTitle.snp.makeConstraints { make in
            make.top.equalTo(difficultyTitle.snp.bottom).offset(20)
            make.leading.equalTo(view.snp.leading).offset(25)
        }

        instructionsDescription.snp.makeConstraints { make in
            make.top.equalTo(instructionsTitle.snp.bottom).offset(15)
            make.leading.equalTo(scroll.snp.leading).offset(25)
            make.trailing.equalTo(scroll.snp.trailing).offset(-25)
            make.bottom.equalTo(scroll.snp.bottom).offset(-15)
            make.width.equalTo(scroll.snp.width).offset(-50)
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollPosition = scrollView.contentOffset.x / view.frame.width
        imageIndicator.currentPage = Int(scrollPosition)
    }

}

extension DetailViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.imageData.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as? ImageCollectionViewCell else { return UICollectionViewCell() }
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
