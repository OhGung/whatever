//
//  PadTypeEnum.swift
//  Whatever
//
//  Created by sei on 2023/06/11.
//

import Foundation

enum PadTypeEnum: Int, CaseIterable, Identifiable {
    case liner = 0, small, mid, big, over
    
    var description: String {
        switch self {
        case .liner: return "팬라"
        case .small: return "소형"
        case .mid: return "중형"
        case .big: return "대형"
        case .over: return "오버"
        }
    }
    var id: Self { self }
}
