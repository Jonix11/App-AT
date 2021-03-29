//
//  BaseViewController.swift
//  VIPER
//
//  Created by Manuel Alfonso Terol on 05/11/2020.
//

import UIKit
import SnapKit

enum ViewState {
    case loading
    case failure(String)
    case empty
    case success
}

class BaseViewController: UIViewController {
    
    let statusView = UIView()
    let loadingIndicator = UIActivityIndicatorView()
    let statusImage = UIImageView()
    let statusLabel = UILabel()
    
    var state: ViewState = .success {
        didSet {
            
            switch state {
            case .loading:
                [statusView, loadingIndicator].forEach { $0?.isHidden = false }
                [statusLabel, statusImage].forEach { $0?.isHidden = true }
            case .failure(let errorMsg):
                [statusView, statusLabel, statusImage].forEach { $0?.isHidden = false }
                loadingIndicator.isHidden = true
                statusLabel.text = errorMsg
                statusImage.image = UIImage(systemName: "xmark.circle.fill")
                statusImage.tintColor = UIColor.systemRed
            case .empty:
                [statusView, statusLabel, statusImage].forEach { $0?.isHidden = false }
                loadingIndicator.isHidden = true
                statusLabel.text = "There aren't beers that fit the search"
                statusImage.image = UIImage(systemName: "info.circle.fill")
                statusImage.tintColor = UIColor.systemBlue
            case .success:
                statusView.isHidden = true
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadingIndicator.startAnimating()
        loadingIndicator.color = .darkGray
        loadingIndicator.style = .large
        
        statusLabel.textAlignment = .center
        
        self.view.addSubview(statusView)
        statusView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right)
        }
        
        statusView.addSubview(loadingIndicator)
        loadingIndicator.snp.makeConstraints { (make) -> Void in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        statusView.addSubview(statusImage)
        statusImage.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(40)
            make.height.equalTo(40)
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        statusView.addSubview(statusLabel)
        statusLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(statusView).offset(20)
            make.right.equalTo(statusView).offset(-20)
            make.top.equalTo(statusImage).offset(10)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

class BaseTabBarController: UITabBarController {
    
}
