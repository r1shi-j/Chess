//
//  EndState.swift
//  Chess
//
//  Created by Rishi Jansari on 21/08/2026.
//

import Foundation

enum EndState: String {
    case manual = "Manual"
    case draw = "Draw"
    case checkmate = "Checkmate"
    case stalemate = "Stalemate"
    
    func description() -> String {
        switch self {
            case .manual:
                "Game ended manually"
            case .draw:
                "Draw by insufficient material"
            case .checkmate:
                "Game ended via checkmate"
            case .stalemate:
                "Game ended via stalemate"
        }
    }
}
