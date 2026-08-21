//
//  Piece.swift
//  Chess
//
//  Created by Rishi Jansari on 21/08/2026.
//

import Foundation

struct Piece: Equatable, Identifiable, Comparable {
    let id: UUID = UUID()
    var type: Class
    let side: Side
    var position: Position
    var hasMoved = false
    
    func imageName() -> String {
        "\(self.type.rawValue).\(self.side == .black ? "black" : "white")"
    }
    
    static func < (lhs: borrowing Piece, rhs: borrowing Piece) -> Bool {
        lhs.type < rhs.type
    }
}
