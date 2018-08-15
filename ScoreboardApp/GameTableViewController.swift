//
//  GameTableViewController.swift
//  ScoreboardApp
//
//  Created by Josh Maloney on 27/1/18.
//  Copyright © 2018 Josh Maloney. All rights reserved.
//

import UIKit
import SpriteKit
import Alamofire
import SwiftyJSON

class GameTableViewController: UITableViewController {
    //MARK: Properties
    var games = [JSON]()
    var teams = [String: Team]()
    var logos = [UIImage]()
    
    let API_URL = "http://api.sportradar.us/mlb/trial/v6.5/en/games/2018/04/01/boxscore.json"
    let TEST_URL = "http://localhost:3000/league"
    let TEST_KEY = "jc6kwm9e9w67mx9bk78xbrws"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTeams()
        loadGames()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Networking
    func loadGames() {
//        let params: [String : String] = ["api_key" : TEST_KEY]
        let params = [String : String]()
        Alamofire.request(TEST_URL, method: .get, parameters: params).responseJSON { response in
            if response.result.isSuccess {
                print("Success! Got the score data")
                
                let scoreboardJSON : JSON = JSON(response.result.value!)
                
//                print(scoreboardJSON)
                self.updateScoreboard(json: scoreboardJSON)
            }
            else {
                print("Error \(String(describing: response.result.error))")
            }
            
            DispatchQueue.global().async(execute: {
                print("teste")
                DispatchQueue.main.sync{
                    print("main thread")
                    self.tableView.reloadData()
                }
            })
        }
    }
    
    
    // MARK: - Table View Rendering
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Games #: \(games.count)")
        return games.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("running...")
        // Table view cells are reused and should be dequeued using a cell identifier
        let cellIdentifier = "GameTableViewCell"

        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as?
            GameTableViewCell else {
                fatalError("The dequeued cell is not an instance of GameTableViewCell.")
        }

        // Fetches the appropriate meal for the data source layout
        let game = games[indexPath.row]
        
        loadTeamNames(cell: cell, game: game)
        loadInnings(cell: cell, game: game)
//        loadTotals(cell: cell, game: game)

        print("cpompleted")
        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
    
    // MARK: - Prepare Seed Data
    private func initTeams() {
        prepareLogos()
        
        // AL East
        teams["nyy"] = Team(teamName: "New York Yankees", nickname: "Yankees", teamLogo: logos[16], mlbdivison: .ALEast)
        teams["bos"] = Team(teamName: "Boston Red Sox", nickname: "Red Sox", teamLogo: logos[31], mlbdivison: .ALEast)
        teams["tor"] = Team(teamName: "Toronto Blue Jays", nickname: "Blue Jays", teamLogo: logos[6], mlbdivison: .ALEast)
        teams["bal"] = Team(teamName: "Baltimore Orioles", nickname: "Orioles", teamLogo: logos[32], mlbdivison: .ALEast)
        teams["tb" ] = Team(teamName: "Tampa Bay Rays", nickname: "Rays", teamLogo: logos[8], mlbdivison: .ALEast)
        teams["min"] = Team(teamName: "Minesota Twins", nickname: "Twins", teamLogo: logos[18], mlbdivison: .ALCentral)
        teams["cle"] = Team(teamName: "Cleveland Indians", nickname: "Indians", teamLogo: logos[28], mlbdivison: .ALCentral)
        teams["cws"] = Team(teamName: "Chicago White Dox", nickname: "White Sox", teamLogo: logos[26], mlbdivison: .ALCentral)
        teams["kc" ] = Team(teamName: "Kansas City Royals", nickname: "Royals", teamLogo: logos[23], mlbdivison: .ALCentral)
        teams["det"] = Team(teamName: "Detroit Tigers", nickname: "Tigers", teamLogo: logos[25], mlbdivison: .ALCentral)
        teams["laa"] = Team(teamName: "Los Angeles Angels", nickname: "Angels", teamLogo: logos[22], mlbdivison: .ALWest)
        teams["hou"] = Team(teamName: "Houston Astros", nickname: "Astros", teamLogo: logos[24], mlbdivison: .ALWest)
        teams["tex"] = Team(teamName: "Texas Rangers", nickname: "Rangers", teamLogo: logos[7], mlbdivison: .ALWest)
        teams["sea"] = Team(teamName: "Seattle Mariners", nickname: "Mariners", teamLogo: logos[11], mlbdivison: .ALWest)
        teams["oak"] = Team(teamName: "Oakland Athletics", nickname: "Athletics", teamLogo: logos[15], mlbdivison: .ALWest)
        teams["wsh"] = Team(teamName: "Washington Nationals", nickname: "Nationals", teamLogo: logos[5], mlbdivison: .NLEast)
        teams["mia"] = Team(teamName: "Miami Marlins", nickname: "Marlins", teamLogo: logos[20], mlbdivison: .NLEast)
        teams["atl"] = Team(teamName: "Atlanta Braves", nickname: "Braves", teamLogo: logos[33], mlbdivison: .NLEast)
        teams["nym"] = Team(teamName: "New York Mets", nickname: "Mets", teamLogo: logos[17], mlbdivison: .NLEast)
        teams["phi"] = Team(teamName: "Philadelphia Phillies", nickname: "Phillies", teamLogo: logos[14], mlbdivison: .NLEast)
        teams["chc"] = Team(teamName: "Chicago Cubs", nickname: "Cubs", teamLogo: logos[30], mlbdivison: .NLCentral)
        teams["mil"] = Team(teamName: "Milwaukee Brewers", nickname: "Brewers", teamLogo: logos[19], mlbdivison: .NLCentral)
        teams["stl"] = Team(teamName: "St. Louis Cardinals", nickname: "Cardinals", teamLogo: logos[9], mlbdivison: .NLCentral)
        teams["pit"] = Team(teamName: "Pittsburg Pirates", nickname: "Pirates", teamLogo: logos[13], mlbdivison: .NLCentral)
        teams["cin"] = Team(teamName: "Cincinatti Reds", nickname: "Reds", teamLogo: logos[29], mlbdivison: .NLCentral)
        teams["lad"] = Team(teamName: "Los Angeles Dodgers", nickname: "Dodgers", teamLogo: logos[21], mlbdivison: .NLWest)
        teams["ari"] = Team(teamName: "Arizona Diamondbacks", nickname: "D. Backs", teamLogo: logos[34], mlbdivison: .NLWest)
        teams["col"] = Team(teamName: "Colorado Rockies", nickname: "Rockies", teamLogo: logos[27], mlbdivison: .NLWest)
        teams["sd" ] = Team(teamName: "San Diego Padres", nickname: "Padres", teamLogo: logos[12], mlbdivison: .NLWest)
        teams["sf" ] = Team(teamName: "San Fransisco Giants", nickname: "Giants", teamLogo: logos[10], mlbdivison: .NLWest)
    }
    
