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
                Text("\(month)월 \(day)일")//과거 데이터 받아와서 바꿔야함
                    .font(.system(size: 14))
                RoundedRectangle(cornerRadius: 25)
                    .foregroundColor(Color(red: 217/255,green: 217/255, blue: 217/255))
                    .frame(width: 65 ,height:120)
                Text("1일차")
            }
            
            VStack{
                Text("\(month)월 \(day+1)일")//과거 데이터 받아와서 바꿔야함
                    .font(.system(size: 14))
                RoundedRectangle(cornerRadius: 25)
                    .foregroundColor(Color(red: 217/255,green: 217/255, blue: 217/255))                    .frame(width: 65 ,height:120)
                Text("2일차")
            }
            
            VStack{
                Text("\(month)월 \(day+2)일")//과거 데이터 받아와서 바꿔야함
                    .font(.system(size: 14))
                RoundedRectangle(cornerRadius: 25)
                    .foregroundColor(Color(red: 217/255,green: 217/255, blue: 217/255))                    .frame(width: 65 ,height:120)
                Text("3일차")
            }
            
            VStack{
                Text("\(month)월 \(day+3)일")//과거 데이터 받아와서 바꿔야함
                    .font(.system(size: 14))
                RoundedRectangle(cornerRadius: 25)
                    .foregroundColor(Color(red: 217/255,green: 217/255, blue: 217/255))                    .frame(width: 65 ,height:120)
                Text("4일차")
            }
            
            VStack{
                Text("\(month)월 \(day+4)일")//과거 데이터 받아와서 바꿔야함
                    .font(.system(size: 14))
                RoundedRectangle(cornerRadius: 25)
                    .foregroundColor(Color(red: 217/255,green: 217/255, blue: 217/255))                    .frame(width: 65 ,height:120)
                Text("5일차")
            }
            
            
            
        }//hstack
        
    }
}


struct DailyCheckView_Previews: PreviewProvider {
    static var previews: some View {
        DailyCheckView()
    }
}
