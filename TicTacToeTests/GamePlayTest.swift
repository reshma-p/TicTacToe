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
        XCTAssertEqual([["", "", ""], ["", "", ""], ["", "", ""]], tictacarray)
    }
    
    func testGameNextMove() {
       let gamePlay = GamePlay()
       gamePlay.start()
       var tictacarray = gamePlay.play(position: 5, symbol: GamePlay.Symbol.X)
       tictacarray = gamePlay.play(position: 1, symbol: GamePlay.Symbol.O)
       tictacarray = gamePlay.play(position: 2, symbol: GamePlay.Symbol.X)
       XCTAssertEqual([["O", "X", ""], ["", "X", ""], ["", "", ""]], tictacarray)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
