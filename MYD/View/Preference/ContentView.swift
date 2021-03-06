//
//  ContentView.swift
//  MYD
//
//  Created by GOngTAE on 2022/05/01.
//

import SwiftUI

struct ContentView: View {
    
    let choice = ["음악을 듣고 가볍게 리듬을 타고 싶어서", "친구들과 영상을 찍기위해", "멋진 무대에서 공연해보고 싶어서"]
    
    @State var selectedItems: [String] = []
    // 선택한 선택지를 담는 어레이 구현 필요 [ ]
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    Text("Q.")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("왜 춤을 배워보고 싶으신가요?")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                .padding(.vertical, 80)
            
                VStack {
                    ForEach(0..<3) { index in
                        PreferenceButtonView(text: choice[index], items: $selectedItems)
                    }
                }
                
                Spacer()
                
                NavigationLink {
                    MusicPreferenceView()
                } label: {
                    Text("다음")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                .buttonStyle(PreferenceButtonStyle())
                
                
            }
            .padding(.horizontal, 20)
            .navigationBarHidden(true)
            
        }
        .background(Color("background"))
        
    }
}


//버튼 애니메이션
struct PreferenceButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(height: 60)
            .frame(maxWidth: .infinity)
            .background(configuration.isPressed ? Color("AccentColor") : Color("Container"))
            .cornerRadius(10)
//            .scaleEffect(configuration.isPressed ? 1.3 : 1.0)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
