//
//  GameOutcome.swift
//  TicTacToe
//
//  Created by Reshma on 29/04/2020.
//  Copyright © 2020 RP. All rights reserved.
//

import Foundation


struct GameOutcome {
    let winType: WinType
    let winLocationType: WinLocationType?
}

enum WinType{
    
    case XWins
    case OWins
    case Draw
    case Unknown
    
    
    
    static func outcomeForSymbol(symbol: SymbolValue) -> WinType{
        switch symbol {
            case .X:
                return .XWins
            case .O:
                return .OWins
            default :
                return .Unknown
        }
    }
    
}

enum WinLocationType: Equatable {
    case Row(index: Int)
    case Column(index: Int)
    case Diagonal(type: DiagonalStyle)
    
}

enum DiagonalStyle: String{
    case LtoR
    case RtoL
}
