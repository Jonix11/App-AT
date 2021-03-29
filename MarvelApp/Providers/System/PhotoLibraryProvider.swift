//
//  PhotoLibraryProvider.swift
//  MarvelApp
//
//  Created by Jon Gonzalez on 28/3/21.
//

import Foundation
import PhotosUI
import PromiseKit

protocol PhotoLibraryProviderContract {
    func accessToLibraryEnable() -> Promise<Bool>
    func requestAuthorization() -> Promise<Bool>
}

/// Photo library provider errors
enum PhotoLibraryError: Error, LocalizedError {
    case errorAccessingPhotosLibrary
    
    /// Localized description
    var localizedDescription: String {
        switch self {
        case .errorAccessingPhotosLibrary:
            return "Error accessing to photo library"
        }
    }
}

class PhotoLibraryProvider: PhotoLibraryProviderContract {
    
    func accessToLibraryEnable() -> Promise<Bool> {
        return Promise<Bool> { promise in
            let authorizationStatus = PHPhotoLibrary.authorizationStatus(for: .readWrite)
            if authorizationStatus == .denied || authorizationStatus == .notDetermined || authorizationStatus == .restricted {
                promise.fulfill(false)
            } else {
                promise.fulfill(true)
            }
        }
    }
    
    func requestAuthorization() -> Promise<Bool> {
        return Promise<Bool> { promise in
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { authStatus in
                if authStatus == .denied || authStatus == .notDetermined || authStatus == .restricted {
                    promise.fulfill(false)
                } else {
                    promise.fulfill(true)
                }
            }
        }
    }
}
