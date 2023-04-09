//
//  NotificationKey.swift
//  fairer-iOS
//
//  Created by 홍준혁 on 2023/04/01.
//

import Foundation


enum NotificationKey {
    case date
    case member
}

extension Notification.Name {
    static let date = Notification.Name("date")
    static let member =
    Notification.Name("member")
}

