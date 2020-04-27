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
    @IBOutlet weak var gameMessage: UILabel!
    
    //MARK: View Model
    let viewModel: GameViewModelType = GameViewModel()
    
    // MARK: Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        setupGameGrid()
        gameMessage.text = ""
    }
    
    // MARK: Private functions
    private func setupGameGrid(){
        // Adding tapgesture to the grid
        // TODO: Should move to the GridView?
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        gridView.addGestureRecognizer(tapGesture)
        
        gridView.setupGrid(rows: viewModel.rows, columns: viewModel.columns)
    }
    
    // MARK: UI action handlers
    @objc func handleTap(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            let tappedLocation = sender.location(in: gridView)
            
            let row = Double(tappedLocation.y) / Double(viewModel.squareSideLength) // 1 2 3
            let column = Double(tappedLocation.x) / Double(viewModel.squareSideLength)  // 1 2 3
            viewModel.onGridTap(position: (row: Int(row), column: Int(column)))
        }
    }
    
    func displayMessage(_ outCome: GameOutcome) -> String{
    
        switch outCome {
            case .XWins:
                return "X wins."
            case .OWins:
                return "O wins."
            case .Draw:
                return "It's a draw."
        case .Unknown:
                return "We have encountered a problem, pls try again later."
        }
    }
}

// MARK: GameViewModelDelegate Extension 
extension GameViewController: GameViewModelDelegate {
    
    func updateGameCompletion(outCome: GameOutcome) {
        gameMessage.text = "\(displayMessage(outCome)) "
        gridView.isUserInteractionEnabled = false
    }
    
    func updateGrid(withGameMatrix: GameMatrix) {
        
        let symbolsToDraw = withGameMatrix.items.enumerated().map { (index,value) -> Symbol in
            let x = Int(withGameMatrix.calculateColumnIndex(index)) * viewModel.squareSideLength
            let y = Int(withGameMatrix.calculateRowIndex(index)) * viewModel.squareSideLength
            return Symbol(value: value.rawValue, rect: CGRect(x: x, y: y, width: viewModel.squareSideLength, height: viewModel.squareSideLength))
        }
        
        gridView.refresh(with: symbolsToDraw)
    }
}
