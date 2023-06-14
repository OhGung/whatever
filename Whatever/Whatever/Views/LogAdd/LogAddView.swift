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
            PadImageView()
            NinaSaidView(content: viewModel.whatNinaSaid)
            SegmentedControl()
            tipBox
            nextButton
        }
        
    }
    
    var tipBox: some View {
        CapsuleView(
            radius: Theme.radii.r2,
            borderWidth: 1,
            borderColor: .mediumGray
        ) {
            VStack {
                tipLabel
                Text("아무말")
            }
            .padding()
            .frame(maxWidth: .infinity)
        }
        .padding()
    }
    
    var tipLabel: some View {
        CapsuleView(radius:Theme.radii.r5) {
            Text("TIP")
                .foregroundColor(.white)
                .font(.callout)
                .bold()
                .padding(.vertical, 3)
                .padding(.horizontal)
                .background(Color.lightPurple)
        }
    }
    
    var nextButton: some View {
        Button {
            print("nextButtonTapped")
//            withAnimation {
//                addCycleLog()
//            }
//            dismiss()
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
