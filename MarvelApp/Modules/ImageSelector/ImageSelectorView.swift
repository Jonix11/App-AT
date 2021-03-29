//
//  ImageSelectorView.swift
//  MarvelApp
//
//  Created by Jon Gonzalez on 27/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit
import PhotosUI

class ImageSelectorView: BaseViewController, ImageSelectorViewContract {
    
    // MARK: - Outlets
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    @IBAction func selectImageButtonTapped(_ sender: Any) {
        presenter.launchPhotoPickerView()
    }
    
    var state: ViewState = .success {
        didSet {
            switch state {
            case .empty:
                break
            case .loading:
                [statusView, loadingIndicator].forEach { $0?.isHidden = false }
            // swiftlint:disable:next empty_enum_arguments
            case .failure(_):
                break
            case .success:
                statusView.isHidden = true
            }
        }
    }
    
    var presenter: ImageSelectorPresenterContract!

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
        state = .success
    }
    
    func showPickerView() {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
        state = .loading
    }
    
    func askForAccessToLibrary() {
        let settings = UIAlertAction(title: "Settings", style: .default) { _ in
            if let url = URL.init(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        self.presenter.wireframe.showCustomModalAlert(self,
                                                      title: "This app needs access to the photo library",
                                                      content: "Please allow this app to access photo library in settings.",
                                                      customActions: [settings, cancel],
                                                      completion: nil)
        
    }

    private func setupView() {
        self.photoImageView.roundedImage()
    }
}

extension ImageSelectorView: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        
        if let itemProvider = results.first?.itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                // swiftlint:disable:next unused_optional_binding
                if let _ = error {
                    DispatchQueue.main.async {
                        self?.presenter.wireframe.showCustomModalAlert(self,
                                                                       title: "Error",
                                                                       content: "Image not found.",
                                                                       completion: nil)
                    }
                } else {
                    if let image = image as? UIImage {
                        DispatchQueue.main.async {
                            self?.photoImageView.image = image
                            self?.state = .success
                        }
                    }
                }
            }
        }
    }
}
