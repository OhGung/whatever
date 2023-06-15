//
//  PadTypeEnum.swift
//  Whatever
//
//  Created by sei on 2023/06/11.
//

import Foundation

enum PadTypeEnum: Int, CaseIterable, Identifiable {
    case liner = 0, small, medium, big, over
    
    var description: String {
        switch self {
        case .liner: return "팬티 라이너"
        case .small: return "소형"
        case .medium: return "중형"
        case .big: return "대형"
        case .over: return "오버 나이트"
        }
    }
    
    var imageName: String {
        switch self {
        case .liner:
            return "liner"
        case .small:
            return "small"
        case .medium:
            return "medium"
        case .big:
            return "big"
        case .over:
            return "over"
        }
    }
    
    var id: Self { self }
}
