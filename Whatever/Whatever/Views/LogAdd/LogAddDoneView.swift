//
//  LogAddDoneView.swift
//  Whatever
//
//  Created by sei on 2023/06/14.
//

import SwiftUI

struct LogAddDoneView<
    ViewModel: LogAddViewModelProtocol
>: View {
    @ObservedObject var viewModel: ViewModel
    @Environment(\.dismiss) private var dismiss
    @Binding var isDismiss: Bool
    
    var body: some View {
        VStack(spacing: 18) {
            HStack {
                NinaSaidView(content: viewModel.whatNinaSaid)
                Spacer()
            }
            TipBoxView(title: "기록 날짜", content: viewModel.date.fullString,  type:.content)
            PadImageView(imageName: viewModel.imageName)
                .frame(height: 294)
            TipBoxView(title: "생리대 크기", content: viewModel.padType.description, type: .content)
            TipBoxView(title: "생리대 양", content: viewModel.flowLevel.description, type: .content)
            saveButton
        }
        .frame(width: 350)
        .padding()
    }
    
    var saveButton: some View {
        Button {
            print("nextButtonTapped")
            viewModel.saveCycle()
            dismiss.callAsFunction()
            isDismiss = true
        } label: {
            CapsuleView(
                radius:Theme.radii.r3
            ) {
                Text("저장")
                    .foregroundColor(.white)
                    .font(.title3)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.vividPurple)
            }
        }
    }
}

struct LogAddDoneView_Previews: PreviewProvider {
    static var previews: some View {
        LogAddDoneView<LogAddViewModel>(viewModel: .previewDone, isDismiss: .constant(false))
    }
}
