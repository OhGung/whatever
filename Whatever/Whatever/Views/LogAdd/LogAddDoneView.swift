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
    var body: some View {
        VStack(alignment: .leading) {
            NinaSaidView(content: viewModel.whatNinaSaid)
            TipBoxView(title: "기록날짜", content: viewModel.date.fullString)
            PadImageView(imageName: viewModel.imageName)
            TipBoxView(title: "생리대 크기", content: viewModel.padType.description)
            TipBoxView(title: "생리대 양", content: viewModel.flowLevel.description)
            saveButton
        }
        .padding()
    }
    
    var saveButton: some View {
        Button {
            print("nextButtonTapped")
            viewModel.saveCycle()
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
        LogAddDoneView<LogAddViewModel>(viewModel: .previewDone)
    }
}
