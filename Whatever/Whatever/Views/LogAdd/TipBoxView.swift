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
    
    var body: some View {
        CapsuleView(
            radius: Theme.radii.r2,
            borderWidth: 1,
            borderColor: .mediumGray
        ) {
            VStack {
                tipLabel
                Text(content)
            }
            .padding()
            .frame(maxWidth: .infinity)
        }
    }

    var tipLabel: some View {
        CapsuleView(radius:Theme.radii.r5) {
            Text(title)
                .foregroundColor(.white)
                .font(.callout)
                .bold()
                .padding(.vertical, 3)
                .padding(.horizontal)
                .background(Color.lightPurple)
        }
    }
}

struct TipBoxView_Previews: PreviewProvider {
    static var previews: some View {
        TipBoxView(title: "TIP", content: "아무말")
    }
}
