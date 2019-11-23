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
        let tictacarray = gamePlay.start()
        XCTAssertEqual(["","","","","","","","",""], tictacarray)
    }
    
    func testPositionAdditionInPlay() {
        let gamePlay = GamePlay()
        var tictacarray = gamePlay.start()
        
        tictacarray = gamePlay.play(position: 1, symbol: GamePlay.Symbol.X)
        XCTAssertEqual(["","X","","","","","","",""], tictacarray)
        tictacarray = gamePlay.play(position: 100, symbol: GamePlay.Symbol.O)
        XCTAssertEqual([], tictacarray)
    }
    
    func testPlayedMoveWinTopRow(){
        let gamePlay = GamePlay()
        var tictacarray = gamePlay.start()
        tictacarray = gamePlay.play(position: 0, symbol: GamePlay.Symbol.X)
        tictacarray = gamePlay.play(position: 1, symbol: GamePlay.Symbol.X)
        tictacarray = gamePlay.play(position: 2, symbol: GamePlay.Symbol.X)
        tictacarray = gamePlay.play(position: 4, symbol: GamePlay.Symbol.O)
        XCTAssertEqual(["X","X","X","","O","","","",""], tictacarray)
        XCTAssertTrue(gamePlay.checkMoveWin(gameArray: tictacarray, for: 0))
        XCTAssertTrue(gamePlay.checkMoveWin(gameArray: tictacarray, for: 1))
        XCTAssertTrue(gamePlay.checkMoveWin(gameArray: tictacarray, for: 2))
    }
}
