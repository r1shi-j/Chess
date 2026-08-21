//
//  EndState.swift
//  Chess
//
//  Created by Rishi Jansari on 21/08/2026.
//

import Foundation

enum EndState: String {
    case manual = "Manual"
    case userDraw = "Draw"
    case autoDraw = "Draw (auto)"
    case checkmate = "Checkmate"
    case stalemate = "Stalemate"
    
    func description() -> String {
        switch self {
            case .manual:
                "Game ended manually"
            case .userDraw:
                "Players agreed on a draw"
            case .autoDraw:
                "Draw by insufficient material"
            case .checkmate:
                "Game ended via checkmate"
            case .stalemate:
                "Game ended via stalemate"
        }
    }
}
