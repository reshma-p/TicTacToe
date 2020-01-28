//
//  GameViewController.swift
//  TicTacToe
//
//  Created by Reshma Pinto on 05/10/2019.
//  Copyright © 2019 RP. All rights reserved.
//


import UIKit

class GameViewController: UIViewController {

    //MARK: UI Outlets
    @IBOutlet weak var gridView: GameGrid!
    
    //MARK: Member variables
    var gameMatrix: GameMatrix!
    let squareSideLength = 80
    
    // MARK: Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Adding tapgesture to the grid
        // TODO: Should move to the GridView?
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        gridView.addGestureRecognizer(tapGesture)
        
        gameMatrix = GameMatrix()
        
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        
        if sender.state == .ended {
            let tappedLocation = sender.location(in: gridView)
            print("Tapping the grid, yay!!! \(tappedLocation)")
            calculateMatrixIndex(from: tappedLocation)
        }
    }
    
    
    private func calculateMatrixIndex(from tapPosition: CGPoint){
        let row = Double(tapPosition.y) / Double(squareSideLength) // 1 2 3
        let column = Double(tapPosition.x) / Double(squareSideLength)  // 1 2 3
        
        let position =  gameMatrix.calculatePositionIndex(row: Int(row), column: Int(column))

        gameMatrix.items[position] = "X"
        let x = ((Int(column)) * squareSideLength)
        let y = (Int(row)) * squareSideLength
        gridView.refresh(in: CGRect(x: x, y: y, width: 80, height: 80))
    }
    
   
}


/**
 
 1  2 3
 4 5 6
 7 8 9
 
 
 
    00 01 02
    10 11 12
    20 21 22
 */
