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
    func goNextPhase()
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
    }
    
    private(set) var date: Date
    @Published private(set) var currentPhase: AddPhase = .addPadType
    @Published private(set) var padType: PadTypeEnum
    @Published private(set) var flowLevel: FlowLevelEnum
    
    var imageName: String {
        switch (currentPhase, padType, flowLevel) {
        case (.addPadType, _, _):
            return padType.imageName
        case (.addFlowLevel, _, _):
            return "\(padType.imageName)_\(flowLevel.imageName)"
        case (.done, _, _):
            return ""
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
            return "생리대 크기 뭐 썼어? \(padType.description)"
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
    
    func goNextPhase() {
        if let nextPhase = currentPhase.nextPhase {
            currentPhase = nextPhase
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
        PersistenceController.shared.addLog(date: date, padType: padType, flowLevel: flowLevel)
    }
}


extension LogAddViewModel {
    static var preview: Self {
        .init(date: Date())
    }
    
    static var previewDone: Self {
        let viewModel = Self.init(date: Date())
        viewModel.goNextPhase()
        viewModel.goNextPhase()
        return viewModel
    }
}
