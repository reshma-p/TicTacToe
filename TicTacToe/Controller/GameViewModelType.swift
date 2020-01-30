//
//  GameViewModelType.swift
//  TicTacToe
//
//  Created by Reshma Pinto on 30/01/2020.
//  Copyright © 2020 RP. All rights reserved.
//

import Foundation

protocol GameViewModelType {
    
    func onGridTap(position: (Double, Double))
}


protocol GameViewModelDelegate {
    
//    addItemToGrid()
}
