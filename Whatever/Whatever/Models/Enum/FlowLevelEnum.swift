//
//  FlowLevelEnum.swift
//  Whatever
//
//  Created by sei on 2023/06/11.
//

import Foundation

enum FlowLevelEnum: Int, CaseIterable, Identifiable {
    case none = 0, small, medium, alot, flood
    
    var description: String {
        switch self {
        case .none: return "거의없음"
        case .small: return "적음"
        case .medium: return "중간"
        case .alot: return "많음"
        case .flood: return "넘침"
        }
    }
    
    var id: Self { self }
}
