//
//  ViewController.swift
//  MyRecipes
//
//  Created by User on 05.12.2022.
//

import UIKit
import SnapKit
import SDWebImage

final class RecipesListViewController: UIViewController {

    // MARK: - Properties

    var isFiltering = false
    var viewModel: RecipesListViewModel? {
        didSet {
            viewModel?.fetchRecipesData {
                DispatchQueue.main.async {
                    self.recipesTable.reloadData()
                }
            }
        }
    }

    // MARK: - Outlets

    private lazy var searchController: UISearchController = {
        let search = UISearchController(searchResultsController: nil)
        search.searchBar.placeholder = Constants.Strings.recipeListSearchBarPlaceholder
        search.searchResultsUpdater = self
        search.searchBar.delegate = self
        search.obscuresBackgroundDuringPresentation = false
        return search
    }()

    private lazy var recipesTable: UITableView = {
        let table = UITableView()
        table.backgroundColor = .white
        table.register(RecipeTableViewCell.self, forCellReuseIdentifier: RecipeTableViewCell.identifier)
        table.delegate = self
        table.dataSource = self
        return table
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
        title = Constants.Strings.recipeListNavigationBarTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        view.backgroundColor = .white
    }

    private func setupHierarchy() {
        view.addSubview(recipesTable)
    }

    private func setupLayout() {
        recipesTable.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(view)
        }
    }

}

// MARK: - UITableViewDataSource, Delegate Extension

extension RecipesListViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return viewModel?.numberOfFilteringRows() ?? 0
        } else {
            return viewModel?.numberOfRows() ?? 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecipeTableViewCell.identifier, for: indexPath) as? RecipeTableViewCell else { return UITableViewCell() }
        if isFiltering {
            cell.viewModel = viewModel?.filteredCellViewModel(at: indexPath)
        } else {
            cell.viewModel = viewModel?.cellViewModel(at: indexPath)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.CellSizes.recipeCellHeight
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if isFiltering {
            viewModel?.viewDetailScreenFilteredRow(at: indexPath)
        } else {
            viewModel?.viewDetailScreenSelectedRow(at: indexPath)
        }
    }
}

// MARK: - SearchBarDelegate Extension

extension RecipesListViewController: UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        //
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        isFiltering = true
        viewModel?.searchRecipe(withText: searchText)
        recipesTable.reloadData()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isFiltering = false
        recipesTable.reloadData()
    }
}
