//
//  PeriodDetailView.swift
//  Whatever
//
//  Created by sei on 2023/06/07.
//

import SwiftUI
import CoreData

struct PeriodDetailView: View {
    private var cycleLog: FetchedResults<CycleLog>.Element
    @State private var isEditing: Bool = false
    @State private var selectedPadType: PadTypeEnum
    @State private var selectedFlowLevel: FlowLevelEnum
    
    init(cycleLog: CycleLog, context: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<CycleLog> = CycleLog.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \CycleLog.timestamp, ascending: true)]
        fetchRequest.predicate = NSPredicate(value: true)
        self.cycleLog = cycleLog
        self._selectedPadType = State(initialValue: PadTypeEnum(rawValue: Int(cycleLog.padType)) ?? .liner)
        self._selectedFlowLevel = State(initialValue: FlowLevelEnum(rawValue: Int(cycleLog.flowLevel)) ?? .none)
    }
    
    var body: some View {
        VStack {
            dictRow(key: "date", val: "\(cycleLog.wrappedDate)")
            HStack(spacing: 10) {
                Text("Pad Type: ")
                Picker("Selected Pad Type", selection: $selectedPadType) {
                    ForEach(PadTypeEnum.allCases) {
                        Text($0.description)
                    }
                }
                .disabled(!isEditing)
            }
            .padding(.horizontal, 10)
            HStack(spacing: 10) {
                Text("Flow Level: ")
                Picker("Selected Flow Level", selection: $selectedFlowLevel) {
                    ForEach(FlowLevelEnum.allCases) {
                        Text($0.description)
                    }
                }
                .disabled(!isEditing)
            }
        }
        .toolbar {
            ToolbarItem {
                Button {
                    if isEditing {
                        updateCycleLog()
                        isEditing = false
                    } else {
                        isEditing = true
                    }
                } label: {
                    Text(isEditing ? "Done" : "Edit")
                }
            }
        }
    }
    
    // MARK: - Usage of Update Cycle Log
    private func updateCycleLog() {
        print("tapped update cycle log")
        PersistenceController.shared.update(of: cycleLog, padType: selectedPadType, flowLevel: selectedFlowLevel)
    }
    
    private func dictRow(key: String, val: String) -> some View {
        HStack(spacing: 10) {
            Text(key)
            Spacer()
            Text(val)
        }
        .padding(.horizontal, 10)
    }
}

struct PeriodDetailView_Previews: PreviewProvider {
    @Environment(\.managedObjectContext) private static var viewContext
    
    static var previews: some View {
        PeriodDetailView(cycleLog: .preview, context: viewContext)
    }
}
