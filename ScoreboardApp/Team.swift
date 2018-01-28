//
//  Team.swift
//  ScoreboardApp
//
//  Created by Josh Maloney on 27/1/18.
//  Copyright © 2018 Josh Maloney. All rights reserved.
//

import Foundation
import UIKit

enum MLBDivision {
    case ALEast
    case ALCentral
    case ALWest
    case NLEast
    case NLCentral
    case NLWest
}

class Team {
    let teamName: String
    let nickname: String
    let teamLogo: UIImage?
    let division: MLBDivision
    
    init(teamName: String, nickname: String, teamLogo: UIImage?, mlbdivison: MLBDivision) {
        self.teamName = teamName
        self.nickname = nickname
        self.teamLogo = teamLogo
        self.division = mlbdivison
    }
}
