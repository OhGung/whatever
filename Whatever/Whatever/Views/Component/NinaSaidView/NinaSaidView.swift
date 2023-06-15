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
            ninaImage
            ninaBubble(content: content)
        }
        .frame(height:30)
    }
    
    var ninaImage: some View {
        Image("NinaWithBack")
            .resizable()
            .scaledToFit()
            
    }
    
    func ninaBubble(content: String) -> some View {
        Text(content)
            .padding(.vertical, 6)
            .padding(.horizontal, 15)
            .background(Color.vividPurple)
            .foregroundColor(.white)
            .lineLimit(1)
            .clipShape(
                RoundedCornersShape(radius: Theme.radii.r6, corners: [.bottomLeft,.bottomRight,.topRight,])
            )
            .font(.body)
            .bold()
    }
    
}

struct NinaSaidView_Previews: PreviewProvider {
    static var previews: some View {
        NinaSaidView(content: "생리 양은 어느 정도였어?")
    }
}
