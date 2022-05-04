//
//  MusicButtonView.swift
//  MYD
//
//  Created by GOngTAE on 2022/05/01.
//

import SwiftUI

struct MusicPreferenceView: View {
    
    //간격 한번에 설정하기 위한 변수
    var totalSpacing: CGFloat = 20
    
    
    @State var selectedItems: [MusicGenre] = []
    
    var body: some View {
        ZStack {
                
            VStack {
            
                ScrollView {
                    
                    LazyVGrid(columns: [
                        GridItem(.flexible(), spacing: totalSpacing),
                        GridItem(.flexible())
                    ], spacing: totalSpacing
                    ) {
                        ForEach(MusicGenre.allCases, id: \.self) { item in
                
                
                            MusicButtonView(item: item, items: $selectedItems)
                        }
                    }
                    .padding(.horizontal, totalSpacing)
                    .padding(.top, 20)
                }
                .background(Color("background"))
            }
            
            
            VStack {
                
                Spacer()
                
                VStack {
                    
                    NavigationLink {
                        ResultView()
                    } label: {
                        Text("다음")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                    .buttonStyle(PreferenceButtonStyle())
                    .padding(20)
                    
                }
                .frame(height: 80)
                .background(Color("background"))
            }
        }
        .navigationTitle(
            Text("음악 취향")
        )
    }
}





struct MusicPreferenceView_Previews: PreviewProvider {
    static var previews: some View {
        Group {

            MusicPreferenceView()
                .preferredColorScheme(.dark)
        }
    }
}
