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

//        createGrid()
    }
    
    func createGrid(){
        
        let label = UILabel()
        let margins = gridView.layoutMarginsGuide
        
        for index in 1...6{
            print("\(index)")
            label.text = "\(index)"
            label.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
            label.textColor = UIColor.red
            
            
            
            labels.append(label)
            gridView.addSubview(label)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
