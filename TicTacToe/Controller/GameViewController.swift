//
//  GameViewController.swift
//  TicTacToe
//
//  Created by Reshma Pinto on 05/10/2019.
//  Copyright © 2019 RP. All rights reserved.
//


import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var gridView: GameGrid!
    
    var labels: [UILabel] = []
    
    // MARK: Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
