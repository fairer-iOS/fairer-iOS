//
//  LoadingView.swift
//  fairer-iOS
//
//  Created by 홍준혁 on 2023/03/13.
//

import UIKit

final class LoadingView {

    static func showLoading() {
        DispatchQueue.main.async {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.last {
                if let loadingView = window.subviews.first(where: { $0 is UIActivityIndicatorView }) as? UIActivityIndicatorView {
                    loadingView.startAnimating()
                    return
                }
                let loadingView = UIActivityIndicatorView(style: .medium)
                loadingView.frame = window.bounds
                loadingView.color = .darkGray
                window.addSubview(loadingView)
                loadingView.startAnimating()
            }
        }
    }

    static func hideLoading() {
        DispatchQueue.main.async {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.last {
                window.subviews.forEach {
                    if let loadingView = $0 as? UIActivityIndicatorView {
                        loadingView.stopAnimating()
                        loadingView.removeFromSuperview()
                    }
                }
            }
        }
    }
}
