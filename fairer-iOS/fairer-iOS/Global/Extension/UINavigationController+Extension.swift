//
//  UINavigationController+Extension.swift
//  fairer-iOS
//
//  Created by 홍준혁 on 2023/04/13.
//

import UIKit

extension UINavigationController {
  func popToViewController(ofClass: AnyClass, animated: Bool = true) {
    if let vc = viewControllers.last(where: { $0.isKind(of: ofClass) }) {
      popToViewController(vc, animated: animated)
    }
  }
}
