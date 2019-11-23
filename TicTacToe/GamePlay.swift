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

        if(isRowWin(gameArray: gameArray, for: position) || isColumnWin(gameArray: gameArray, for: position)){
            return true
        }
        return false
    }
    
    fileprivate func isRowWin(gameArray : [String], for position: Int) -> Bool{
        
        let rowPosition : Int = position/rows
        let colRange = (columns * rowPosition)...((columns * (rowPosition + 1)) - 1)
        let symbol = gameArray[position]
        
        //-- Check row wins
        for index in colRange{
            if(symbol != gameArray[index]){
                return false
            }
        }
        return true
    }
    
    fileprivate func isColumnWin(gameArray : [String], for position: Int) -> Bool{
        
        let rowPosition : Int = position/rows
        let symbol = gameArray[position]
        // check for column wins
        let columnPosition: Int = columns - ((columns * (rowPosition + 1)) - position)
        // 0 1 2   3 4 5   6 7 8
        for rowIndex in 0...rows-1 {
            let symbolIndex = (rowIndex * columns) + columnPosition
            if(symbol != gameArray[symbolIndex]){
                return false
            }
        }
        return true
    }
    
    
    
    func reset(){
        
    }
}
