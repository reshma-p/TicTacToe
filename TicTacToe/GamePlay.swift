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
    
    
    var currentGameMatrix : [String] = []
    let rows = 3
    let columns = 3
    let numberOfItems = 9
    
    // MARK: private member functions
    fileprivate func isPositionInRange(_ position: Int) -> Bool{
        return (0...(rows * columns)).contains(position)
    }
    
    fileprivate func calculateRowIndex(_ position: Int) -> Int{
        return position/rows
    }
    
    fileprivate func calculateColumnIndex(_ position: Int) -> Int{
        let rowPosition = calculateRowIndex(position)
        return columns - ((columns * (rowPosition + 1)) - position)
    }
    
    fileprivate func calculatePositionIndex(row: Int, column: Int) -> Int{
        return (row * columns) + column
    }
    
    // MARK: Game play functions
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
    
    func isRowWin(gameArray : [String], for position: Int) -> Bool{
        guard isPositionInRange(position) else {
           return false
       }
        
        let rowPosition : Int = calculateRowIndex(position)
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
        
        guard isPositionInRange(position) else {
            return false
        }
         let rowPosition : Int = calculateRowIndex(position)
        let symbol = gameArray[position]
        // check for column wins
        let columnPosition: Int = calculateColumnIndex(position)
        // 0 1 2   3 4 5   6 7 8
        for rowIndex in 0...rows-1 {
            let symbolIndex = calculatePositionIndex(row: rowIndex, column: columnPosition)
            if(symbol != gameArray[symbolIndex]){
                return false
            }
        }
        return true
    }
    
    
    
    func isDiagonalWin(gameArray : [String], for position: Int) -> Bool{
        guard isPositionInRange(position) else {
            return false
        }
        
        let rowPosition: Int = position/rows
        let symbol = gameArray[position]
        
        var indexBack = rowPosition - 1
        while(indexBack >= 0){
            let symbolIndex = calculatePositionIndex(row: indexBack, column: indexBack)
            if(symbol != gameArray[symbolIndex]) {
                return false
            }
            indexBack = indexBack - 1
        }
        
        indexBack = rowPosition + 1
        while(indexBack < rows){
            let symbolIndex = calculatePositionIndex(row: indexBack, column: indexBack)
            if(symbol != gameArray[symbolIndex]) {
                return false
            }
            indexBack = indexBack + 1
        }
        
        return true
    }
    
    
    func reset(){
        
    }
}
