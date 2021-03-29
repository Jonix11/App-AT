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
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var statusImage: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var retryButton: UIButton!
    
    @IBAction func retryButtonTapped(_ sender: Any) {
        presenter.getCharacterList()
    }
    
    // MARK: - Properties
    var datasource: ItemCollectionDatasource!
    // swiftlint:disable:next weak_delegate
    var delegate: ItemCollectionDelegate!
    var state: ViewState = .success {
        didSet {

            switch state {
            case .loading:
                [statusView, loadingIndicator].forEach { $0?.isHidden = false }
                [statusLabel, statusImage, retryButton].forEach { $0?.isHidden = true }
            case .failure(let errorMsg):
                [statusView, statusLabel, statusImage, retryButton].forEach { $0?.isHidden = false }
                loadingIndicator.isHidden = true
                statusLabel.text = errorMsg
                statusImage.image = UIImage(systemName: "xmark.circle.fill")
                statusImage.tintColor = UIColor.systemRed
            case .empty:
                [statusView, statusLabel, statusImage, retryButton].forEach { $0?.isHidden = false }
                loadingIndicator.isHidden = true
                statusLabel.text = "There aren't items to show"
                statusImage.image = UIImage(systemName: "info.circle.fill")
                statusImage.tintColor = UIColor.systemBlue
            case .success:
                statusView.isHidden = true
            }
        }
    }

	var presenter: ItemCollectionPresenterContract!
    // private let collectionViewLayout = UICollectionViewFlowLayout()

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
        self.delegate.loading = false
        collectionView.reloadData()
        state = .success
    }
    
    func setEmptyView() {
        state = .empty
    }
    
    func setErrorView(with error: String) {
        state = .failure(error)
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
    var loading = false
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.characterSelected(at: indexPath.item)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let isFinishingScrolling = scrollView.contentOffset.y >=
            (scrollView.contentSize.height - scrollView.frame.size.height - 300)
        if isFinishingScrolling && !loading {
            presenter.getCharacterList()
            loading = true
        }
    }
}