    private func prepareLogos() {
        let spriteSheet: SKTexture = SKTexture(image: #imageLiteral(resourceName: "team_logos"))
        
        let textures = SpriteSheet(texture: spriteSheet, rows: 36, columns: 2)
        
        for i in 0...36 {
            let logoTexture = textures.textureForColumn(column: 1, row: i)
            var logoImage: UIImage = UIImage()
            
            if logoTexture?.cgImage() != nil {
                logoImage = UIImage(cgImage: (logoTexture?.cgImage())!)
                logos.append(logoImage)
            }
        }
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        super.prepare(for: segue, sender: sender)
    }
    

    // MARK: - Update UI Elements
    func updateScoreboard(json: JSON) {
        if let gamesData = json["league"]["games"].array {
            for game in gamesData {
                games.append(game)
            }
        }
//        print(games)
    }
    
    func loadTeamNames(cell: GameTableViewCell, game: JSON) {
        let home = teams[game["game"]["home"]["abbr"].stringValue.lowercased()]
        let away = teams[game["game"]["away"]["abbr"].stringValue.lowercased()]
        
        cell.homeTeamLabel.text = home?.nickname
        cell.awayTeamLabel.text = away?.nickname
//        cell.homeTeamLogo.image = home?.teamLogo
//        cell.awayTeamLogo.image = away?.teamLogo
//        cell.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)
    }
    
//    private func loadTotals(cell: GameTableViewCell, game: GameScore) {
//        for view in cell.totals.subviews {
//            view.removeFromSuperview()
//        }
//
//        let rLabel = UILabel()
//        let hLabel = UILabel()
//        let eLabel = UILabel()
//
//        rLabel.text = "R"
//        hLabel.text = "H"
//        eLabel.text = "E"
//
//        rLabel.font = rLabel.font.withSize(12.0)
//        hLabel.font = hLabel.font.withSize(12.0)
//        eLabel.font = eLabel.font.withSize(12.0)
//
//        rLabel.textAlignment = .center
//        hLabel.textAlignment = .center
//        eLabel.textAlignment = .center
//
//        cell.totals.addArrangedSubview(rLabel)
//        cell.totals.addArrangedSubview(hLabel)
//        cell.totals.addArrangedSubview(eLabel)
//
//    }
    
    private func loadInnings(cell: GameTableViewCell, game: JSON) {
        for view in cell.awayInnings.subviews {
            view.removeFromSuperview()
        }

        for view in cell.inningNumber.subviews {
            view.removeFromSuperview()
        }

        for view in cell.homeInnings.subviews {
            view.removeFromSuperview()
        }
        
        if let awayInningsArray = game["game"]["away"]["scoring"].array {
            print("yup")
            for (index, inning) in awayInningsArray.enumerated() {
                // Add inning number
                let inningLabel = UILabel()
                inningLabel.text = String(describing: index + 1)
                inningLabel.font = inningLabel.font.withSize(12.0)
                inningLabel.textColor = .lightGray
                inningLabel.textAlignment = .center
                
                // Add away label
                let awayLabel = UILabel()
                awayLabel.text = String(describing: inning["runs"].stringValue)
                awayLabel.font = awayLabel.font.withSize(12.0)
                
                if awayLabel.text == "0" {
                    awayLabel.textColor = .lightGray
                } else {
                    awayLabel.font = UIFont.boldSystemFont(ofSize: 12.0)
                }
                
                awayLabel.textAlignment = .center
                cell.inningNumber.addArrangedSubview(inningLabel)
                cell.awayInnings.addArrangedSubview(awayLabel)
            }
        }
        
        if let homeInnings = game["game"]["home"]["scoring"].array {
            print("yup2")
            for inning in homeInnings {
                // Add home label
                let homeLabel = UILabel()
                homeLabel.text = String(describing: inning["runs"].stringValue)
                homeLabel.font = homeLabel.font.withSize(12.0)
                if homeLabel.text == "0" {
                    homeLabel.textColor = .lightGray
                } else {
                    homeLabel.font = UIFont.boldSystemFont(ofSize: 12.0)
                }
                homeLabel.textAlignment = .center
                cell.homeInnings.addArrangedSubview(homeLabel)
            }
        }
    }
}
