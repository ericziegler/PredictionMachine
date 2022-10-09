//
//  Team.swift
//  PredictionMachine
//
//  Created by Eric Ziegler on 10/8/22.
//

import Foundation

enum Team: String, Codable {
    case patriots = "NE"
    case jets = "NYJ"
    case dolphins = "MIA"
    case bills = "BUF"
    case colts = "IND"
    case texans = "HOU"
    case jaguars = "JAX"
    case titans = "TEN"
    case bengals = "CIN"
    case browns = "CLE"
    case steelers = "PIT"
    case ravens = "BAL"
    case chiefs = "KC"
    case raiders = "LV"
    case chargers = "LAC"
    case broncos = "DEN"
    case eagles = "PHI"
    case cowboys = "DAL"
    case commanders = "WSH"
    case giants = "NYG"
    case panthers = "CAR"
    case buccaneers = "TB"
    case saints = "NO"
    case falcons = "ATL"
    case packers = "GB"
    case vikings = "MIN"
    case bears = "CHI"
    case lions = "DET"
    case seahawks = "SEA"
    case fortyNiners = "SF"
    case cardinals = "ARI"
    case rams = "LAR"
    
    var location: String {
        switch self {
        case .patriots:
            return "New England"
        case .jets:
            return "New York"
        case .dolphins:
            return "Miami"
        case .bills:
            return "Buffalo"
        case .colts:
            return "Indianapolis"
        case .texans:
            return "Houston"
        case .jaguars:
            return "Jacksonville"
        case .titans:
            return "Tennessee"
        case .bengals:
            return "Cincinnati"
        case .browns:
            return "Cleveland"
        case .steelers:
            return "Pittsburgh"
        case .ravens:
            return "Baltimore"
        case .chiefs:
            return "Kansas City"
        case .raiders:
            return "Las Vegas"
        case .chargers:
            return "Los Angeles"
        case .broncos:
            return "Denver"
        case .eagles:
            return "Philadelphia"
        case .cowboys:
            return "Dallas"
        case .commanders:
            return "Washington"
        case .giants:
            return "New York"
        case .panthers:
            return "Carolina"
        case .buccaneers:
            return "Tampa Bay"
        case .saints:
            return "New Orleans"
        case .falcons:
            return "Atlanta"
        case .packers:
            return "Green Bay"
        case .vikings:
            return "Minnesota"
        case .bears:
            return "Chicago"
        case .lions:
            return "Detroit"
        case .seahawks:
            return "Seattle"
        case .fortyNiners:
            return "San Francisco"
        case .cardinals:
            return "Arizona"
        case .rams:
            return "Los Angeles"
        }
    }
    
    var name: String {
        switch self {
        case .patriots:
            return "Patriots"
        case .jets:
            return "Jets"
        case .dolphins:
            return "Dolphins"
        case .bills:
            return "Bills"
        case .colts:
            return "Colts"
        case .texans:
            return "Texans"
        case .jaguars:
            return "Jaguars"
        case .titans:
            return "Titans"
        case .bengals:
            return "Bengals"
        case .browns:
            return "Browns"
        case .steelers:
            return "Steelers"
        case .ravens:
            return "Ravens"
        case .chiefs:
            return "Chiefs"
        case .raiders:
            return "Raiders"
        case .chargers:
            return "Chargers"
        case .broncos:
            return "Broncos"
        case .eagles:
            return "Eagles"
        case .cowboys:
            return "Cowboys"
        case .commanders:
            return "Commanders"
        case .giants:
            return "Giants"
        case .panthers:
            return "Panthers"
        case .buccaneers:
            return "Buccaneers"
        case .saints:
            return "Saints"
        case .falcons:
            return "Falcons"
        case .packers:
            return "Packers"
        case .vikings:
            return "Vikings"
        case .bears:
            return "Bears"
        case .lions:
            return "Lions"
        case .seahawks:
            return "Seahawks"
        case .fortyNiners:
            return "49ers"
        case .cardinals:
            return "Cardinals"
        case .rams:
            return "Rams"
        }
    }
    
    var image: String {
        return self.rawValue
    }
    
    var primaryColor: String {
        switch self {
        case .patriots:
            return "092142"
        case .jets:
            return "285642"
        case .dolphins:
            return "3e8c95"
        case .bills:
            return "113288"
        case .colts:
            return "113265"
        case .texans:
            return "04143c"
        case .jaguars:
            return "2b6576"
        case .titans:
            return "092142"
        case .bengals:
            return "101010"
        case .browns:
            return "2e1e05"
        case .steelers:
            return "101010"
        case .ravens:
            return "1f1744"
        case .chiefs:
            return "d0343e"
        case .raiders:
            return "a6acaf"
        case .chargers:
            return "367ec0"
        case .broncos:
            return "112241"
        case .eagles:
            return "1c4750"
        case .cowboys:
            return "092142"
        case .commanders:
            return "521a17"
        case .giants:
            return "#102161"
        case .panthers:
            return "3983c4"
        case .buccaneers:
            return "992934"
        case .saints:
            return "cfbd93"
        case .falcons:
            return "992934"
        case .packers:
            return "253631"
        case .vikings:
            return "4a287e"
        case .bears:
            return "0d1629"
        case .lions:
            return "3174b1"
        case .seahawks:
            return "092142"
        case .fortyNiners:
            return "9c1f14"
        case .cardinals:
            return "8b2d40"
        case .rams:
            return "12348e"
        }
    }
    
}
