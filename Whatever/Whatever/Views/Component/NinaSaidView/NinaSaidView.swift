//
//  NinaSaidView.swift
//  Whatever
//
//  Created by sei on 2023/06/13.
//

import SwiftUI

struct NinaSaidView: View {
    var content: String
    
    var body: some View {
        HStack (alignment: .bottom) {
//        HStack (alignment: .center) {
            ninaImage
            ninaBubble(content: content)
        }
    }
    
    var ninaImage: some View {
        Image("NinaWithBack")
            .resizable()
            .scaledToFit()
            .frame(maxWidth:70)
    }
    
    func ninaBubble(content: String) -> some View {
        Text(content)
            .padding()
            .background(Color.vividPurple)
            .foregroundColor(.white)
            .lineLimit(1)
            .clipShape(
                RoundedCornersShape(radius: Theme.radii.r6, corners: [.bottomLeft,.bottomRight,.topRight,])
            )
    }
    
}

struct NinaSaidView_Previews: PreviewProvider {
    static var previews: some View {
        NinaSaidView(content: "생리 양은 어느 정도였어?")
    }
}
