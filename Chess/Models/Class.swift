//
//  Class.swift
//  Chess
//
//  Created by Rishi Jansari on 21/08/2026.
//

import Foundation

enum Class: String, Comparable {
    case pawn
    case rook
    case knight
    case bishop
    case queen
    case king
    
    static func < (lhs: Class, rhs: Class) -> Bool {
        switch (lhs, rhs) {
            case (.pawn, _): true
            case (.knight, .pawn): false
            case (.bishop, .pawn), (.bishop, .knight): false
            case (.rook, .pawn), (.rook, .knight), (.rook, .bishop): false
            case (.queen, .pawn), (.queen, .knight), (.queen, .bishop), (.queen, .rook): false
            case (.king, _): false
            default: true
        }
    }
}
