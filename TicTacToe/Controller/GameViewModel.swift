//
//  GameViewModel.swift
//  TicTacToe
//
//  Created by Reshma Pinto on 30/01/2020.
//  Copyright © 2020 RP. All rights reserved.
//

import Foundation

class GameViewModel: GameViewModelType {
    
    // MARK: Private Member properties
    private let gameMatrix: GameMatrix = GameMatrix()
    
    
    private var gameState = GameState.New
    private var toggleX = true
    
    // MARK: Member properties
    weak var delegate: GameViewModelDelegate?
    let squareSideLength = 80
    
    
    // MARK: GameViewModelType Implementation
    func onGridTap(position: (row: Int, column: Int)) {
        
        guard gameState != .Completed else {
            return
        }
        
        let position =  gameMatrix.calculatePositionIndex(row: position.0, column: position.1)
        let symbolValue = toggleX ? SymbolValue.X : SymbolValue.O
        
        // Position already filled
        guard gameMatrix.items[position] == .Empty else {
            return
        }
        
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
    
    // MARK: Private member functions
    private func nextMove() {
        toggleX = !toggleX
    }
    
    private func checkForWins(for position: Int) -> Bool{
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


struct GameOutcomeVal: OptionSet{
    let rawValue: Int

    static let XWins = GameOutcomeVal(rawValue: 1 << 0)
    static let OWins = GameOutcomeVal(rawValue: 1 << 1)
    static let Draw = GameOutcomeVal(rawValue: 1 << 2)
    static let Diagonal = GameOutcomeVal(rawValue: 1 << 3)
    static let Row = GameOutcomeVal(rawValue: 1 << 4)
    static let Column = GameOutcomeVal(rawValue: 1 << 5)
    
}

