//
//  CustomControlView.swift
//  MYD
//
//  Created by GOngTAE on 2022/05/05.
//

import SwiftUI

struct CustomControlsView: View {
    @ObservedObject var playerVM: PlayerViewModel
    
    var body: some View {
        HStack {
            if let duration = playerVM.duration {
                Slider(value: $playerVM.currentTime, in: 0...duration, onEditingChanged: { isEditing in
                    playerVM.isEditingCurrentTime = isEditing
                })
            } else {
                Spacer()
            }
            
    
            
//            if playerVM.isPlaying == false {
//                Button(action: {
//                    playerVM.player.play()
//                }, label: {
//                    Image(systemName: "play.circle")
//                        .imageScale(.large)
//                })
//            } else {
//                Button(action: {
//                    playerVM.player.pause()
//                }, label: {
//                    Image(systemName: "pause.circle")
//                        .imageScale(.large)
//                })
//            }
//

        }
        .padding()
        .background(.white.opacity(0.9))
        .cornerRadius(10)
    }
}


struct CustomControlsView_Previews: PreviewProvider {
    static var previews: some View {
        CustomControlsView(playerVM: PlayerViewModel())
    }
}
