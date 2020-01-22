//
//  GameGrid.swift
//  TicTacToe
//
//  Created by Reshma Pinto on 22/01/2020.
//  Copyright © 2020 RP. All rights reserved.
//

import UIKit

class GameGrid: UIView {
    
    let numColumns = 3
    let numRows = 3

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
        UIColor.black.setStroke()
       UIColor.clear.setFill()
       
       bezierPath.lineWidth = 1.0
       bezierPath.stroke()
    }
    
    

}
