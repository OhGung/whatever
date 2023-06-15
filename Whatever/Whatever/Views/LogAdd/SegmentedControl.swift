//
//  SegmentedControl.swift
//  Whatever
//
//  Created by sei on 2023/06/13.
//

import SwiftUI

struct SegmentedControl<
    ViewModel: LogAddViewModelProtocol
>: View {
    @ObservedObject var viewModel: ViewModel
    var titles: [String]
    private let circleSize: CGFloat = 28
    
    var body: some View {
        circles
    }
    
    var rectangle: some View {
        Color.mediumGray
            .frame(height: 10)
    }
    
    var circles: some View {
        VStack {
            HStack(alignment: .top) {
                ForEach(titles.indices, id: \.self) { i in
                    VStack(spacing:8) {
                        circle(selected: viewModel.selectedIndex == i)
                            .onTapGesture {
                                viewModel.choose(i)
                                
                            }
                        Text(titles[i])
                            .font(.subheadline)
                            .frame(maxWidth: 50)
                            .multilineTextAlignment(.center)
                    }
                    
                    if i < titles.count - 1 {
                        Spacer()
                    }
                }
            }
        }
        .frame(height: 75)
    }
    
    @ViewBuilder
    func circle(selected: Bool) -> some View {
        if selected {
            ZStack {
                Circle()
                    .frame(height: circleSize)
                    .foregroundColor(.mediumGray)
                Circle()
                    .foregroundColor(.vividPurple)
                    .frame(height: circleSize - 8)
            }
        } else {
            ZStack {
                Circle()
                    .frame(height: circleSize)
                    .foregroundColor(.mediumGray)
            }
        }
    }
}

struct SegmentedControl_Previews: PreviewProvider {
    static var previews: some View {
        SegmentedControl<LogAddViewModel>(viewModel: .preview, titles: ["팬티 라이너", "소형", "중형", "대형", "오버 나이트"])
    }
}
