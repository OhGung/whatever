//
//  MainView.swift
//  Whatever
//
//  Created by sei on 2023/06/11.
//

import SwiftUI
import CoreData

struct MainView: View {
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \CycleLog.timestamp, ascending: false)],
        animation: .default)
    private var cycleLogs: FetchedResults<CycleLog>
    
    
    let beforePeriod = "생리를 시작했다면 기록하기 버튼을 눌러 현재 상태를 기록해봐!"
    let afterPeriod : [String] = [
        "여자라면 생리를 하는 게 당연한거야! 부끄러운게 아니라고~",
        "생리대를 오랫동안 갈지 않으면 몸에 좋지 않아! 제때제때 갈아주자!",
        "누가 생리한다고 놀려? 자연스러운 몸의 변화를 놀리는 애들의 말은 신경 쓸 필요 없어!",
        "왜 그날이라고 이야기 해? 생리라고 말하는 게 어때서?",
        "생리에 대해 불편한게 있으면 숨기지 말구 앞에서 이야기하자! 모두 도와줄거야!",
        "생리대는 왜 몰래 주고받아야 돼? 당당하게 들고 다녀도 돼!",
        "생리대를 꼭 챙겨다녀서 미리미리 준비하자!",
        "생리통으로 인해 아프다면 절대 참으면 안 돼!약 챙겨먹구 푹 쉬어주자"
    ]
    
    let ment = [
        "잠잘 때 오버나이트로도 생리가 샌다면, 팬티형 생리대를 사용해보는 건 어때?",
        "팬티에 생리가 묻었다면, 미지근한 물에 잠깐 담궈 두었다가 빨래 비누로 그 부분만 손빨래 하면 돼!",
        "생리대 이외에도 탐폰이나 생리컵 같은 다른 선택지도 있어!",
        "생리통이 심하다면, 참지 말고 약국에 가서 생리통 약을 달라고 해.",
        "생리통이 심할 때, 찜질팩을 이용해서 배에 찜질을 해주면 좀 나아!"
    ]
    
    
    
    var body: some View {
        NavigationStack{
            ZStack{
                VStack(spacing: 0){
                    HStack{
                        Text("가이드 니나(NINA)")
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .bold))
                        Spacer()
                        NavigationLink(destination: SettingAlarmView(), label: {
                            Image(systemName: "bell.fill")
                                .foregroundColor(.vividYellow)
                                .font(.title3)
                        })
                    }
                    .padding(.horizontal, 30)
                    .padding(.top, 30)
                    .padding(.bottom, 10)
                    
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 0) {
                            ZStack{
                                Image("NinaWithBack")
                                ZStack{
                                    Image("speechBubble")
                                        .overlay(
                                            Text("\(afterPeriod[Int.random(in: 0...7)])")
                                                .font(Font.custom("DungGeunMo", size: 15))
                                                .frame(width: 200, height:60, alignment: .center)
                                                .position(x:110, y:25)
                                                .minimumScaleFactor(0.5)
                                                .foregroundColor(.vividPurple)
                                                .padding()
                                        )
                                        .position(x: 240, y:60)
                                }
                            }
                            
                            Text("생리 1일차") //data 받아와야함
                                .foregroundColor(.white)
                                .font(.system(size:34, weight:.heavy))
                                .padding(.bottom, 18)
                            
                            NavigationLink(destination: CalenderView(records: cycleLogs), label: {
                                ZStack{
                                    RoundedRectangle(cornerRadius: 40)
                                        .foregroundColor(.vividYellow)
                                        .frame(width: 300, height: 62)
                                    
                                    HStack{
                                        Image(systemName: "square.and.pencil.circle.fill")
                                            .foregroundColor(.black)
                                        Text("기록하기")
                                            .foregroundColor(.black)
                                            .bold()                                     .fontWeight(.heavy)
                                    }
                                    .font(.system(size: 24))
                                }
                            })
                            .padding(.bottom, 18)
                            
                            
                            
                            
                            //기록하기 전과 후로 나누어서 진행하기
//                            ZStack {
//                                RoundedRectangle(cornerRadius: 20)
//                                    .foregroundColor(.white)
//                                    .frame(width: 350, height: 180)
//                                VStack(spacing: 0) {
//                                    Text("오늘 하루 필요한 생리대는?")
//                                        .font(.subheadline)
//
//                                    Text("기록하면 알려줄게요") //정보 받아와서 알려주기
//                                        .font(.system(size: 32, weight: .bold))
//                                        .foregroundColor(.vividPurple)
//                                        .padding(.bottom, 8)
//                                    ZStack{
//                                        RoundedRectangle(cornerRadius: 50)
//                                            .stroke(Color.gray)
//                                            .foregroundColor(.white)
//                                            .frame(width: 252, height: 70)
//
//
//                                        VStack{
//                                            RoundedRectangle(cornerRadius: 30)
//                                                .foregroundColor(.lightPurple)
//                                                .frame(width: 35, height:15)
//                                                .offset(x:0, y:10)
//                                                .overlay(
//                                                    Text("TIP")
//                                                        .offset(x:0, y:10)
//                                                        .foregroundColor(.white)
//                                                        .font(.system(size: 13, weight: .bold))
//
//                                                )
//
//                                            Text("아직 알려줄 수 있는 팁이 없어요")
//                                                .frame(width: 235, height: 50)
//                                                .minimumScaleFactor(0.5)
//                                                .font(.system(size:13))
//                                                .foregroundColor(.gray)
//                                                .multilineTextAlignment(.center)
//                                        }
//                                    }
//                                }
//
//                            }
                            
                            
                            VStack(spacing: 18){
                                ZStack {
                                    RoundedRectangle(cornerRadius: 20)
                                        .foregroundColor(.white)
                                        .frame(width: 350, height: 180)
                                    VStack(spacing: 0) {
                                        Text("오늘 하루 필요한 생리대는?")
                                            .font(.subheadline)
                                        
                                        Text("4개 중형") //정보 받아와서 알려주기
                                            .font(.system(size: 32, weight: .bold))
                                            .foregroundColor(.vividPurple)
                                            .padding(.bottom, 8)
                                        ZStack{
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color.gray)
                                                .foregroundColor(.white)
                                                .frame(width: 252, height: 70)
                                            
                                            
                                            VStack{
                                                RoundedRectangle(cornerRadius: 30)
                                                    .foregroundColor(.lightPurple)
                                                    .frame(width: 35, height:15)
                                                    .offset(x:0, y:10)
                                                    .overlay(
                                                        Text("TIP")
                                                            .offset(x:0, y:10)
                                                            .foregroundColor(.white)
                                                            .font(.system(size: 13, weight: .bold))
                                                        
                                                    )
                                                
                                                Text("\(ment[Int.random(in: 0...4)])")
                                                    .frame(width: 235, height: 50)
                                                    .minimumScaleFactor(0.5)
                                                    .font(.system(size:12))
                                                    .foregroundColor(.gray)
                                                    .multilineTextAlignment(.center)
                                            }
                                        }
                                    }
                                    
                                }

                                ZStack {
                                    RoundedRectangle(cornerRadius: 20)
                                        .frame(width: 350, height: 230)
                                        .foregroundColor(.clearWhite)
                                    VStack(spacing: 5) {
                                        Text("지금 생리를 어떻게 하고 있을까요?")
                                            .font(.subheadline)
                                        NavigationLink {
                                            PeriodHistoryView()
                                        } label: {
                                            DailyCheckView()
                                                .scaleEffect(0.9)
                                                .padding(.horizontal)
                                                .accentColor(Color.black)
                                        }

                                        
                                    }
                                }
                            }
                        }
                    }
                }
                .background(Color.vividPurple)
                
            }
            .padding(EdgeInsets(top: 30, leading: 0, bottom: 0, trailing: 0))
            .edgesIgnoringSafeArea(.top)
            
            
            
        }
        
        
        
        
    }
}












struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

