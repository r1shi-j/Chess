//
//  PiecePerspective.swift
//  Chess
//
//  Created by Rishi Jansari on 21/08/2026.
//

import Foundation

enum PiecePerspective: String, CaseIterable {
    case oneWay = "One way"
    case showSelf = "Show self"
    case rotating = "Rotating"
    
    var description: String {
        switch self {
            case .oneWay: "One way will show all pieces the correct orientation for the white team, and upside down for the black team."
            case .showSelf: "Show self will show all pieces on your team the correct orientation and all pieces on the other team upside down."
            case .rotating: "Rotating will rotate all pieces to be the correct orientation for the team whose move it is."
        }
    }
}
