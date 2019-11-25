//
//  GamePlay.swift
//  TicTacToe
//
//  Created by Reshma Pinto on 21/11/2019.
//  Copyright © 2019 RP. All rights reserved.
//

import Foundation

class GamePlay{
    
    // MARK: Variables
    enum Symbol:String{
        case X
        case O
    }
    
    
    private(set) var gameMatrix: GameMatrix?
    // Square matrix of 3x3 size
    let matrixSize = 3
    let rows = 3
    let columns = 3
    var numberOfItems : Int {
        matrixSize * matrixSize
    }
    
    
    // MARK: private member functions
    
    
    // MARK: Game play functions
    func start() -> [String]{
        self.gameMatrix = GameMatrix()
        return self.gameMatrix?.items ?? [];
    }
    
    
    func play(position: Int, symbol: Symbol) ->  [String]{
        guard let gameMatrix = self.gameMatrix, position < numberOfItems else {
            return []
        }
        gameMatrix.items[position] = symbol.rawValue
        return gameMatrix.items
    }
    
    func isRowWin(gameArray : [String], for position: Int) -> Bool{
        guard let gameMatrix = self.gameMatrix, gameMatrix.isPositionInRange(position) else {
           return false
       }
        
        let rowPosition : Int = gameMatrix.calculateRowIndex(position)
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
    
    func isColumnWin(gameArray : [String], for position: Int) -> Bool{
        
        guard let gameMatrix = self.gameMatrix, gameMatrix.isPositionInRange(position) else {
            return false
        }
        let symbol = gameArray[position]
        // check for column wins
        let columnPosition: Int = gameMatrix.calculateColumnIndex(position)
        // 0 1 2   3 4 5   6 7 8
        for rowIndex in 0...rows-1 {
            let symbolIndex = gameMatrix.calculatePositionIndex(row: rowIndex, column: columnPosition)
            if(symbol != gameArray[symbolIndex]){
                return false
            }
        }
        return true
    }
    
    
    
    func isDiagonalWin(gameArray : [String], for position: Int) -> Bool{
        guard let gameMatrix = self.gameMatrix, gameMatrix.isPositionInRange(position) && gameMatrix.isPositionOnDiagonal(position) else {
            return false
        }
        let symbol = gameArray[position]
        
        return checkDiagonal(index: 0, increment: (rows + 1), gameArray,symbol) || checkDiagonal(index: rows - 1, increment: (rows - 1), gameArray,symbol)
    }
    
    func checkDiagonal(index: Int, increment: Int, _ gameArray: [String], _ symbol: String) -> Bool{
        var index = index
        for _ in 1...rows {
            let symbolIndex = index
            if(symbol != gameArray[symbolIndex]) {
                return false
            }
            index = index + increment
        }
        return true
    }
    
    
    
    
    func reset(){
        
    }
}
