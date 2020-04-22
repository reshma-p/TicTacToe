//
//  GameViewModel.swift
//  TicTacToe
//
//  Created by Reshma Pinto on 30/01/2020.
//  Copyright © 2020 RP. All rights reserved.
//

import Foundation


class GameViewModel: GameViewModelType {
    let squareSideLength = 80
    var gameMatrix: GameMatrix = GameMatrix()
    
    weak var delegate: GameViewModelDelegate?
    
    var gameState = GameState.New
    
    var symbolX = true
    
    func onGridTap(position: (Double, Double)) {
        
        guard gameState == .New else {
            return
        }
        
        let row = position.1 / Double(squareSideLength) // 1 2 3
        let column = position.0 / Double(squareSideLength)  // 1 2 3
        
        let position =  gameMatrix.calculatePositionIndex(row: Int(row), column: Int(column))
        let symbolValue = symbolX ? SymbolValue.X : SymbolValue.O
        
        gameMatrix.items[position] = symbolValue
       
        delegate?.updateGrid(withGameMatrix: gameMatrix)
        
        nextMove()
        
        // Check if any wins
        if(checkForWins(for: position)) {
            gameState = .Completed
            delegate?.updateGameCompletion(outCome: GameOutcome.outcomeForSymbol(symbol: symbolValue))
        } else if !gameMatrix.items.contains(.Empty) {
            gameState = .Completed
            delegate?.updateGameCompletion(outCome: .Draw)
        }
    }
    
    func nextMove() {
        symbolX = !symbolX
    }
    
    func checkForWins(for position: Int) -> Bool{
        let items = gameMatrix.items
        
        return isRowWin(gameArray: items, for: position) || isColumnWin(gameArray: items, for: position) || isDiagonalWin(gameArray: items, for: position)
    }
    
    private func isRowWin(gameArray : [SymbolValue], for position: Int) -> Bool{
        guard gameMatrix.isPositionInRange(position) else {
           return false
       }
        
        let rowPosition : Int = gameMatrix.calculateRowIndex(position)
        let colRange = (gameMatrix.size * rowPosition)...((gameMatrix.size * (rowPosition + 1)) - 1)
        let symbol = gameArray[position]
        
        //-- Check row wins
        for index in colRange{
            if(symbol != gameArray[index]){
                return false
            }
        }
        return true
    }
    
    private func isColumnWin(gameArray : [SymbolValue], for position: Int) -> Bool{
        
        guard gameMatrix.isPositionInRange(position) else {
            return false
        }
        let symbol = gameArray[position]
        // check for column wins
        let columnPosition: Int = gameMatrix.calculateColumnIndex(position)
        // 0 1 2   3 4 5   6 7 8
        for rowIndex in 0...gameMatrix.size-1 {
            let symbolIndex = gameMatrix.calculatePositionIndex(row: rowIndex, column: columnPosition)
            if(symbol != gameArray[symbolIndex]){
                return false
            }
        }
        return true
    }
    
    private func isDiagonalWin(gameArray : [SymbolValue], for position: Int) -> Bool{
        guard gameMatrix.isPositionInRange(position) && gameMatrix.isPositionOnDiagonal(position) else {
            return false
        }
        let symbol = gameArray[position]
        
        return checkDiagonal(index: 0, increment: (gameMatrix.size + 1), gameArray,symbol) || checkDiagonal(index: gameMatrix.size - 1, increment: (gameMatrix.size - 1), gameArray,symbol)
    }
    
    private func checkDiagonal(index: Int, increment: Int, _ gameArray: [SymbolValue], _ symbol: SymbolValue) -> Bool{

        var index = index
        for _ in 1...gameMatrix.size {
            let symbolIndex = index
            if(symbol != gameArray[symbolIndex]) {
                return false
            }
            index = index + increment
        }
        return true
    }
    
}


enum GameState: String {
    case New
    case Completed
    case InProgress
}

enum GameOutcome: String {
    case XWins
    case OWins
    case Draw
    case Unknown
    
    static func outcomeForSymbol(symbol: SymbolValue) -> GameOutcome{
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
