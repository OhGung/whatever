//
//  AddCycleLogTip.swift
//  Whatever
//
//  Created by sei on 2023/06/15.
//

import Foundation

enum AddCycleLogTip {
    
    static let liner = "팬티라이너는 투명하거나 노란색의 끈적끈적한 냉(질 분비물)을 흡수하기 위해 만들어졌기 때문에 피를 충분히 빨아들일 수 없어. 하지만 생리가 끝나가 피가 얼마 나오지 않는다면 사용해도 좋아."
    
    static let small = "소형 생리대는 생리양이 많지 않을 때 사용하면 돼. 생리가 끝나갈 때 혹은 생리 초반에 양이 얼마 되지 않을 때 주로 써."
    
    static let medium = "중형 생리대는 생리양이 적당할 때 사용하면 돼. 일반적으로 많이 사용하는 생리대 크기야."
    
    static let big = "대형 생리대는 생리양이 가장 많을 때 사용하면 돼. 일반적으로 사람들은 생리 2일차일 때 생리 양이 가장 많아 그날 대형을 많이 써."
    
    static let over = "오버나이트는 엉덩이를 덮는 부분이 커서 잠을 자는 동안 생리가 새지 않게 도와줘. 잠을 자는 긴 시간동안 생리대를 갈 수 없을 때, 혹은 생리의 양이 너무 많을 때 쓰면 돼."
    
    static let noNeed = "생리대를 사용하지 않아도 되지만 찝찝하면 생리대를 사용하도록 해!"
    
    static let brown = "양이 적을 때는 갈색 피가 나올 수도 있어~ 정상적인 일이니까 너무 걱정 안해도 돼!"
    
    static let great = "적절한 생리대 크기를 사용하고 있어!"
    
    static let howAboutChangeToSmallBecauseOfALot = "팬티라이너를 사용했을 때 양이 많으면, 소형 생리대로 바꿔봐! 소형 생리대가 팬티라이너보다 좀 더 흡수력이 있거든."
    
    static let recommendToLiner = "팬티라이너를 사용하는 게 어떨까? 팬티라이너는 원래 이렇게 양이 조금 있을 때 쓰는 생리대야!"
    
    static func recommendToSmall(from padType: String) -> String {
        "소형 생리대를 사용하는 게 어떨까? \(padType) 생리대를 사용했을 때 양이 거의 없어도, \(padType) 생리대의 흡수력 때문에 적어 보일수도 있거든. 팬티라이너보다 흡수력이 있는 소형을 추천해!"
    }
    
    static let howAboutContinueToSmall = "소형 생리대를 그대로 사용해 봐! 소형 생리대를 사용했을 때 양이 거의 없어 보여도, 생리대의 흡수력 때문에 적어 보일수도 있거든."
    
    static let needToChangeMoreOften = "이렇게 양이 많으면 좀 빨리 갈아줘야 해! 두 시간에 한 번 쯤? 안 그러면 넘칠 수 있어."
    
    static func becauseOfFloodLetsChange(to padType: String) -> String {
        "\(padType) 생리대를 사용하는 게 어떨까? 넘치면 찝찝하기도 하고, 냄새가 날 수도 있어!"
    }
    
    static func becauseOfSmallLetsChange(to padType: String) -> String {
        "\(padType) 생리대를 사용하는 게 어떨까? 양이 적으면 생리대를 조금씩 작은 걸로 바꿔봐! 생리대 값을 조금 아낄 수 있어."
    }
    
    static let overnightFlood = "오버나이트 중에서도 크기가 있어. 43cm가 제일 큰 거야! 입는 오버나이트도 있는데, 아무래도 들고 다니긴 불편하지. 이게 넘쳤다면 생리대를 조금 더 빨리 가는 수 밖에 없어."
}
