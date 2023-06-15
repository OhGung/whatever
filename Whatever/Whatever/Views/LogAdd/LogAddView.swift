//
//  LogAddView.swift
//  Whatever
//
//  Created by sei on 2023/06/07.
//

import SwiftUI

struct LogAddView<
    ViewModel: LogAddViewModelProtocol
>: View {
    @StateObject var viewModel: ViewModel
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var selectedFlowLevel: FlowLevelEnum = .none
    @State private var selectedPadType: PadTypeEnum = .liner
    
    var body: some View {
        VStack(alignment: .leading) {
            PadImageView(imageName: viewModel.imageName)
            NinaSaidView(content: viewModel.whatNinaSaid)
            SegmentedControl(viewModel: viewModel, selected: 0, titles: viewModel.titles)
            TipBoxView(title: "TIP", content: "아무말")
            nextButton
        }
    }
    
    var nextButton: some View {
        Button {
            viewModel.goNextPhase()
        } label: {
            CapsuleView(
                radius:Theme.radii.r3
            ) {
                Text("다음")
                    .foregroundColor(.white)
                    .font(.title3)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.vividPurple)
            }
            .padding()
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
        LogAddView<LogAddViewModel>(
            viewModel: .preview
        )
    }
}
