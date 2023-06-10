//
//  CycleLog+CoreDataProperties.swift
//  Whatever
//
//  Created by sei on 2023/06/11.
//
//

import Foundation
import CoreData


extension CycleLog {
    var wrappedPadType: String {
        let padTypeEnum = PadTypeEnum(rawValue: Int(padType)) ?? .liner
        return padTypeEnum.description
    }
    
    var wrappedFlowLevel: String {
        let flowLevelType = FlowLevelEnum(rawValue: Int(flowLevel)) ?? .none
        return flowLevelType.description
    }
    
    var wrappedDate: Date {
        timestamp ?? Date()
    }
    
    static var preview: CycleLog {
        let viewContext = PersistenceController.preview.container.viewContext
        
        let cycleLog = CycleLog(context: viewContext)
        cycleLog.timestamp = Date()
        cycleLog.flowLevel = 3
        cycleLog.padType = 3
        
        return cycleLog
    }
}

extension CycleLog : Identifiable {

}
