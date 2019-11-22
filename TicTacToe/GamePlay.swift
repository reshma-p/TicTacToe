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
        case X1
        
        case X2
        case X3
        case X4
        case X5
        case X6
        case X7
        case X8
        case X9
    }
    var currentGameMatrix : [[String]]?
    var rows = 1
    var columns = 1
    func start(rows: Int,columns: Int) -> [[String]]{
        self.rows = rows
        self.columns = columns
        self.currentGameMatrix = Array.init(repeating: Array.init(repeating: "", count: columns),count: rows);
        return self.currentGameMatrix!;
    }
    
    
    func play(position: (row: Int, column: Int), symbol: Symbol) ->  [[String]]{
        currentGameMatrix?[position.row][position.column] = symbol.rawValue
        return currentGameMatrix ?? [[String]]()
    }
    
    func reset(){
        
    }
    
    
}
