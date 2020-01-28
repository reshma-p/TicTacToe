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
    
    let numColumns = 3
    let numRows = 3
    let strokeColor = UIColor.red
    let fillColor = UIColor.clear
    
    var isSymbolDrawPending = false
    
    var symbol: Symbol?
    
    
    /// Draws the grid for the game
    override func draw(_ rect: CGRect) {
        

        let cellSize = rect.width / CGFloat(numColumns)
        let bezierPath = UIBezierPath()
        let offset: CGFloat = 0.0

        // Draw vertical lines
        for i in 0...numColumns {
           let x = rect.origin.x + CGFloat(i) * cellSize
           bezierPath.move(to: CGPoint(x: x, y: rect.origin.y))
           bezierPath.addLine(to: CGPoint(x: x, y: rect.origin.y + CGFloat(numRows) * cellSize))
        }
        // Draw horizontal lines
        for i in 0...numRows {
           let y = rect.origin.y + CGFloat(i) * cellSize + offset
           bezierPath.move(to: CGPoint(x: rect.origin.x, y: y))
           bezierPath.addLine(to: CGPoint(x: rect.origin.x + rect.width, y: y))
        }
        strokeColor.setStroke()
        fillColor.setFill()

        bezierPath.lineWidth = 1.0
        bezierPath.stroke()
        
        
        if let symbol = self.symbol, isSymbolDrawPending {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center

            let attributes = [
                NSAttributedString.Key.paragraphStyle: paragraphStyle,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 80),
                NSAttributedString.Key.foregroundColor: UIColor.blue
            ]
            let attributedString = NSAttributedString(string: symbol.value, attributes: attributes)

            attributedString.draw(in: symbol.rect)
            isSymbolDrawPending = false
        }
    }

    func refresh(in rect: CGRect){
        symbol = Symbol(value: "X", rect: rect)
        isSymbolDrawPending = true
        
        setNeedsDisplay()
    }
}


struct Symbol{
    var value: String
    var rect: CGRect
}
