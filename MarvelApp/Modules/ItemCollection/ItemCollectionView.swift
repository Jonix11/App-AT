//
//  ItemCollectionView.swift
//  MarvelApp
//
//  Created by Jon Gonzalez on 23/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class ItemCollectionView: BaseViewController, ItemCollectionViewContract {
    
    // Constantes para la configuración de la collectionView
    enum CollectionLayoutConstants {
        static let columnCount: CGFloat = 3
        static let itemSpacing: CGFloat = 10
        static let itemHeight: CGFloat = 180
    }
    
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    var datasource: ItemCollectionDatasource!
    // swiftlint:disable:next weak_delegate
    var delegate: ItemCollectionDelegate!

	var presenter: ItemCollectionPresenterContract!
    // private let collectionViewLayout = UICollectionViewFlowLayout()

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
        
        collectionView.register(UINib(nibName: ItemCollectionViewCell.reuseId, bundle: nil),
                                forCellWithReuseIdentifier: ItemCollectionViewCell.reuseId)
        
        datasource = ItemCollectionDatasource()
        delegate = ItemCollectionDelegate()
        
        collectionView.dataSource = datasource
        collectionView.delegate = delegate
        delegate.presenter = presenter
        
        let width = calculateCellWidth()
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.itemSize = CGSize(width: width, height: CollectionLayoutConstants.itemHeight)
        collectionView.collectionViewLayout = collectionViewLayout
        
    }
    
    private func calculateCellWidth() -> CGFloat {
        let totalSpacing: CGFloat = (CollectionLayoutConstants.columnCount - 1) * CollectionLayoutConstants.itemSpacing
        let totalWidth: CGFloat = collectionView.frame.width
        
        return (totalWidth - totalSpacing) / CollectionLayoutConstants.columnCount
    }
    
    // MARK: - Public Methods
    func updateCharacterListData(with character: [CellItemContract]) {
        self.datasource.itemList = character
        collectionView.reloadData()
    }
}

class ItemCollectionDatasource: NSObject, UICollectionViewDataSource {
    
    var itemList = [CellItemContract]()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item = itemList[indexPath.item]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCollectionViewCell.reuseId,
                                                      // swiftlint:disable:next force_cast
                                                      for: indexPath) as! ItemCollectionViewCell
        cell.item = item
        
        return cell
    }
    
}

class ItemCollectionDelegate: NSObject, UICollectionViewDelegate {
    weak var presenter: ItemCollectionPresenterContract!
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.characterSelected(at: indexPath.item)
    }
}
