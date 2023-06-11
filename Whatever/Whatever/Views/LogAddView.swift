//
//  LogAddView.swift
//  Whatever
//
//  Created by sei on 2023/06/07.
//

import SwiftUI

struct LogAddView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    @State private var selectedFlowLevel: FlowLevelEnum = .none
    @State private var selectedPadType: PadTypeEnum = .liner
    
    var body: some View {
        VStack {
            HStack {
                Text("Flow Level: ")
                Picker("Selected Flow Level", selection: $selectedFlowLevel) {
                    ForEach(FlowLevelEnum.allCases) {
                        Text($0.description)
                    }
                }
            }
            HStack {
                Text("Pad Type: ")
                Picker("Selected Pad Type", selection: $selectedPadType) {
                    ForEach(PadTypeEnum.allCases) {
                        Text($0.description)
                    }
                }
            }
            addButton
        }
        
    }
    
    var addButton: some View {
        Button {
            withAnimation {
                addCycleLog()
            }
            dismiss()
        } label: {
            Text("추가하기")
        }
    }
    
    
    // MARK: - usage of Add Cycle Log
    func addCycleLog() {
        print("pressed cycleLog")
        PersistenceController.shared.addLog(padType: selectedPadType, flowLevel: selectedFlowLevel)
    }
}

struct LogAddView_Previews: PreviewProvider {
    static var previews: some View {
        LogAddView()
    }
}
