//
//  MemberPatchRequest.swift
//  fairer-iOS
//
//  Created by 홍준혁 on 2023/04/18.
//

import Foundation

struct MemberPatchRequest: Codable, Equatable {
    var memberName: String?
    var profilePath: String?
    var statusMessage: String?
}
