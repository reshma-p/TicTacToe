//
//  TicTacToeMatrix.swift
//  TicTacToe
//
//  Created by Reshma Pinto on 25/11/2019.
//  Copyright © 2019 RP. All rights reserved.
//

import Foundation

public class GameMatrix{
    
    // MARK: Variables
    // Flat array that holds the values for the 3x3 matrix
    var items : [String] = []
    // Square matrix of 3x3 size
    let matrixSize = 3
    // Items in the flat array structure
    private var numberOfItems : Int {
        return matrixSize * matrixSize
    }
    
    // MARK: Lifecycle
    init(){
        self.items = Array.init(repeating: "", count: numberOfItems)
    }
    
    func isPositionInRange(_ position: Int) -> Bool{
        return (0...(matrixSize * matrixSize)).contains(position)
    }
    
    func isPositionOnDiagonal(_ position: Int) -> Bool{
        let rowPosition = calculateRowIndex(position)
        let columnPosition = calculateColumnIndex(position)
        
        return ((matrixSize - rowPosition - 1) == columnPosition || rowPosition == columnPosition)
    }
    
    func calculateRowIndex(_ position: Int) -> Int{
        return position/matrixSize
    }
    
    func calculateColumnIndex(_ position: Int) -> Int{
        let rowPosition = calculateRowIndex(position)
        return matrixSize - ((matrixSize * (rowPosition + 1)) - position)
    }
    
    func calculatePositionIndex(row: Int, column: Int) -> Int{
        return (row * matrixSize) + column
    }
}
