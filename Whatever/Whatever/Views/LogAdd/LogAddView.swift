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
        if viewModel.isPhaseDone {
            LogAddDoneView(viewModel: viewModel)
        } else {
            VStack(spacing: 18) {
                currentDateView
                PadImageView(
                    imageName: viewModel.imageName
                )
                .frame(width:350, height:294)
                
                VStack(spacing: 15) {
                    HStack {
                        NinaSaidView(
                            content: viewModel.whatNinaSaid
                        )
                        Spacer()
                    }
                    SegmentedControl(
                        viewModel: viewModel,
                        titles: viewModel.titles
                    )
                        .frame(height: 70)
                }
                .frame(width:344)
                
                TipBoxView(title: "TIP", content: viewModel.tipDetail, type: .tip)
                    .frame(width: 350, height: 92)
                nextButton
            }
        }
    }
    
    var currentDateView: some View {
        HStack {
            Spacer()
            VStack(alignment: .center) {
                LightPurpleCapsuleLabel(content: "기록날짜")
                Text(viewModel.date.fullString)
                    .font(.title.bold())
            }
            Spacer()
        }
    }
    
    var nextButton: some View {
        Button {
            viewModel.goToNextPhase()
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
        }
        .frame(width: 350, height: 50)
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
