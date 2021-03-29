//
//  TabBarMenuView.swift
//  MarvelApp
//
//  Created by Jon Gonzalez on 29/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class TabBarMenuView: BaseTabBarController, TabBarMenuViewContract {

	var presenter: TabBarMenuPresenterContract!

	// MARK: - LifeCycle
    override func loadView() {
        super.loadView()
        TabBarMenuBuilder.setupPresenter(view: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.presenter.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter.viewWillAppear()
    }

    private func setupView() {
        // Para añadir los view controllers al tabBar lo iba a hacer llamando al presenter, pero como el presenter
        // no debe saber nada de la UI, por lo que ni importa UIKit, no podía añadir los tabbar item a cada controller
        // por lo que finalmente lo he hecho así, directemente en el setup.
        let collectionVC = ItemCollectionBuilder.build()
        collectionVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "house.fill"), tag: 0)
        let registerVC = RegisterFormBuilder.build()
        registerVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "book"), tag: 1)
        let photoVC = ImageSelectorBuilder.build()
        photoVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "person.crop.circle.fill"), tag: 2)
        self.viewControllers = [collectionVC, registerVC, photoVC]
    }
}
