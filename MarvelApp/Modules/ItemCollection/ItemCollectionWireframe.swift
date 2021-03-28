//
//  ItemCollectionWireframe.swift
//  MarvelApp
//
//  Created by Jon Gonzalez on 23/3/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation
import UIKit

class ItemCollectionWireframe: BaseWireframe, ItemCollectionWireframeContract {
    weak var output: ItemCollectionWireframeOutputContract!
    weak var view: UIViewController!
    
    func showDetailView(with character: ItemDetailContract) {
        let detailView = ItemDetailBuilder.build(character: character)
        self.presentView(from: view, useCase: detailView, withTransition: .modal, modalPresentationStyle: .automatic, animated: true, completion: nil)
    }
}
