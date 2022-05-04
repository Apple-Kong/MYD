//
//  TutorialButton.swift
//  MYD
//
//  Created by GOngTAE on 2022/05/03.
//

import SwiftUI


struct TutorialButton: View {
    
    
    var info: YoutubeVideo?
    // button action
    var action: () -> Void
   
    
    var body: some View {
        
        Button {
            action()
        } label: {
            VStack(alignment: .leading) {
                
                Text(info?.title ?? "")
                    .foregroundColor(.white)
                    .font(.body)
                    .fontWeight(.bold)
                    .lineLimit(2)
                    
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal, 10)
                    .padding(.top, 14)
                    
                    
                    

                Spacer()
                    
                //이미지 비동기 호출 및 플레이스홀더
                AsyncImage(url: info?.thumbnailURL) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    Rectangle()
                        .fill(.gray)
                }
                .frame(height: 100)
              

            }
            .frame(width: 180, height: 190)
            .background(Color("Container"))
            
            .cornerRadius(10)
            
        }
    }
}

struct TutorialButton_Previews: PreviewProvider {
    static var previews: some View {
        TutorialButton(info: YoutubeVideo(id: "", title: "Video title can be long as this so watch out!!", channel: nil, thumbnailUrlString: nil )) {
            
        }
        .previewLayout(.sizeThatFits)
    }
}
