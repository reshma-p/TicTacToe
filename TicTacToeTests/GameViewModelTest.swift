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
    
    func testEmptyMockDelegate(){
        // Given
        let viewModel = GameViewModel()
        let delegate = MockGameDisplayDelegate()
        
        // When
        viewModel.delegate = delegate
        
        // Then
        XCTAssertNil(delegate.gameMatrix,"Should be nil.")
    }

    
    func testOnGridTapForNewGame(){
        
        // Given
        let viewModel = GameViewModel()
        let delegate = MockGameDisplayDelegate()
        viewModel.delegate = delegate
        
        // When
        viewModel.onGridTap(position: (0,0))
        viewModel.onGridTap(position: (1,1))
        
        //Then
        XCTAssertNotNil(delegate.gameMatrix,"Should not be nil.")
        XCTAssertEqual(delegate.gameMatrix?.items, [SymbolValue.X,SymbolValue.Empty,SymbolValue.Empty,SymbolValue.Empty,SymbolValue.O,SymbolValue.Empty,SymbolValue.Empty,SymbolValue.Empty,SymbolValue.Empty], "Item not added to right position")
        
        XCTAssertNil(delegate.gameOutcome,"Should be nil as game is still being played.")
        
    }
    
    /**
        X Wins test.
     
            | X |   | O |
            | X | O |   |
            | X |   |   |
     */
    func testGridTapForGameCompletionWithWin(){
        // Given
        let viewModel = GameViewModel()
        let delegate = MockGameDisplayDelegate()
        viewModel.delegate = delegate
        
        // When
        viewModel.onGridTap(position: (0,0))
        viewModel.onGridTap(position: (1,1))
        viewModel.onGridTap(position: (1,0))
        viewModel.onGridTap(position: (0,2))
        viewModel.onGridTap(position: (2,0))
        
        // Then
        XCTAssertNotNil(delegate.gameMatrix,"Should not be nil.")
        XCTAssertEqual(delegate.gameMatrix?.items, [SymbolValue.X,SymbolValue.Empty,SymbolValue.O,
                                                    SymbolValue.X,SymbolValue.O,SymbolValue.Empty,
                                                    SymbolValue.X,SymbolValue.Empty,SymbolValue.Empty], "Item not added to right position")
        
        XCTAssertNotNil(delegate.gameOutcome,"Should not be nil.")
        XCTAssertEqual(delegate.gameOutcome?.winType, WinType.XWins,"X wins")
        XCTAssertNotNil(delegate.gameOutcome?.winLocationType,"Should not be nil")
        XCTAssertEqual(delegate.gameOutcome?.winLocationType,WinLocationType.Column(index: 0),"Should be first column")
    }
    
    
    /**
       X Wins test.
    
           | X |   |   |
           | O | O | O |
           | X | X |   |
    */

    func testGridTapForGameCompletionWithOWin(){
        // Given
        let viewModel = GameViewModel()
        let delegate = MockGameDisplayDelegate()
        viewModel.delegate = delegate
        
        // When
        viewModel.onGridTap(position: (0,0))
        viewModel.onGridTap(position: (1,1))
        viewModel.onGridTap(position: (2,0))
        viewModel.onGridTap(position: (1,0))
        viewModel.onGridTap(position: (2,1))
        viewModel.onGridTap(position: (1,2))
        
        // Then
        XCTAssertNotNil(delegate.gameMatrix,"Should not be nil.")
        XCTAssertEqual(delegate.gameMatrix?.items, [SymbolValue.X,SymbolValue.Empty,SymbolValue.Empty,
                                                    SymbolValue.O,SymbolValue.O,SymbolValue.O,
                                                    SymbolValue.X,SymbolValue.X,SymbolValue.Empty], "Item not added to right position")
        
        XCTAssertNotNil(delegate.gameOutcome,"Should not be nil.")
        XCTAssertEqual(delegate.gameOutcome?.winType, WinType.OWins,"O wins")
        XCTAssertNotNil(delegate.gameOutcome?.winLocationType,"Should not be nil")
        XCTAssertEqual(delegate.gameOutcome?.winLocationType,WinLocationType.Row(index: 1),"Should be first column")
    }
    
    
    /**
       Draw test.
    
           | X | X | O |
           | O | O | X |
           | X | O | X |
    */

    func testGridTapForGameCompletionWithDraw(){
        // Given
        let viewModel = GameViewModel()
        let delegate = MockGameDisplayDelegate()
        viewModel.delegate = delegate
        
        // When
        viewModel.onGridTap(position: (0,0))
        viewModel.onGridTap(position: (1,1))
        viewModel.onGridTap(position: (2,0))
        viewModel.onGridTap(position: (1,0))
        viewModel.onGridTap(position: (1,2))
        viewModel.onGridTap(position: (2,1))
        viewModel.onGridTap(position: (2,1))
        viewModel.onGridTap(position: (0,1))
        viewModel.onGridTap(position: (0,2))
        viewModel.onGridTap(position: (2,2))
        
        // Then
        XCTAssertNotNil(delegate.gameMatrix,"Should not be nil.")
        XCTAssertEqual(delegate.gameMatrix?.items, [SymbolValue.X,SymbolValue.X,SymbolValue.O,
                                                    SymbolValue.O,SymbolValue.O,SymbolValue.X,
                                                    SymbolValue.X,SymbolValue.O,SymbolValue.X], "Item not added to right position")
        
        XCTAssertNotNil(delegate.gameOutcome,"Should be nil.")
        XCTAssertEqual(delegate.gameOutcome?.winType, WinType.Draw,"Its a Draw")
        XCTAssertNil(delegate.gameOutcome?.winLocationType,"Its a Draw so location should be nil")
    }
    
    
    /**
       Diagonal LtoR win test for X
    
           | X | O |   |
           |   | X |   |
           |   | O | X |
    */

    func testGridTapWithDiagonalLtoRwin(){
        // Given
        let viewModel = GameViewModel()
        let delegate = MockGameDisplayDelegate()
        viewModel.delegate = delegate
        
        // When
        viewModel.onGridTap(position: (0,0))
        viewModel.onGridTap(position: (0,1))
        viewModel.onGridTap(position: (1,1))
        viewModel.onGridTap(position: (2,1))
        viewModel.onGridTap(position: (2,2))
        
        // Then
        XCTAssertNotNil(delegate.gameMatrix,"Should not be nil.")
        XCTAssertEqual(delegate.gameMatrix?.items, [SymbolValue.X,SymbolValue.O,SymbolValue.Empty,
                                                    SymbolValue.Empty,SymbolValue.X,SymbolValue.Empty,
                                                    SymbolValue.Empty,SymbolValue.O,SymbolValue.X], "Item not added to right position")
        
        XCTAssertNotNil(delegate.gameOutcome,"Should be nil.")
        XCTAssertEqual(delegate.gameOutcome?.winType, WinType.XWins,"Its X win")
        XCTAssertNotNil(delegate.gameOutcome?.winLocationType,"Its a diagonal win from Left to Right")
        XCTAssertEqual(delegate.gameOutcome?.winLocationType,WinLocationType.Diagonal(type: .LtoR),"Its a diagonal win from Left to Right")
    }
    
    
    /**
       Diagonal RtoL win test for X
    
           |   | O | X |
           |   | X |   |
           | X | O |   |
    */

    func testGridTapWithDiagonalRtoLwin(){
        // Given
        let viewModel = GameViewModel()
        let delegate = MockGameDisplayDelegate()
        viewModel.delegate = delegate
        
        // When
        viewModel.onGridTap(position: (0,2))
        viewModel.onGridTap(position: (0,1))
        viewModel.onGridTap(position: (1,1))
        viewModel.onGridTap(position: (2,1))
        viewModel.onGridTap(position: (2,0))
        
        // Then
        XCTAssertNotNil(delegate.gameMatrix,"Should not be nil.")
        XCTAssertEqual(delegate.gameMatrix?.items, [SymbolValue.Empty,SymbolValue.O,SymbolValue.X,
                                                    SymbolValue.Empty,SymbolValue.X,SymbolValue.Empty,
                                                    SymbolValue.X,SymbolValue.O,SymbolValue.Empty], "Item not added to right position")
        
        XCTAssertNotNil(delegate.gameOutcome,"Should not be nil.")
        XCTAssertEqual(delegate.gameOutcome?.winType, WinType.XWins,"Its X win")
        XCTAssertNotNil(delegate.gameOutcome?.winLocationType,"Its a diagonal win from Left to Right")
        XCTAssertEqual(delegate.gameOutcome?.winLocationType,WinLocationType.Diagonal(type: .RtoL),"Its a diagonal win from Right to Left")
    }
    
    
    /**
       Diagonal RtoL win test for X
    
           | X |   | X |
           |   | O |   |
           | O | X | O |
    */

    func testGridTapWithDiagonalNoWin(){
        // Given
        let viewModel = GameViewModel()
        let delegate = MockGameDisplayDelegate()
        viewModel.delegate = delegate
        
        // When
        viewModel.onGridTap(position: (0,0))
        viewModel.onGridTap(position: (1,1))
        viewModel.onGridTap(position: (0,2))
        viewModel.onGridTap(position: (2,0))
        viewModel.onGridTap(position: (2,1))
        viewModel.onGridTap(position: (2,2))
        
        // Then
        XCTAssertNotNil(delegate.gameMatrix,"Should not be nil.")
        XCTAssertEqual(delegate.gameMatrix?.items, [SymbolValue.X,SymbolValue.Empty,SymbolValue.X,
                                                    SymbolValue.Empty,SymbolValue.O,SymbolValue.Empty,
                                                    SymbolValue.O,SymbolValue.X,SymbolValue.O], "Item not added to right position")
        
        XCTAssertNil(delegate.gameOutcome,"Should be nil.")
//        XCTAssertEqual(delegate.gameOutcome?.winType, WinType.XWins,"Its X win")
//        XCTAssertNotNil(delegate.gameOutcome?.winLocationType,"Its a diagonal win from Left to Right")
//        XCTAssertEqual(delegate.gameOutcome?.winLocationType,WinLocationType.Diagonal(type: .RtoL),"Its a diagonal win from Right to Left")
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
