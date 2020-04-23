//
//  GameViewModelTest.swift
//  TicTacToeTests
//
//  Created by Reshma on 23/04/2020.
//  Copyright © 2020 RP. All rights reserved.
//

import XCTest

class GameViewModelTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    func testOnGridTapForNewGame(){
        let viewModel = GameViewModel()
        let delegate = MockGameDisplayDelegate()
        viewModel.delegate = delegate
        
        viewModel.onGridTap(position: (0,0))
        viewModel.onGridTap(position: (1,1))
        
        XCTAssertEqual(delegate.gameMatrix?.items, [SymbolValue.X,SymbolValue.Empty,SymbolValue.Empty,SymbolValue.Empty,SymbolValue.O,SymbolValue.Empty,SymbolValue.Empty,SymbolValue.Empty,SymbolValue.Empty], "Item not added to right position")
        
    }
    

}


class MockGameDisplayDelegate: GameViewModelDelegate{
    var gameMatrix: GameMatrix?
    var gameOutcome: GameOutcome?
    
    func updateGrid(withGameMatrix: GameMatrix) {
        gameMatrix = withGameMatrix
    }
    
    func updateGameCompletion(outCome: GameOutcome) {
        gameOutcome = outCome
    }
    
    
}
