//
//  BackBarButtonItem.swift
//  TMDBMovie
//
//  Created by Eki Rifaldi on 10/01/21.
//

import UIKit

class BackBarButtonItem: UIBarButtonItem {
  @available(iOS 14.0, *)
  override var menu: UIMenu? {
    set {
      /* Don't set the menu here */
      /* super.menu = menu */
    }
    get {
      return super.menu
    }
  }
}
