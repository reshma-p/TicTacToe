//
//  GameGrid.swift
//  TicTacToe
//
//  Created by Reshma Pinto on 22/01/2020.
//  Copyright © 2020 RP. All rights reserved.
//

import UIKit

@IBDesignable
class GameGrid: UIView {
    
    // MARK: Constant member variables
    let numColumns = 3
    let numRows = 3
    let strokeColor = UIColor.red
    let fillColor = UIColor.clear
    let symbolColor = UIColor.black
    
    // MARK: Member variables
//    var isSymbolDrawPending = false
    var symbols: [Symbol] = []
    
    
    /// Draws the grid for the game
    override func draw(_ rect: CGRect) {
        createGrid(rect)
        
        for symbol in symbols {
            add(symbol: symbol.value, in: symbol.rect)
        }
    }

    /// Called by the controller of this view to update it.
    func refresh(with symbols: [Symbol]){
        self.symbols = symbols
        
        setNeedsDisplay()
    }
    
    // MAKR: Utilities for drawing the various aspects of the grid
    private func createGrid(_ rect: CGRect){
        let cellSize = rect.width / CGFloat(numColumns)
        let bezierPath = UIBezierPath()
        let offset: CGFloat = 0.0

        
        strokeColor.setStroke()

        bezierPath.lineWidth = 2.0
        
        bezierPath.move(to: CGPoint(x: 0, y: 0))
        bezierPath.addLine(to: CGPoint(x: rect.origin.x + rect.width, y: rect.origin.y))
        bezierPath.addLine(to: CGPoint(x: rect.origin.x + rect.width, y: rect.origin.y + rect.height))
        bezierPath.addLine(to: CGPoint(x: rect.origin.x, y: rect.origin.y + rect.height))
        bezierPath.close()

//        // Draw vertical lines
        print("====Drawing vertical lines ====== ")
        for i in 1...numColumns-1 {
           let x = rect.origin.x + CGFloat(i) * cellSize
           bezierPath.move(to: CGPoint(x: x, y: rect.origin.y))
           bezierPath.addLine(to: CGPoint(x: x, y: rect.origin.y + CGFloat(numRows) * cellSize))
           print("move to x:\(x) y:\(rect.origin.y) ")
           print("line from x:\(x) to y:\(rect.origin.y + CGFloat(numRows) * cellSize)) ")
        }
        // Draw horizontal lines
        print("====Drawing horizontal lines ====== ")
        for i in 0...numRows {
           let y = rect.origin.y + CGFloat(i) * cellSize + offset
           bezierPath.move(to: CGPoint(x: rect.origin.x, y: y))
           bezierPath.addLine(to: CGPoint(x: rect.origin.x + rect.width, y: y))
            print("move to x:\( rect.origin.x) y:\(y) ")
            print("line from (\( rect.origin.x),\(y)) to (\(rect.origin.x + rect.width),\(y))")
        }

        
        bezierPath.stroke()
    }
    
    private func add(symbol: String, in rect: CGRect){
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center

        let attributes = [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 80),
            NSAttributedString.Key.foregroundColor: symbolColor
        ]
        let attributedString = NSAttributedString(string: symbol, attributes: attributes)
        attributedString.draw(in: rect)
    }
}


struct Symbol{
    var value: String
    var rect: CGRect
}


