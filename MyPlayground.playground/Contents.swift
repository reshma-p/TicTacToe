import UIKit

var str = "Hello, playground"


 let bezierPath = UIBezierPath()
        let offset: CGFloat = 0.0

        // Draw vertical lines
print("====Drawing vertical lines ====== ")
let fillColor = UIColor.white
let strokeColor = UIColor.red
bezierPath.move(to: CGPoint(x: 0, y: 0))
bezierPath.addLine(to: CGPoint(x: 0, y: 10))

//        for i in 0...numColumns {
//           let x = rect.origin.x + CGFloat(i) * cellSize
//           bezierPath.move(to: CGPoint(x: x, y: rect.origin.y))
////           bezierPath.addLine(to: CGPoint(x: x, y: rect.origin.y + CGFloat(numRows) * cellSize))
//           print("move to x:\(x) y:\(rect.origin.y) ")
//            print("line from x:\(x) to y:\(rect.origin.y + CGFloat(numRows) * cellSize)) ")
//        }
//        // Draw horizontal lines
//        print("====Drawing horizontal lines ====== ")
//        for i in 0...numRows {
//           let y = rect.origin.y + CGFloat(i) * cellSize + offset
////           bezierPath.move(to: CGPoint(x: rect.origin.x, y: y))
//           bezierPath.addLine(to: CGPoint(x: rect.origin.x + rect.width, y: y))
//            print("move to x:\( rect.origin.x) y:\(y) ")
//            print("line from x:\(rect.origin.x + rect.width) to y:\(y) ")
//        }

strokeColor.setStroke()
//fillColor.setFill()
//
bezierPath.lineWidth = 2.0
bezierPath.stroke()
