//
//  LogAddViewModel.swift
//  Whatever
//
//  Created by sei on 2023/06/13.
//

import Foundation

// MARK: - LogAddViewModelProtocol
protocol LogAddViewModelProtocol: ObservableObject {
    var date: Date { get }
    var padType: PadTypeEnum { get }
    var flowLevel: FlowLevelEnum { get }
    var whatNinaSaid: String { get }
    var titles: [String] { get }
    var imageName: String { get }
    var selectedIndex: Int { get }
    var isPhaseDone: Bool { get }
    var tipDetail: String { get }
    func goToNextPhase()
    func goToPrevPhase() -> Bool
    func saveCycle()
    func choose(_:Int)
}


// MARK: - MapViewModel
final class LogAddViewModel: BaseViewModel, LogAddViewModelProtocol {
    
    init(cycleLog: CycleLog? = nil, date: Date) {
        self.date = date
        if let cycleLog {
            padType = PadTypeEnum(rawValue: Int(cycleLog.padType)) ?? .liner
            flowLevel = FlowLevelEnum(rawValue: Int(cycleLog.flowLevel)) ?? .small
        } else {
            padType = .liner
            flowLevel = .none
        }
    }
    
    enum AddPhase {
        case addPadType
        case addFlowLevel
        case done
        
        var nextPhase: AddPhase? {
            switch self {
            case .addPadType:
                return .addFlowLevel
            case .addFlowLevel:
                return .done
            case .done:
                return nil
            }
        }
        
        var previousPhase: AddPhase? {
            switch self {
            case .addPadType:
                return nil
            case .addFlowLevel:
                return .addPadType
            case .done:
                return .addFlowLevel
            }
        }
    }

    private(set) var date: Date
    @Published private(set) var currentPhase: AddPhase = .addPadType
    @Published private(set) var padType: PadTypeEnum
    @Published private(set) var flowLevel: FlowLevelEnum
    
    var imageName: String {
        switch currentPhase {
        case .addPadType:
            return padType.imageName
        default:
            return "\(padType.imageName)_\(flowLevel.imageName)"
        }
    }
    
    var titles: [String] {
        switch currentPhase {
        case .addPadType:
            return PadTypeEnum.allCases.map { $0.description }
        case .addFlowLevel:
            return FlowLevelEnum.allCases.map { $0.description }
        case .done:
            return []
        }
    }
    
    var whatNinaSaid: String {
        switch currentPhase {
        case .addPadType:
            return "생리대 크기 뭐 썼어?"
        case .addFlowLevel:
            return "생리 양은 어느 정도였어?"
        case .done:
            return "기록 사항을 한 번 확인해 봐"
        }
    }
    
    var selectedIndex: Int {
        switch currentPhase {
        case .addPadType:
            return padType.rawValue
        case .addFlowLevel:
            return flowLevel.rawValue
        case .done:
            return 0
        }
    }
    
    var isPhaseDone: Bool {
        currentPhase == .done
    }
    
    func goToNextPhase() {
        if let nextPhase = currentPhase.nextPhase {
            currentPhase = nextPhase
        }
    }
    
    func goToPrevPhase() -> Bool {
        if let prevPhase = currentPhase.previousPhase {
            currentPhase = prevPhase
            return true
        } else {
            return false
        }
    }
    
    func choose(_ index: Int) {
        if currentPhase == .addPadType {
            padType = PadTypeEnum(rawValue: index)!
            print(#function, padType.description)
        } else if currentPhase == .addFlowLevel {
            flowLevel = FlowLevelEnum(rawValue: index)!
        }
    }
    
    func saveCycle() {
        DispatchQueue.main.async {
            PersistenceController.shared.addLog(
                date: self.date,
                padType: self.padType,
                flowLevel: self.flowLevel
            )
        }
    }
}

extension LogAddViewModel {
    var tipDetail: String {
        switch (currentPhase, padType, flowLevel) {
        case (.done, _, _):
            return ""
        case (.addPadType, .liner, _):
            return AddCycleLogTip.liner
        case (.addPadType, .small, _):
            return AddCycleLogTip.small
        case (.addPadType, .medium, _):
            return AddCycleLogTip.medium
        case (.addPadType, .big, _):
            return AddCycleLogTip.big
        case (.addPadType, .over, _):
            return AddCycleLogTip.over
        // flowLevel - medium
        case (.addFlowLevel, _, .medium):
            return AddCycleLogTip.great
        
        // flowLevel - alot
        case (.addFlowLevel, .liner, .alot):
            return AddCycleLogTip.howAboutChangeToSmallBecauseOfALot
        case (.addFlowLevel, _, .alot):
            return AddCycleLogTip.needToChangeMoreOften
            
        // flowLevel - flood
        case (.addFlowLevel, .over, .flood):
            return AddCycleLogTip.overnightFlood
        case (.addFlowLevel, _, .flood):
            let nextPadType = PadTypeEnum(rawValue: padType.rawValue + 1)
            return AddCycleLogTip.becauseOfFloodLetsChange(to: nextPadType?.description ?? "더 큰")
        
        // flowLevel - small - ing
        case (.addFlowLevel, .liner, .small):
            return AddCycleLogTip.brown
        case (.addFlowLevel, .small, .small):
            return AddCycleLogTip.howAboutContinueToSmall
        case (.addFlowLevel, _, .small):
            let prevPadType = PadTypeEnum(rawValue: padType.rawValue - 1)
            return AddCycleLogTip.becauseOfSmallLetsChange(to: prevPadType?.description ?? "더 작은")
            
        // flowLevel - none- ing
        case (.addFlowLevel, .liner, .none):
            return AddCycleLogTip.noNeed
            
        case (.addFlowLevel, .small, .none), (.addFlowLevel, .medium, .none):
            return AddCycleLogTip.liner
        case (.addFlowLevel, .big, .none), (.addFlowLevel, .over, .none):
            return AddCycleLogTip.recommendToSmall(from: padType.description)
        }
    }
}


extension LogAddViewModel {
    static var preview: Self {
        .init(date: Date())
    }
    
    static var previewDone: Self {
        let viewModel = Self.init(date: Date())
        viewModel.goToNextPhase()
        viewModel.goToNextPhase()
        return viewModel
    }
}
