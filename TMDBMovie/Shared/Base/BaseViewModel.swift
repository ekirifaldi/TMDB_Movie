//
//  BaseViewController.swift
//  TMDBMovie
//
//  Created by Eki Rifaldi on 11/05/21.
//

import UIKit

class BaseViewModel {
    var navigation: UINavigationController? = nil
    
    func popViewControllers(count: Int){
        guard let nav = navigation else { return }
        let viewControllers: [UIViewController] = nav.viewControllers as [UIViewController];
        nav.popToViewController(viewControllers[viewControllers.count - count], animated: true);
    }
}
