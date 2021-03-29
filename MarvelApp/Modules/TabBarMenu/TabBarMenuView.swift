//
//  TabBarMenuView.swift
//  MarvelApp
//
//  Created by Jon Gonzalez on 29/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class TabBarMenuView: BaseViewController, TabBarMenuViewContract {

	var presenter: TabBarMenuPresenterContract!

	// MARK: - LifeCycle
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
