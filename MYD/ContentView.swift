//
//  ContentView.swift
//  MYD
//
//  Created by GOngTAE on 2022/05/01.
//

import SwiftUI

struct ContentView: View {
    
    
    
    
    var body: some View {
        VStack {
            
            Spacer()
            
            
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
            
            
            Spacer()
            
        
            VStack {
                Button {
                    print("DEBUG: button is tapped")
                    
                } label: {
                    
                    Text("음악을 듣고 가볍게 리듬을 타고 싶어서")
                        .foregroundColor(.white)
                        .font(.title3)
                        .fontWeight(.bold)
                    
                }
                .buttonStyle(PreferenceButtonStyle())
                
                Button {
                    print("DEBUG: button is tapped")
                    
                } label: {
                    
                    Text("친구들과 영상을 찍기위해")
                        .foregroundColor(.white)
                        .font(.title3)
                        .fontWeight(.bold)
                    
                }
                .buttonStyle(PreferenceButtonStyle())
                
                Button {
                    print("DEBUG: button is tapped")
                } label: {
            
                    
                Text("멋진 무대에서 공연해보고 싶어서")
                    .foregroundColor(.white)
                    .font(.title3)
                    .fontWeight(.bold)
                }
                .buttonStyle(PreferenceButtonStyle())
            }
            
        }
        .padding(20)
        .background(Color("background"))
    }
}


//버튼 애니메이션
struct PreferenceButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(height: 64)
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
