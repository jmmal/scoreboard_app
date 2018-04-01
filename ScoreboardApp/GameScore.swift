//
//  GameScore.swift
//  ScoreboardApp
//
//  Created by Josh Maloney on 1/4/18.
//  Copyright © 2018 Josh Maloney. All rights reserved.
//

import Foundation
struct GameScore : Codable {
    let game : Game
//    let isUnplayed : Bool
//    let isInProgress : Bool
//    let isCompleted : Bool
//    let playStatus : String
    let awayScore : String
    let homeScore : String
    let inningSummary : InningSummary
    
//    enum CodingKeys: String, CodingKey {
//
//        case game
//        case isUnplayed = "isUnplayed"
//        case isInProgress = "isInProgress"
//        case isCompleted = "isCompleted"
//        case playStatus = "playStatus"
//        case awayScore = "awayScore"
//        case homeScore = "homeScore"
//        case inningSummary
//    }
    
}
