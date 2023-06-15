//
//  TipBoxView.swift
//  Whatever
//
//  Created by sei on 2023/06/14.
//

import SwiftUI

struct TipBoxView: View {
    var title: String
    var content: String
    var type: TipBoxType
    
    enum TipBoxType {
        case tip, content
    }
    
    var body: some View {
        CapsuleView(
            radius: Theme.radii.r2,
            borderWidth: 1,
            borderColor: .mediumGray
        ) {
            VStack(spacing: 7) {
                tipLabel
                    .frame(height: 19)
                VStack(spacing: 0) {
                    Spacer(minLength: 0)
                    Text(content)
                        .lineSpacing(0)
                        .font(type == .tip ? .caption : .title2)
                        .multilineTextAlignment(.center)
                        .foregroundColor(type == .tip ?  .dimGray : .clearBlack)
                    Spacer(minLength: 0)
                }
                
            }
            .padding(.top, 6)
            .padding(.vertical, 6)
            .padding(.horizontal, 5)
            .frame(maxWidth: .infinity)
        }
        
    }

    var tipLabel: some View {
        LightPurpleCapsuleLabel(content: title)
    }
}

struct TipBoxView_Previews: PreviewProvider {
    static var previews: some View {
        TipBoxView(title: "TIP", content: "아무말\nsdfsdg", type: .content)
    }
}
