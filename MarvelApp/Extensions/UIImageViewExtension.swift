//
//  UIImageViewExtension.swift
//  MarvelApp
//
//  Created by Jon Gonzalez on 27/3/21.
//

import UIKit

extension UIImageView {
    func roundedImage() {
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
}
