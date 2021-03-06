//
//  BaseWireframe.swift
//  VIPER
//
//  Created by Manuel Alfonso Terol on 04/11/2020.
//

import Foundation
import UIKit

// MARK: - Enums

/// Different transition types to present views
enum TransitionType {
    case navigationBar          // push to navigation controller
    case modal                  // present view
    case modalWithNavigation    // present view with its own novigation controller
}

// MARK: - Class
class BaseWireframe {
    
    /// Launch a Push or Modal Presentation to a Use Case or Any View with Inherance from UIViewController
    ///
    /// - Parameters:
    ///   - view: origin view
    ///   - useCase: destination view
    ///   - withTransition: transition type. Refer to TransitionType enum description
    ///   - modalPresentationStyle: how the modal will be presented
    ///   - animated: Specify true to animate the transition or false if you do not want the transition
    ///     to be animated. You might specify false if you are setting up the navigation controller at launch time.
    ///   - completion: return a Void result on finish presentation
    func presentView(from view: UIViewController?,
                     useCase: UIViewController,
                     withTransition: TransitionType,
                     modalPresentationStyle: UIModalPresentationStyle? = nil,
                     animated: Bool = true,
                     completion: (() -> Void)?) {
        
        switch withTransition {
        
        case .navigationBar:
            view?.navigationController?.pushViewController(useCase, animated: animated)
            
        case .modal:
            if let modalStyle = modalPresentationStyle {
                view?.modalPresentationStyle = modalStyle
            }
            view?.present(useCase, animated: animated, completion: completion)
            
        case .modalWithNavigation:
            let navigation = UINavigationController(rootViewController: useCase)
            if let modalStyle = modalPresentationStyle {
                navigation.modalPresentationStyle = modalStyle
            }
            view?.present(navigation, animated: animated, completion: completion)
        
        }
    }
    
    /// Dismiss Current View
    ///
    /// - Parameters:
    ///   - originView: current view
    ///   - withTransition: transition type. Refer to TransitionType enum description
    ///   - animated: Specify true to animate the transition or false if you do not want the transition to be
    ///     animated. You might specify false if you are setting up the navigation controller at launch time.
    ///   - completion: return a Void result on finish presentation
    func dismissView(from originView: UIViewController?,
                     withTransition: TransitionType,
                     animated: Bool = true,
                     completion: (() -> Void)?) {
        
        switch withTransition {
        
        case .navigationBar:
            originView?.navigationController?.popViewController(animated: animated)
            
        case .modal:
            originView?.dismiss(animated: animated, completion: completion)
            
        case .modalWithNavigation:
            if originView?.navigationController == nil {
                originView?.dismiss(animated: animated, completion: completion)
            } else {
                originView?.navigationController?.popViewController(animated: animated)
            }
            
        }
    }
    
    /// Dismiss top-most view
    func dismissView() {
        UIViewController.topViewController()?.dismiss(animated: true)
    }
    
    /// Dismiss Navigation Controller to Root View
    ///
    /// - Parameters:
    ///   - originView: current view
    ///   - animated: Specify true to animate the transition or false if you do not want the transition to be
    ///     animated. You might specify false if you are setting up the navigation controller at launch time.
    func dismissToRoot(from originView: UIViewController?, animated: Bool = true) {
        originView?.navigationController?.popToRootViewController(animated: animated)
    }
    
    /// Change Global Root View
    ///
    /// - Parameters:
    ///   - destination: Destination view
    ///   - withNavigationBar: embebs destination view on a navigation bar
    func setAppRootView(_ destination: UIViewController, withNavigationBar: Bool = true) {
        if #available(iOS 13, *) {
            guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else {
                return
            }
            
            // Remove all subviews
            sceneDelegate.window?.subviews.forEach { $0.removeFromSuperview() }
            
            if withNavigationBar {
                sceneDelegate.window?.rootViewController = UINavigationController.init(rootViewController: destination)
            } else {
                sceneDelegate.window?.rootViewController = destination
            }
        }
    }
    
    /// Show a Customizable Modal Alert
    ///
    /// - Parameters:
    ///   - view: current view
    ///   - title: alert title text
    ///   - content: alert content text
    ///   - customActions: customActions, if this parameter is empty, by default is added a lozalicable accept button
    ///   - completion: return a Void result on finish presentation
    func showCustomModalAlert(_ view: UIViewController?,
                              title: String,
                              content: String,
                              customActions: [UIAlertAction]? = nil,
                              completion: (() -> Void)?) {
        
        let basicAlert = UIAlertController.init(title: title, message: content, preferredStyle: .alert)
        
        if let wrappedActions = customActions {
            wrappedActions.forEach({
                basicAlert.addAction($0)
            })
        } else {
            basicAlert.addAction(UIAlertAction.init(title: "Accept", style: .default, handler: nil)
            )
        }
        self.presentView(from: view, useCase: basicAlert, withTransition: .modal, completion: completion)
    }
}
