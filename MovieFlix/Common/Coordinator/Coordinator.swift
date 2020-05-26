//
//  Coordinator.swift
//  MovieFlix
//
//  Created by Lorrayne Paraiso on 25/05/20.
//  Copyright © 2020. All rights reserved.
//

import UIKit

protocol UpcomingCoordinatorProtocol {
    func start()
    func movieDetails(viewModel: MovieViewModel)
    var navigationController: UINavigationController { get }
}

class Coordinator: UpcomingCoordinatorProtocol {
    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.navigationBar.barStyle = .blackOpaque
        navigationController.navigationBar.tintColor = #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)
        navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }

    func start() {
        let gateway = UpcomingMoviesGatewayImpl(client: HttpClient(),
                                            adapter: UpcomingMoviesAdapterImpl())
        let presenter = UpcomingMoviesPresenterImpl()
        let interactor = UpcomingMoviesInteractorImpl(gateway: gateway, presenter: presenter)
        let viewController = UpcomingMoviesViewController(interactor: interactor, coordinator: self)
        presenter.viewController = viewController
        navigationController.pushViewController(viewController, animated: false)
    }

    func movieDetails(viewModel: MovieViewModel) {
        let viewController = MovieViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}

