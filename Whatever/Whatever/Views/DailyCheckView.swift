//
//  DailyCheck.swift
//  SeSacWhatever
//
//  Created by Cho Chaewon on 2023/06/14.
//

import Foundation
import SwiftUI

struct DailyCheckView: View {
    var month = 6 //과거 데이터 받아와서 바꿔야함
    var day = 4
    
    var body: some View {
        HStack{
            VStack{
                Text("6월 16일")
                    .font(.system(size: 11))
                    .bold()
                ZStack(alignment: .bottom) {
                    RoundedRectangle(cornerRadius: 25)
                        .foregroundColor(.mediumGray)
                        .frame(width: 65 ,height:120)
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width : 65, height :64)
                        .foregroundColor(.vividPurple)
                }
                Text("1일차")
                    .fontWeight(.heavy)
            }
            
            VStack{
                Text("6월 16일")
                    .font(.system(size: 11))
                    .bold()
                    .foregroundColor(Color.clear)
                RoundedRectangle(cornerRadius: 25)
                    .foregroundColor(.mediumGray)
                    .frame(width: 65 ,height:120)
                Text("2일차")
                    .foregroundColor(.mediumGray)
                    .fontWeight(.heavy)
            }
            
            VStack{
                Text("6월 16일")
                    .font(.system(size: 11))
                    .bold()
                    .foregroundColor(Color.clear)
                RoundedRectangle(cornerRadius: 25)
                    .foregroundColor(.mediumGray)
                    .frame(width: 65 ,height:120)
                Text("3일차")
                    .foregroundColor(.mediumGray)
                .fontWeight(.heavy)            }
            
            VStack{
                Text("6월 16일")
                    .font(.system(size: 11))
                    .bold()
                    .foregroundColor(Color.clear)
                RoundedRectangle(cornerRadius: 25)
                    .foregroundColor(.mediumGray)
                    .frame(width: 65 ,height:120)
                Text("4일차")
                    .foregroundColor(.mediumGray)
                    .fontWeight(.heavy)
            }
            
            VStack{
                Text("6월 16일")
                    .font(.system(size: 11))
                    .bold()
                    .foregroundColor(Color.clear)
                RoundedRectangle(cornerRadius: 25)
                    .foregroundColor(.mediumGray)
                    .frame(width: 65 ,height:120)
                Text("5일차")
                    .foregroundColor(.mediumGray)
                    .fontWeight(.heavy)
            }
            
            
            
        }//hstack
        
    }
}


struct DailyCheckView_Previews: PreviewProvider {
    static var previews: some View {
        DailyCheckView()
    }
}
