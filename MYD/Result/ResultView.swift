//
//  ResultView.swift
//  MYD
//
//  Created by GOngTAE on 2022/05/03.
//

import SwiftUI

struct ResultView: View {
    
    //좌우 여백 크기
    let hInset: CGFloat = 20
    
    let viewModel = ResultViewModel()
    
    var body: some View {
        
        
        VStack(alignment: .leading) {
            
            Text("Be like...")
                .foregroundColor(.white)
                .font(.title3)
                .fontWeight(.semibold)
                .padding(.leading, hInset)

            HStack {
                Spacer()
                
                Text("Hiphop Dancer")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .fontWeight(.bold)

            }
            .padding(.trailing, hInset)
       
           
            
            Image("hiphop_dance")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            VStack(alignment: .leading) {
                Text("Recommended")
                    .foregroundColor(.white)
                    .font(.title2)
                    .fontWeight(.bold)
                Text("Basic Skills")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
            .padding(.leading, hInset)
            .padding(.top, 20)
            
            // 수평 스크롤 뷰
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: [
                    GridItem(.fixed(200), spacing: 20)
                ], spacing: 30) {
                    HStack {
                        TutorialButton {
                            print("DEBUG: button tapped")
                            
                            viewModel.getVideoData()
                            
                        }
                        TutorialButton {
                            print("DEBUG: button tapped")
                        }
                        TutorialButton {
                            print("DEBUG: button tapped")
                        }
                        
                        TutorialButton {
                            print("DEBUG: button tapped")
                        }
                    }
                    .padding(.leading, 20)
                }
                
            }
            
            
            
            Spacer()
        }
        .background(Color("background"))
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView()
    }
}
