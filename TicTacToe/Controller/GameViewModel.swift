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
    let rows: Int = 3
    let columns: Int = 3
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
        
        // Check if any wins
        if let winLocationType = checkForWins(for: position) {
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
    
    // MARK: Private member functions
    private func nextMove() {
        toggleX = !toggleX
    }
    
    private func checkForWins(for position: Int) -> WinLocationType? {
        let items = gameMatrix.items
        
        if isColumnWin(gameArray: items, for: position) {
            let columnPosition: Int = gameMatrix.calculateColumnIndex(position)
            return .Column(index: columnPosition)
        } else if isRowWin(gameArray: items, for: position) {
            let rowPosition: Int = gameMatrix.calculateRowIndex(position)
            return .Row(index: rowPosition)
        } else if isDiagonalWin(gameArray: items, for: position) {
            return .Diagonal(type: .LtoR)
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

// TODO: Move to another file
enum GameState: String {
    case New
    case Completed
    case InProgress
}

struct GameOutcome {
    let winType: WinType
    let winLocationType: WinLocationType?
}

enum WinType {
    
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
