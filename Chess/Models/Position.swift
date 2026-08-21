//
//  Position.swift
//  Chess
//
//  Created by Rishi Jansari on 21/08/2026.
//

import Foundation

enum Position {
    case a8, b8, c8, d8, e8, f8, g8, h8
    case a7, b7, c7, d7, e7, f7, g7, h7
    case a6, b6, c6, d6, e6, f6, g6, h6
    case a5, b5, c5, d5, e5, f5, g5, h5
    case a4, b4, c4, d4, e4, f4, g4, h4
    case a3, b3, c3, d3, e3, f3, g3, h3
    case a2, b2, c2, d2, e2, f2, g2, h2
    case a1, b1, c1, d1, e1, f1, g1, h1
    
    static func fromIndex(row: Int, col: Int) -> Position {
        switch (row, col) {
            case (0, 0): .a8
            case (0, 1): .b8
            case (0, 2): .c8
            case (0, 3): .d8
            case (0, 4): .e8
            case (0, 5): .f8
            case (0, 6): .g8
            case (0, 7): .h8
                
            case (1, 0): .a7
            case (1, 1): .b7
            case (1, 2): .c7
            case (1, 3): .d7
            case (1, 4): .e7
            case (1, 5): .f7
            case (1, 6): .g7
            case (1, 7): .h7
                
            case (2, 0): .a6
            case (2, 1): .b6
            case (2, 2): .c6
            case (2, 3): .d6
            case (2, 4): .e6
            case (2, 5): .f6
            case (2, 6): .g6
            case (2, 7): .h6
                
            case (3, 0): .a5
            case (3, 1): .b5
            case (3, 2): .c5
            case (3, 3): .d5
            case (3, 4): .e5
            case (3, 5): .f5
            case (3, 6): .g5
            case (3, 7): .h5
                
            case (4, 0): .a4
            case (4, 1): .b4
            case (4, 2): .c4
            case (4, 3): .d4
            case (4, 4): .e4
            case (4, 5): .f4
            case (4, 6): .g4
            case (4, 7): .h4
                
            case (5, 0): .a3
            case (5, 1): .b3
            case (5, 2): .c3
            case (5, 3): .d3
            case (5, 4): .e3
            case (5, 5): .f3
            case (5, 6): .g3
            case (5, 7): .h3
                
            case (6, 0): .a2
            case (6, 1): .b2
            case (6, 2): .c2
            case (6, 3): .d2
            case (6, 4): .e2
            case (6, 5): .f2
            case (6, 6): .g2
            case (6, 7): .h2
                
            case (7, 0): .a1
            case (7, 1): .b1
            case (7, 2): .c1
            case (7, 3): .d1
            case (7, 4): .e1
            case (7, 5): .f1
            case (7, 6): .g1
            case (7, 7): .h1
                
            default: .a1
        }
    }
    
    func toIndex() -> (row: Int, col: Int) {
        switch self {
            case .a8: (0, 0)
            case .b8: (0, 1)
            case .c8: (0, 2)
            case .d8: (0, 3)
            case .e8: (0, 4)
            case .f8: (0, 5)
            case .g8: (0, 6)
            case .h8: (0, 7)
                
            case .a7: (1, 0)
            case .b7: (1, 1)
            case .c7: (1, 2)
            case .d7: (1, 3)
            case .e7: (1, 4)
            case .f7: (1, 5)
            case .g7: (1, 6)
            case .h7: (1, 7)
                
            case .a6: (2, 0)
            case .b6: (2, 1)
            case .c6: (2, 2)
            case .d6: (2, 3)
            case .e6: (2, 4)
            case .f6: (2, 5)
            case .g6: (2, 6)
            case .h6: (2, 7)
                
            case .a5: (3, 0)
            case .b5: (3, 1)
            case .c5: (3, 2)
            case .d5: (3, 3)
            case .e5: (3, 4)
            case .f5: (3, 5)
            case .g5: (3, 6)
            case .h5: (3, 7)
                
            case .a4: (4, 0)
            case .b4: (4, 1)
            case .c4: (4, 2)
            case .d4: (4, 3)
            case .e4: (4, 4)
            case .f4: (4, 5)
            case .g4: (4, 6)
            case .h4: (4, 7)
                
            case .a3: (5, 0)
            case .b3: (5, 1)
            case .c3: (5, 2)
            case .d3: (5, 3)
            case .e3: (5, 4)
            case .f3: (5, 5)
            case .g3: (5, 6)
            case .h3: (5, 7)
                
            case .a2: (6, 0)
            case .b2: (6, 1)
            case .c2: (6, 2)
            case .d2: (6, 3)
            case .e2: (6, 4)
            case .f2: (6, 5)
            case .g2: (6, 6)
            case .h2: (6, 7)
                
            case .a1: (7, 0)
            case .b1: (7, 1)
            case .c1: (7, 2)
            case .d1: (7, 3)
            case .e1: (7, 4)
            case .f1: (7, 5)
            case .g1: (7, 6)
            case .h1: (7, 7)
        }
    }
}
