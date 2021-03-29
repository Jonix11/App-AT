//
//  ItemDetailView.swift
//  MarvelApp
//
//  Created by Jon Gonzalez on 23/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit
import SDWebImage
import SnapKit

class ItemDetailView: BaseViewController, ItemDetailViewContract {
    
    // MARK: - Outlets
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var comicsTableView: UITableView!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    // MARK: - Properties
    var datasource: ComicsTableViewDatasource!
    // swiftlint:disable:next weak_delegate
    var delegate: ComicsTableViewDelegate!
    var state: ViewState = .success {
        didSet {
            switch state {
            case .success:
                statusView.isHidden = true
            case .loading:
                [statusView, loadingIndicator].forEach { $0?.isHidden = false }
            case .failure(_):
                break
            case .empty:
                break
            }
        }
    }
    
	var presenter: ItemDetailPresenterContract!

	// MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.presenter.viewDidLoad()
        state = .loading
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter.viewWillAppear()
    }

    private func setupView() {
        datasource = ComicsTableViewDatasource()
        delegate = ComicsTableViewDelegate()
        
        comicsTableView.dataSource = datasource
        comicsTableView.delegate = delegate
    }
    
    // MARK: - Public Methods
    func loadDataInView(with character: ItemDetailContract) {
        itemImage.sd_setImage(with: character.itemImage, placeholderImage: UIImage(named: "NotImage"))
        nameLabel.text = character.itemName
        
        if character.itemDescription.isEmpty {
            descriptionTextView.text = "Not description available"
        } else {
            descriptionTextView.text = character.itemDescription
        }
        var comics = [String]()
        if character.itemComics.isEmpty {
            comics.append("This character doesn't appears in any comic")
            datasource.comicList = comics
        } else {
            comics = character.itemComics
            datasource.comicList = character.itemComics
        }
        comicsTableView.reloadData()
        
        let height = comics.count * 30
        
        comicsTableView.snp.makeConstraints { make -> Void in
            make.height.equalTo(height)
        }
        state = .success
        
    }
}

class ComicsTableViewDatasource: NSObject, UITableViewDataSource {
    
    var comicList = [String]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comicList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseId = "ComicCell"
        let comic = comicList[indexPath.row]
        let cell = UITableViewCell(style: .default, reuseIdentifier: reuseId)
        
        cell.textLabel?.text = comic
        
        return cell
    }
    
}

class ComicsTableViewDelegate: NSObject, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
}
