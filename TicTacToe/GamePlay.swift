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
    
    func checkMoveWin(gameArray : [String], for position: Int) -> Bool{
        // matched in rows
        
        let rowPosition : Int = position/rows  // 3/ 3 = 1
        print("==== > colRange - \(position)/\(rows) => \(rowPosition)")
        let colRange = (columns * rowPosition)...((columns * (rowPosition + 1)) - 1) // 0 ... ( 3 - 1 * 1)
        print("==== > colRange - \(colRange)")
        let symbol = gameArray[position]
        print("==== > symbol - \(symbol)")
        //-- Check row wins
        for index in colRange{
            if(symbol != gameArray[index]){
                print("Found mismatch - \(index)")
                return false
            }
        }
        return true
    }
    
    func reset(){
        
    }
}
