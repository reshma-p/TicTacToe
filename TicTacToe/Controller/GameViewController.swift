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
    
    //MARK: View Model
    let viewModel: GameViewModel = GameViewModel()
    
    // MARK: Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        // Adding tapgesture to the grid
        // TODO: Should move to the GridView?
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        gridView.addGestureRecognizer(tapGesture)
        gameMatrix = GameMatrix()
        
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            let tappedLocation = sender.location(in: gridView)
            viewModel.onGridTap(position: (Double(tappedLocation.x), Double(tappedLocation.y)))
        }
    }
   
}

extension GameViewController: GameViewModelDelegate {
    func updateGrid(withGameMatrix: GameMatrix) {
        
        let symbolsToDraw = gameMatrix.items.enumerated().map { (index,value) -> Symbol in
            let x = Int(gameMatrix.calculateColumnIndex(index)) * viewModel.squareSideLength
            let y = Int(gameMatrix.calculateRowIndex(index)) * viewModel.squareSideLength
            return Symbol(value: value, rect: CGRect(x: x, y: y, width: viewModel.squareSideLength, height: viewModel.squareSideLength))
        }
        
        gridView.refresh(with: symbolsToDraw)
    }
}
