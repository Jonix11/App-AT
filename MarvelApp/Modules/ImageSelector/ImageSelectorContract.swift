//
//  ImageSelectorContract.swift
//  MarvelApp
//
//  Created by Jon Gonzalez on 27/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation
import UIKit
import PromiseKit

protocol ImageSelectorEntityContract: BaseEntity {
    
}

protocol ImageSelectorViewContract: BaseViewController {
    var presenter: ImageSelectorPresenterContract! { get set }
    
    func showPickerView()
    func askForAccessToLibrary()
    
}

protocol ImageSelectorPresenterContract: BasePresenter {
    var view: ImageSelectorViewContract! { get set }
    var interactor: ImageSelectorInteractorContract! { get set }
    var entity: ImageSelectorEntityContract! { get set }
    var wireframe: ImageSelectorWireframeContract! { get set }

    func viewDidLoad()
    func viewWillAppear()
    func launchPhotoPickerView()
}

protocol ImageSelectorInteractorContract: BaseInteractor {
    var output: ImageSelectorInteractorOutputContract! {get set}
    
    func tryAccessToPhotoLibrary() -> Promise<Bool>
}

protocol ImageSelectorInteractorOutputContract: class {
    
}

protocol ImageSelectorWireframeContract: BaseWireframe {
    var output: ImageSelectorWireframeOutputContract! { get set }
    var view: UIViewController! { get set }
}

protocol ImageSelectorWireframeOutputContract: class {

}
