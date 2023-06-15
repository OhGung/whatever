//
//  LightPurpleCapsuleLabel.swift
//  Whatever
//
//  Created by sei on 2023/06/15.
//

import SwiftUI

struct LightPurpleCapsuleLabel: View {
    var content: String
    
    var body: some View {
        CapsuleView(radius:Theme.radii.r5) {
            Text(content)
                .foregroundColor(.white)
                .font(.caption)
                .bold()
                .padding(.vertical, 3)
                .padding(.horizontal, 8)
                .background(Color.lightPurple)
        }
    }
}

struct LightPurpleCapsuleLabel_Previews: PreviewProvider {
    static var previews: some View {
        let label = "TIP"
        LightPurpleCapsuleLabel(content: label)
    }
}
