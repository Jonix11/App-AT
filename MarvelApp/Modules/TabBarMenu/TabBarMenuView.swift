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
        TabBarMenuBuilder.setuupPresenter(view: self)
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

    }
}
