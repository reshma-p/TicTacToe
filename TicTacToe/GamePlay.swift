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
        case X
        case O
    }
    var currentGameMatrix : [[String]]?
    let rows = 3
    let columns = 3
    func start() -> [[String]]{
        self.currentGameMatrix = Array.init(repeating: Array.init(repeating: "", count: rows),count: columns);
        return self.currentGameMatrix!;
    }
    
    
    func play(position: Int, symbol: Symbol) ->  [[String]]{
        
        let rowposition = position/rows
        let colposition = (position % rows - 1)
        
        if(rowposition >= 0 && colposition >= 0){
            currentGameMatrix?[rowposition][colposition] = symbol.rawValue
        }
        return currentGameMatrix ?? [[String]]()
    }
    
    func reset(){
        
    }
}
