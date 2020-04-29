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
    var items : [SymbolValue] = []
    
    
    // Square matrix of 3x3 size
    let size = 3
    // Items in the flat array structure
    var numberOfItems : Int {
        return size * size
    }
    
    // MARK: Lifecycle
    init(){
        self.items = Array.init(repeating: .Empty, count: numberOfItems)
    }
    
    // MARK: Helper functions
    func isPositionInRange(_ position: Int) -> Bool{
        return (0...(size * size)).contains(position)
    }
    
    func isPositionOnDiagonal(_ position: Int) -> Bool{
        let rowPosition = calculateRowIndex(position)
        let columnPosition = calculateColumnIndex(position)
        
        return ((size - rowPosition - 1) == columnPosition || rowPosition == columnPosition)
    }
    
    func calculateRowIndex(_ position: Int) -> Int{
        return position/size
    }
    
    func calculateColumnIndex(_ position: Int) -> Int{
        let rowPosition = calculateRowIndex(position)
        return size - ((size * (rowPosition + 1)) - position)
    }
    
    func calculatePositionIndex(row: Int, column: Int) -> Int{
        return (row * size) + column
    }
}


enum SymbolValue:String{
       case X
       case O
       case Empty = ""
}
