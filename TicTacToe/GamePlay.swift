//
//  GamePlay.swift
//  TicTacToe
//
//  Created by Reshma Pinto on 21/11/2019.
//  Copyright © 2019 RP. All rights reserved.
//

import Foundation

class GamePlay{
    
    
    var currentGameMatrix : [[String]]?
    func start() -> [[String]]{
        self.currentGameMatrix = Array.init(repeating: Array.init(repeating: "", count: 3),count: 3);
        return self.currentGameMatrix!;
    }
    
    
    func nextMove(){
        
    }
    
    func reset(){
        
    }
}
