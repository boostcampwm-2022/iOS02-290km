//
//  MyPageCoordinator.swift
//  Trinap
//
//  Created by ByeongJu Yu on 2022/11/19.
//  Copyright © 2022 Trinap. All rights reserved.
//

import UIKit

import FirestoreService

final class MyPageCoordinator: Coordinator {
    
    // MARK: - Properties
    weak var delegate: CoordinatorDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator]
    
    // MARK: - Initializers
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.childCoordinators = []
    }
    
    // MARK: - Methods
    func start() {
        self.showMyPageViewController()
    }
}

extension MyPageCoordinator {
    func showMyPageViewController() {
        let useCase = DefaultFetchUserUseCase(
            userRepository: DefaultUserRepository(firestoreService: DefaultFireStoreService())
        )
        let viewModel = MyPageViewModel(fetchUserUseCase: useCase)
        let viewController = MyPageViewController(viewModel: viewModel)
        viewController.coordinator = self
        self.navigationController.setNavigationBarHidden(true, animated: false)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func showNextView(state: MyPageCellType) {
        switch state {
        case .nofiticationAuthorization, .photoAuthorization, .locationAuthorization:
            showAuthorizationSetting(state: state)
        default:
            return
        }
    }
}

private extension MyPageCoordinator {
    private func showAuthorizationSetting(state: MyPageCellType) {
        guard let url = state.url else { return }
        UIApplication.shared.open(url)
    }
}
