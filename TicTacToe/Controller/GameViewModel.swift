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
    private var gameMatrix: GameMatrix = GameMatrix()
    private var gameState = GameState.New
    private var toggleX = true
    
    // MARK: Member properties
    weak var delegate: GameViewModelDelegate?
    let rows: Int = 3
    let columns: Int = 3
    let squareSideLength = 80
    
    
    // MARK: GameViewModelType Implementation
    func onGridTap(position: (row: Int, column: Int)) {
        
        guard gameState != .Completed else {
            print("ooopsss!!! game already over. \(position.row) \(position.column)")
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
        
        // Check if any wins
        if let winLocationType = checkForWins(for: position, withSymbol: symbolValue) {
            gameState = .Completed
            let gameOutcome = GameOutcome(winType: WinType.outcomeForSymbol(symbol: symbolValue), winLocationType: winLocationType)
            delegate?.updateGameCompletion(outCome: gameOutcome)
        } else if !gameMatrix.items.contains(.Empty) {
            gameState = .Completed
            delegate?.updateGameCompletion(outCome: GameOutcome(winType: .Draw, winLocationType: nil))
        } else {
            nextMove()
        }
    }
    
    
    func onNewGame() {
        resetGame()
        delegate?.resetGame()
    }
    
    private func resetGame(){
        gameMatrix = GameMatrix()
        gameState = GameState.New
        toggleX = true
    }
    
    // MARK: Private member functions
    private func nextMove() {
        toggleX = !toggleX
    }
    
    private func checkForWins(for position: Int, withSymbol symbol: SymbolValue) -> WinLocationType? {
        let items = gameMatrix.items
        
        guard gameMatrix.isPositionInRange(position) else {
            return nil
        }
        
        if isColumnWin(gameArray: items, for: position) {
            let columnPosition: Int = gameMatrix.calculateColumnIndex(position)
            return .Column(index: columnPosition)
        } else if isRowWin(gameArray: items, for: position) {
            let rowPosition: Int = gameMatrix.calculateRowIndex(position)
            return .Row(index: rowPosition)
        } else if gameMatrix.isPositionOnDiagonal(position) {
            if checkDiagonal(of: .LtoR,items,symbol) {
                return .Diagonal(type: .LtoR)
            } else if checkDiagonal(of: .RtoL,items,symbol) {
                return .Diagonal(type: .RtoL)
            }
        }
        
        return nil
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
    
    
    func checkDiagonal(of type: DiagonalStyle, _ gameArray: [SymbolValue], _ symbol: SymbolValue) -> Bool {
        print("===> checkDiagonal : for type \(type)")
        let fromIndex = type == DiagonalStyle.LtoR ? 0 : gameMatrix.size - 1   // 0 : 2
        let increment = type == DiagonalStyle.LtoR ? gameMatrix.size + 1 : gameMatrix.size - 1  // 4 : 2
        let toIndex = type == DiagonalStyle.LtoR ? gameArray.count : gameArray.count - (gameMatrix.size - 1)  // 8 : 7
        
        var matchedSymbols = 0
        
        print("===> checkDiagonal : with range: \(fromIndex) to \(toIndex) with stride \(increment)")
        for symbolIndex in stride(from: fromIndex, to: toIndex, by: increment) {
            print("===> checkDiagonal : Symbol position \(symbolIndex) ")
            
            if(symbol == gameArray[symbolIndex]) {
                matchedSymbols += 1
            }
        }
        print("===> matchedSymbols : for type \(matchedSymbols)")
        return matchedSymbols == gameMatrix.size
    }
}

enum GameState: String {
    case New
    case Completed
    case InProgress
}

