//
//  GamePlay.swift
//  TicTacToe
//
//  Created by Reshma Pinto on 21/11/2019.
//  Copyright © 2019 RP. All rights reserved.
//

import Foundation

class GamePlay{
    
    enum Symbol:String{
        case X
        case O
    }
    
    
    var currentGameMatrix : [String] = []
    let rows = 3
    let columns = 3
    let numberOfItems = 9
    
    
    func start() -> [String]{
        self.currentGameMatrix = Array.init(repeating: "", count: numberOfItems)
        return self.currentGameMatrix;
    }
    
    
    func play(position: Int, symbol: Symbol) ->  [String]{
        guard position < numberOfItems else {
            return []
        }
        currentGameMatrix[position] = symbol.rawValue
        return currentGameMatrix
    }
    
    func checkMoveWin(gameArray : [String]) -> Bool{
        // matched in rows
        
        return false
    }
    
    func reset(){
        
    }
    
    
}
