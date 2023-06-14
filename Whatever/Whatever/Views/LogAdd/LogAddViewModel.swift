//
//  LogAddViewModel.swift
//  Whatever
//
//  Created by sei on 2023/06/13.
//

import Foundation

// MARK: - LogAddViewModelProtocol
protocol LogAddViewModelProtocol: ObservableObject {
    var padType: PadTypeEnum? { get }
    var flowLevel: FlowLevelEnum? { get }
    var whatNinaSaid: String { get }
//
//    var citiesRequest: RequestState<[ModelType]> { get }
//    var searchText: String { get set }
//
//    func loadData(for searchTerm: String)
//    func didSelectCity(_ city: City)
}


// MARK: - MapViewModel
final class LogAddViewModel: BaseViewModel, LogAddViewModelProtocol {
    
    init(cycleLog: CycleLog? = nil) {
        if let cycleLog {
            padType = PadTypeEnum(rawValue: Int(cycleLog.padType))
            flowLevel = FlowLevelEnum(rawValue: Int(cycleLog.flowLevel))
        } else {
            padType = .liner
            flowLevel = .small
        }
    }
    
    enum AddPhase {
        case addPadType
        case addFlowLevel
    }
    private(set) var currentPhase: AddPhase = .addPadType
    
    @Published private(set) var padType: PadTypeEnum?
    @Published private(set) var flowLevel: FlowLevelEnum?
    
    var imageName: String {
        switch (currentPhase, padType, flowLevel) {
        case (.addPadType, _, _):
            return padType?.description ?? PadTypeEnum.liner.description
        case (.addFlowLevel, _, _):
            return "haha"
            
        }
    }
    
    var whatNinaSaid: String {
        switch currentPhase {
        case .addPadType:
            return "생리대 크기 뭐 썼어?"
        case .addFlowLevel:
            return "생리 양은 어느 정도였어?"
        }
    }
}


extension LogAddViewModel {
    static var preview: Self {
        .init()
    }
}
