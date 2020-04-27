//
//  GameViewModelType.swift
//  TicTacToe
//
//  Created by Reshma Pinto on 30/01/2020.
//  Copyright © 2020 RP. All rights reserved.
//

import Foundation

protocol GameViewModelType: class {
    
    // MARK: Properties
    var rows: Int { get }
    var columns: Int { get }
    var squareSideLength: Int { get }
    var delegate: GameViewModelDelegate? { get set}
    
    // MARK: Events
    func onGridTap(position: (row: Int, column: Int))
}


protocol GameViewModelDelegate: class {
    
    // MARK: Events
    func updateGrid(withGameMatrix : GameMatrix)
    
    func updateGameCompletion(outCome: GameOutcome)
}
