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
    
    var symbolX = true
    
    func onGridTap(position: (Double, Double)) {
        let row = position.1 / Double(squareSideLength) // 1 2 3
        let column = position.0 / Double(squareSideLength)  // 1 2 3
        
        let position =  gameMatrix.calculatePositionIndex(row: Int(row), column: Int(column))
        
        gameMatrix.items[position] = symbolX ? "X" : "0"
        symbolX = !symbolX
        
        delegate?.updateGrid(withGameMatrix: gameMatrix)
        //- Tell the view to updateGrid(withGameMatrix : GameMatrix)
    }
    
//    private func calculateMatrixIndex(from tapPosition:  (Int, Int)){
//       let row = Double(tapPosition.y) / Double(squareSideLength) // 1 2 3
//       let column = Double(tapPosition.x) / Double(squareSideLength)  // 1 2 3
//
//       let position =  gameMatrix.calculatePositionIndex(row: Int(row), column: Int(column))
//
//       gameMatrix.items[position] = "X"
//       let x = ((Int(column)) * squareSideLength)
//       let y = (Int(row)) * squareSideLength
//       gridView.refresh(in: CGRect(x: x, y: y, width: 80, height: 80))
//
//       print("Game matrix: \(gameMatrix.items)")
//    }
    
}
