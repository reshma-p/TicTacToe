//
//  GameViewController.swift
//  TicTacToe
//
//  Created by Reshma Pinto on 05/10/2019.
//  Copyright © 2019 RP. All rights reserved.
//


import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var gridView: UIView!
    
    var labels: [UILabel] = []
    // MARK: Life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createGrid()
    }
    
    func createGrid(){
        
        let label = UILabel()
        let margins = gridView.layoutMarginsGuide

        
        var count = 1
        for row in 0...2{
            for col in 0...2{
               print("\(count) == \(row*80) \(col*80)")
               label.text = "\(count)"
               label.frame = CGRect(x: row*80, y: col*80, width: 80, height: 80)
               label.textColor = UIColor.red
               labels.append(label)
               gridView.addSubview(label)
                count = count + 1
            }
        }
    }

}
