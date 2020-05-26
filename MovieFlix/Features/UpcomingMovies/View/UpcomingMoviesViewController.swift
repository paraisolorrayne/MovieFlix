//
//  UpcomingMoviesViewController.swift
//  MovieFlix
//
//  Created by Lorrayne Paraiso on 25/05/20.
//  Copyright © 2020. All rights reserved.
//

import UIKit

protocol UpcomingMoviesDisplay: AnyObject {
    func displayMovies(viewModels: [MovieViewModel])
    func showDetails(viewModel: MovieViewModel)
    func showError(viewModel: ErrorViewModel)
    func tryAgain()
    func displayEndList()
}

class UpcomingMoviesViewController: UIViewController {
    private let cellIdentifier = String(describing: MovieTableViewCell.self)
    private let emptyCellIdentifier = String(describing: EmptyTableViewCell.self)
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet weak var loadingView: LoadingView!
    @IBOutlet private weak var tableView: UITableView!
    private let footerView: LoadingView = {
        let frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100)
        let footerView = LoadingView(frame: frame)
        return footerView
    }()
    private let interactor: UpcomingMoviesInteractor
    private let coordinator: UpcomingCoordinatorProtocol
    private var movies: [MovieViewModel] = []

    init(interactor: UpcomingMoviesInteractor, coordinator: UpcomingCoordinatorProtocol) {
        self.interactor = interactor
        self.coordinator = coordinator
        super.init(nibName: String(describing: UpcomingMoviesViewController.self),
                   bundle: Bundle.main)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        loadingView.show()
        interactor.listUpcomingMovies()
    }

    private func setup() {
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = self.footerView
        tableView.register(UINib(nibName: cellIdentifier, bundle: Bundle.main),
                           forCellReuseIdentifier: cellIdentifier)
        tableView.register(UINib(nibName: emptyCellIdentifier, bundle: Bundle.main),
                           forCellReuseIdentifier: emptyCellIdentifier)
    }
}

extension UpcomingMoviesViewController: UpcomingMoviesDisplay {

    func showError(viewModel: ErrorViewModel) {
        loadingView.hide()
        present(viewModel.alert, animated: true, completion: nil)
    }

    func tryAgain() {
        interactor.tryAgain()
    }

    func displayEndList() {
        footerView.hide()
    }

    func displayMovies(viewModels: [MovieViewModel]) {
        self.footerView.hide()
        self.movies = viewModels
        tableView.reloadData()
        loadingView.hide()
    }

    func showDetails(viewModel: MovieViewModel) {
        coordinator.movieDetails(viewModel: viewModel)
    }

}

extension UpcomingMoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = movies[indexPath.row]
        interactor.seeDetails(viewModel: viewModel)
    }
}

extension UpcomingMoviesViewController: UITableViewDataSource {
    func setEmptyView() {
        let emptyView = UIView(frame: CGRect(x: self.tableView.center.x, y: self.tableView.center.y, width: self.tableView.bounds.size.width, height: self.tableView.bounds.size.height))
        self.tableView.backgroundView = emptyView
        self.tableView.separatorStyle = .none
        let nibEmpty = UINib(nibName: "EmptyTableViewCell", bundle: nil)
        tableView.register(nibEmpty, forCellReuseIdentifier: emptyCellIdentifier)
        let cell = self.tableView.dequeueReusableCell(withIdentifier: emptyCellIdentifier) as! EmptyTableViewCell
        cell.frame = self.tableView.bounds
        emptyView.addSubview(cell)
    }
    func restore() {
        self.tableView.backgroundView = nil
        self.tableView.separatorStyle = .singleLine
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if movies.count == 0 {
            self.setEmptyView()
        } else {
            self.restore()
        }
        return self.movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,
                                                       for: indexPath) as? MovieTableViewCell
            else { return UITableViewCell() }
        let viewModel = movies[indexPath.row]
        cell.bind(viewModel: viewModel)
        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastMovieAtList = movies.count - 1
        if indexPath.row == lastMovieAtList  {
            self.footerView.show()
            interactor.nextMoviesPage()
        }
    }
}

extension UpcomingMoviesViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.text = ""
        self.searchBar.resignFirstResponder()
        interactor.cancelSearch()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
        self.loadingView.show()
        guard let textToSearch = searchBar.text else { return }
        let trimmedString = textToSearch.trimmingCharacters(in: .whitespacesAndNewlines)
        interactor.searchMovies(query: trimmedString)
    }
}
