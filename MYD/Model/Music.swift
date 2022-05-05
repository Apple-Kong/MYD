//
//  MusicModel.swift
//  MYD
//
//  Created by GOngTAE on 2022/05/02.
//

import Foundation

enum MusicGenre: String, CaseIterable, Equatable {
    case Boombap
    case RnB
    case Trap
    case KPOP
    case POP
    case Rock
    case Funk
    case Indy
    case EDM
    case Jazz
    
    
    
    var koreanText: String {
        switch self {
        case .Trap:
            return "트랩"
        case .Boombap:
            return "붐뱁"
        case .Rock:
            return "락"
        case .Indy:
            return "인디"
        case .RnB:
            return "R&B"
        case .Jazz:
            return "재즈"
        default:
            return self.rawValue
        }
    }
}
