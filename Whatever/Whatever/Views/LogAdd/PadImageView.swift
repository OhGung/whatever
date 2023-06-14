//
//  PadImageView.swift
//  Whatever
//
//  Created by sei on 2023/06/13.
//

import SwiftUI

struct PadImageView: View {
    var body: some View {
        ZStack {
            RoundedCornersShape(
                radius: 12,
                corners: [.allCorners]
            )
            .foregroundColor(.vividPurple)
            Image("sanitaryPadHeavy")
        }
    }
}

struct PadImageView_Previews: PreviewProvider {
    static var previews: some View {
        PadImageView()
    }
}
