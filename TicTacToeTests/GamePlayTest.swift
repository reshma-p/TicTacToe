//
//  GamePlayTest.swift
//  TicTacToeTests
//
//  Created by Reshma Pinto on 21/11/2019.
//  Copyright © 2019 RP. All rights reserved.
//

import XCTest

class GamePlayTest: XCTestCase {
   
    

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGameStart() {
        let gamePlay = GamePlay()
        let tictacarray = gamePlay.start(rows: 3,columns: 3)
        XCTAssertEqual([["", "", ""], ["", "", ""], ["", "", ""]], tictacarray)
    }
    
    func testPositionAdditionInPlay() {
        let gamePlay = GamePlay()
        var tictacarray = gamePlay.start(rows: 3,columns: 4)
        
        tictacarray = gamePlay.play(position: (row:0,column: 0), symbol: GamePlay.Symbol.X1)
        tictacarray = gamePlay.play(position: (row:0,column: 1), symbol: GamePlay.Symbol.X2)
        tictacarray = gamePlay.play(position: (row:0,column: 2), symbol: GamePlay.Symbol.X3)
        tictacarray = gamePlay.play(position: (row:0,column: 3), symbol: GamePlay.Symbol.X4)
        tictacarray = gamePlay.play(position: (row:1,column: 0), symbol: GamePlay.Symbol.X5)
        tictacarray = gamePlay.play(position: (row:1,column: 1), symbol: GamePlay.Symbol.X6)
        tictacarray = gamePlay.play(position: (row:1,column: 2), symbol: GamePlay.Symbol.X7)
        tictacarray = gamePlay.play(position: (row:1,column: 3), symbol: GamePlay.Symbol.X8)
        tictacarray = gamePlay.play(position: (row:2,column: 0), symbol: GamePlay.Symbol.X9)
        XCTAssertEqual([["X1", "X2", "X3","X4"], ["X5", "X6", "X7","X8"], ["X9", "", "",""]], tictacarray)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    

}
