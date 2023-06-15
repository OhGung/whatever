//
//  PadImageView.swift
//  Whatever
//
//  Created by sei on 2023/06/13.
//

import SwiftUI

struct PadImageView: View {
    var imageName: String
    
    var body: some View {
        ZStack(alignment:.center) {
            RoundedCornersShape(
                radius: 12,
                corners: [.allCorners]
            )
            .foregroundColor(.vividPurple)
            Image(imageName)
        }
    }
}

struct PadImageView_Previews: PreviewProvider {
    static var previews: some View {
        PadImageView(imageName: "liner")
    }
}
