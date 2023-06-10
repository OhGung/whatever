//
//  PersistenceController+CycleLog.swift
//  Whatever
//
//  Created by sei on 2023/06/09.
//

import Foundation

extension PersistenceController {
    
    // MARK: - update Cycle Log
    func update(of cycleLog: CycleLog, padType: PadTypeEnum? = nil, flowLevel: FlowLevelEnum? = nil) {
        let viewContext = container.viewContext
        if let padType {
            cycleLog.padType = Int64(padType.rawValue)
        }
        if let flowLevel {
            cycleLog.flowLevel = Int64(flowLevel.rawValue)
        }
        do {
            try viewContext.save()
        } catch {
            print(error)
        }
    }
    
    
    // MARK: - Add Cycle Log
    func addLog(padType: PadTypeEnum, flowLevel: FlowLevelEnum) {
        let viewContext = container.viewContext
        let cycleLog = CycleLog(context: viewContext)
        cycleLog.timestamp = Date()
        cycleLog.flowLevel = Int64(flowLevel.rawValue)
        cycleLog.padType = Int64(padType.rawValue)
        do {
            try viewContext.save()
        } catch {
            print(error)
        }
    }
    
    // MARK: - Delete Cycle Log
    func deleteLog(_ log: CycleLog) {
        let viewContext = container.viewContext
        container.viewContext.delete(log)
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
