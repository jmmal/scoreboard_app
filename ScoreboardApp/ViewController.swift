//
//  ViewController.swift
//  ScoreboardApp
//
//  Created by Josh Maloney on 7/7/17.
//  Copyright © 2017 Josh Maloney. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: Properties
    
    @IBOutlet weak var awayTeam: UILabel!
    @IBOutlet weak var homeTeam: UILabel!
    
    private let gamesModel = Games()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        
    }


    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Private Functions
    private func listGames() {
        awayTeam.text = "Red Sox"
        homeTeam.text = "Yankees"
    }
    
    

}

