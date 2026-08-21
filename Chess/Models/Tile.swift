//
//  Tile.swift
//  Chess
//
//  Created by Rishi Jansari on 21/08/2026.
//

import Foundation

struct Tile: Identifiable, Equatable {
    let id: String
    let position: Position
    var piece: Piece?
    var isHighlighted: Bool = false
}
