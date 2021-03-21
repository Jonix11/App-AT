//
//  CharacterListView.swift
//  MarvelApp
//
//  Created by Jon Gonzalez on 21/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class CharacterListView: BaseViewController, CharacterListViewContract {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    var datasource: CharacterListDatasource!
    // swiftlint:disable:next weak_delegate
    var delegate: CharacterListDelegate!

	var presenter: CharacterListPresenterContract!

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
        datasource = CharacterListDatasource()
        delegate = CharacterListDelegate()
        tableView.dataSource = datasource
        tableView.delegate = delegate
    }
    
    // MARK: - Public methods
    func updateCharacterListData(with character: [Character]) {
        self.datasource.characters = character
        self.tableView.reloadData()
    }
}

class CharacterListDatasource: NSObject, UITableViewDataSource {
    var characters = [Character]()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let character = characters[indexPath.row]
        let cellId = "CharacterCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
        }
        
        cell?.textLabel?.text = character.name
        print(character.image)
        
        // En este caso hago el unwrap forzado porque sé que va a haber una celda, ya que si no tiene ninguna para reusar
        // la creo yo del estilo por defecto.
        return cell!
    }
    
}

class CharacterListDelegate: NSObject, UITableViewDelegate {
    
}
