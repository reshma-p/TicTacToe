//
//  GameGrid.swift
//  TicTacToe
//
//  Created by Reshma Pinto on 22/01/2020.
//  Copyright © 2020 RP. All rights reserved.
//

import UIKit

/// Enables live rendering
@IBDesignable

class GameGrid: UIView {
    
    // MARK: Constant member variables
    let numColumns = 3
    let numRows = 3
    let strokeColor = UIColor.orange
    let fillColor = UIColor.clear
    let symbolColor = UIColor.black
    
    let lineWidth = CGFloat(2)
    
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
        
        // Solves Outside the Bounds issue when border drawn at the edge of the view : check https://www.raywenderlich.com/475829-core-graphics-tutorial-lines-rectangles-and-gradients for details
        // https://www.raywenderlich.com/411-core-graphics-tutorial-part-1-getting-started
        let strokeRect = rect.insetBy(dx: lineWidth/2, dy: lineWidth/2)
        let bezierPath = UIBezierPath(rect: strokeRect)
        let offset: CGFloat = 0.0

        
        strokeColor.setStroke()
        fillColor.setFill()
        bezierPath.lineWidth = lineWidth
        
        
        // Draw vertical lines
        for i in 1..<numColumns {
            let x = rect.origin.x + CGFloat(i) * cellSize
            drawLine(using: bezierPath, from: CGPoint(x: x, y: rect.origin.y), to: CGPoint(x: x, y: rect.origin.y + CGFloat(numRows) * cellSize))
        }
        
        // Draw horizontal lines
        for i in 1..<numRows {
            let y = rect.origin.y + CGFloat(i) * cellSize + offset
            drawLine(using: bezierPath, from: CGPoint(x: rect.origin.x, y: y), to: CGPoint(x: rect.origin.x + rect.width, y: y))
            
        }
        bezierPath.stroke()
    }
    
    private func drawLine(using bezierPath: UIBezierPath, from fromPoint: CGPoint, to toPoint: CGPoint){
        bezierPath.move(to: fromPoint)
        bezierPath.addLine(to: toPoint)
    }
    
    private func add(symbol: String, in rect: CGRect){
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center

        let attributes = [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 70),
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


