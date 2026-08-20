//
//  ContentView.swift
//  Chess
//
//  Created by Rishi Jansari on 18/08/2026.
//

import SwiftUI

//enum GameState {
//    case stopped, playing, paused, finished
//}

enum Side: String {
    case black = "Black"
    case white = "White"
    
    mutating func toggle() {
        self = self == .black ? .white : .black
    }
}

enum Class: String, Comparable {
    static func < (lhs: Class, rhs: Class) -> Bool {
        switch (lhs, rhs) {
            case (.pawn, _): true
            case (.knight, .pawn): false
            case (.bishop, .pawn), (.bishop, .knight): false
            case (.rook, .pawn), (.rook, .knight), (.rook, .bishop): false
            case (.queen, .pawn), (.queen, .knight), (.queen, .bishop), (.queen, .rook): false
            case (.king, _): false
//            case (let a, let b): a == b
            default: true
        }
    }
    
    case pawn// = ""
    case rook// = "R"
    case knight// = "N"
    case bishop// = "B"
    case queen// = "Q"
    case king// = //"K"
}

enum Position {
    case a8, b8, c8, d8, e8, f8, g8, h8
    case a7, b7, c7, d7, e7, f7, g7, h7
    case a6, b6, c6, d6, e6, f6, g6, h6
    case a5, b5, c5, d5, e5, f5, g5, h5
    case a4, b4, c4, d4, e4, f4, g4, h4
    case a3, b3, c3, d3, e3, f3, g3, h3
    case a2, b2, c2, d2, e2, f2, g2, h2
    case a1, b1, c1, d1, e1, f1, g1, h1
    
    static func from(row: Int, col: Int) -> Position {
        switch (row, col) {
            case (1, 1): .a1
            case (1, 2): .b1
            case (1, 3): .c1
            case (1, 4): .d1
            case (1, 5): .e1
            case (1, 6): .f1
            case (1, 7): .g1
            case (1, 8): .h1
            
            case (2, 1): .a2
            case (2, 2): .b2
            case (2, 3): .c2
            case (2, 4): .d2
            case (2, 5): .e2
            case (2, 6): .f2
            case (2, 7): .g2
            case (2, 8): .h2
                
            case (3, 1): .a3
            case (3, 2): .b3
            case (3, 3): .c3
            case (3, 4): .d3
            case (3, 5): .e3
            case (3, 6): .f3
            case (3, 7): .g3
            case (3, 8): .h3
                
            case (4, 1): .a4
            case (4, 2): .b4
            case (4, 3): .c4
            case (4, 4): .d4
            case (4, 5): .e4
            case (4, 6): .f4
            case (4, 7): .g4
            case (4, 8): .h4
                
            case (5, 1): .a5
            case (5, 2): .b5
            case (5, 3): .c5
            case (5, 4): .d5
            case (5, 5): .e5
            case (5, 6): .f5
            case (5, 7): .g5
            case (5, 8): .h5
                
            case (6, 1): .a6
            case (6, 2): .b6
            case (6, 3): .c6
            case (6, 4): .d6
            case (6, 5): .e6
            case (6, 6): .f6
            case (6, 7): .g6
            case (6, 8): .h6
                
            case (7, 1): .a7
            case (7, 2): .b7
            case (7, 3): .c7
            case (7, 4): .d7
            case (7, 5): .e7
            case (7, 6): .f7
            case (7, 7): .g7
            case (7, 8): .h7
                
            case (8, 1): .a8
            case (8, 2): .b8
            case (8, 3): .c8
            case (8, 4): .d8
            case (8, 5): .e8
            case (8, 6): .f8
            case (8, 7): .g8
            case (8, 8): .h8
                
            default: .a1
        }
    }
    
    func to() -> (row: Int, col: Int) {
        switch self {
            case .a1: (1, 1)
            case .b1: (1, 2)
            case .c1: (1, 3)
            case .d1: (1, 4)
            case .e1: (1, 5)
            case .f1: (1, 6)
            case .g1: (1, 7)
            case .h1: (1, 8)
                
            case .a2: (2, 1)
            case .b2: (2, 2)
            case .c2: (2, 3)
            case .d2: (2, 4)
            case .e2: (2, 5)
            case .f2: (2, 6)
            case .g2: (2, 7)
            case .h2: (2, 8)
                
            case .a3: (3, 1)
            case .b3: (3, 2)
            case .c3: (3, 3)
            case .d3: (3, 4)
            case .e3: (3, 5)
            case .f3: (3, 6)
            case .g3: (3, 7)
            case .h3: (3, 8)
                
            case .a4: (4, 1)
            case .b4: (4, 2)
            case .c4: (4, 3)
            case .d4: (4, 4)
            case .e4: (4, 5)
            case .f4: (4, 6)
            case .g4: (4, 7)
            case .h4: (4, 8)
                
            case .a5: (5, 1)
            case .b5: (5, 2)
            case .c5: (5, 3)
            case .d5: (5, 4)
            case .e5: (5, 5)
            case .f5: (5, 6)
            case .g5: (5, 7)
            case .h5: (5, 8)
                
            case .a6: (6, 1)
            case .b6: (6, 2)
            case .c6: (6, 3)
            case .d6: (6, 4)
            case .e6: (6, 5)
            case .f6: (6, 6)
            case .g6: (6, 7)
            case .h6: (6, 8)
                
            case .a7: (7, 1)
            case .b7: (7, 2)
            case .c7: (7, 3)
            case .d7: (7, 4)
            case .e7: (7, 5)
            case .f7: (7, 6)
            case .g7: (7, 7)
            case .h7: (7, 8)
                
            case .a8: (8, 1)
            case .b8: (8, 2)
            case .c8: (8, 3)
            case .d8: (8, 4)
            case .e8: (8, 5)
            case .f8: (8, 6)
            case .g8: (8, 7)
            case .h8: (8, 8)
        }
    }
}

struct Piece: Equatable, Identifiable, Comparable {
    let id: UUID = UUID()
    var type: Class
    let side: Side
    var position: Position
    
//    func image() -> String {
//        switch self.type {
//            case .pawn: side == .black ? "♟\u{FE0E}" : "♙\u{FE0E}"
//            case .rook: side == .black ? "♜\u{FE0E}" : "♖\u{FE0E}"
//            case .knight: side == .black ? "♞\u{FE0E}" : "♘\u{FE0E}"
//            case .bishop: side == .black ? "♝\u{FE0E}" : "♗\u{FE0E}"
//            case .king: side == .black ? "♚\u{FE0E}" : "♔\u{FE0E}"
//            case .queen: side == .black ? "♛\u{FE0E}" : "♕\u{FE0E}"
//        }
//    }
    
    func imageName() -> String {
        "\(self.type.rawValue).\(self.side == .black ? "black" : "white")"
    }
    
    static func < (lhs: borrowing Piece, rhs: borrowing Piece) -> Bool {
        lhs.type < rhs.type
    }
}

struct Tile: Identifiable, Equatable {
    let id: String
    let position: Position
    var piece: Piece?
    var isHighlighted: Bool = false
}

struct ContentView: View {
//    let isHelper: Bool
    
    @State private var gameBoard: [[Tile]]
    @State private var gameBoard2: [[Tile]] = []
    @State private var selectedTile: Tile?
    @State private var whoMoves: Side = .white
    @State private var whiteDeaths: [Piece] = []
    @State private var blackDeaths: [Piece] = []
    
    init() {
//        self.isHelper = isHelper
        var gameBoard: [[Tile]] = []
        for row in 1..<9 {
            gameBoard.append([])
            for col in 1..<9 {
                let rowText = String(9-row)
                let colText = String(Character(UnicodeScalar(col+64+32)!))
                gameBoard[row-1].append(Tile(id: "\(rowText)\(colText)", position: Position.from(row: row, col: col)))
            }
        }
        _gameBoard = State(initialValue: gameBoard)
    }
    
    private let accentColor: Color = .gray.mix(with: .yellow, by: 0.5).mix(with: .white, by: 0.5)
    
    var body: some View {
        ZStack {
            Color.brown.mix(with: .black, by: 0.3).ignoresSafeArea()
            
            VStack(spacing: 20) {
#if os(iOS)
                Text("\(whoMoves.rawValue.lowercased()) move")
                    .font(.system(.largeTitle, design: .serif, weight: .black))
                    .foregroundStyle(whoMoves == .black ? .black : accentColor)
                    .rotationEffect(.degrees(180))
                    .border(isInCheck ? .red : .clear)
#endif
                
                ZStack {
                    Rectangle()
                        .fill(accentColor)
                        .opacity(0.7)
                    LazyHGrid(rows: [.init(.fixed(20)), .init(.fixed(20))], alignment: .center, spacing: 5) {
                        ForEach(whiteDeaths.sorted(), id: \.id) { piece in
                            Image(piece.imageName())
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: 20, maxHeight: 20)
                        }
                    }
                    if whiteDeaths.count == 0 {
                        Text("Jail")
                            .font(.system(.largeTitle, design: .serif, weight: .thin))
                            .foregroundStyle(accentColor.opacity(0.25))
                    }
                }
                .rotationEffect(.degrees(180))
                .frame(width: 200, height: 70)
                
                HStack {
#if os(macOS)
                    Text("\(whoMoves.rawValue.lowercased()) move")
                        .font(.system(.largeTitle, design: .serif, weight: .black))
                        .foregroundStyle(whoMoves == .black ? .black : accentColor)
                        .fixedSize()
                        .rotationEffect(.degrees(-90))
                        .frame(width: 40, height: 200)
                        .padding(.horizontal)
                        .border(isInCheck ? .red : .clear)
#endif
                    
                    VStack {
                        gameGrid()
//                        if gameBoard2.count > 0 {
//                            gameGrid2()
//                        } else {
//                            Rectangle().frame(width: 400, height: 400).opacity(0)
//                        }
                    }
                    
#if os(macOS)
                    Text("\(whoMoves.rawValue.lowercased()) move")
                        .font(.system(.largeTitle, design: .serif, weight: .black))
                        .foregroundStyle(whoMoves == .black ? .black : accentColor)
                        .fixedSize()
                        .rotationEffect(.degrees(90))
                        .frame(width: 40, height: 200)
                        .padding(.horizontal)
                        .border(isInCheck ? .red : .clear)
#endif
                }
                
                ZStack {
                    Rectangle()
                        .fill(accentColor)
                        .opacity(0.7)
                    LazyHGrid(rows: [.init(.fixed(20)), .init(.fixed(20))], alignment: .center, spacing: 5) {
                        ForEach(blackDeaths.sorted(), id: \.id) { piece in
                            Image(piece.imageName())
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: 25, maxHeight: 25)
                            
                        }
                    }
                    if blackDeaths.count == 0 {
                        Text("Jail")
                            .font(.system(.largeTitle, design: .serif, weight: .thin))
                            .foregroundStyle(accentColor.opacity(0.25))
                    }
                }
                .frame(width: 200, height: 70)
                
#if os(iOS)
                Text("\(whoMoves.rawValue.lowercased()) move")
                    .font(.system(.largeTitle, design: .serif, weight: .black))
                    .foregroundStyle(whoMoves == .black ? .black : accentColor)
#endif
            }
            .padding(40)
        }
        //        .animation(.bouncy, value: gameBoard)
                .frame(width: 700, height: 1000)
        .onAppear() {
            defaultSetup()
        }
    }
    
    func gameGrid2() -> some View {
        Grid(alignment: .center, horizontalSpacing: 0, verticalSpacing: 0) {
            ForEach(0..<10) { row in
                GridRow {
                    ForEach(0..<10) { col in
                        if row == 0 || col == 0 || row == 9 || col == 9 {
                            edgeLabel(row, col)
                        } else {
                            tile(row, col, gameBoard2[row-1][col-1])
                        }
                    }
                }
            }
        }
    }
    
    func gameGrid() -> some View {
        Grid(alignment: .center, horizontalSpacing: 0, verticalSpacing: 0) {
            ForEach(0..<10) { row in
                GridRow {
                    ForEach(0..<10) { col in
                        if row == 0 || col == 0 || row == 9 || col == 9 {
                            edgeLabel(row, col)
                        } else {
                            tile(row, col, gameBoard[row-1][col-1])
                                .transition(.opacity)
                                
                                .onTapGesture {
                                    // if we have a tile selected
                                    if let selectedTile {
                                        if selectedTile.piece == gameBoard[row-1][col-1].piece {
                                            // if selects the same tile then deselect it
                                            withAnimation(.easeOut) {
                                                resetHighlightedTiles()
                                                self.selectedTile = nil
                                            }
                                        } else if let piece = gameBoard[row-1][col-1].piece, piece.side == whoMoves {
                                            // if selects a different piece on same team then show options for that tile
                                            withAnimation(.easeIn) {
                                                resetHighlightedTiles()
                                                self.selectedTile = gameBoard[row-1][col-1]
                                                showAvailableMoves(for: piece, row-1, col-1)
                                            }
                                        } else {
                                            // else selects enemy or empty tile: standard move
                                            
                                            // only continue if clicked tile is highlighted
                                            guard gameBoard[row-1][col-1].isHighlighted else { return }
                                            if isInCheck { isInCheck = false }
//                                            print("we are", isInCheck)
//                                            if isInCheck {
//                                                gameBoard2 = gameBoard
//                                                
//                                                // if tries to take king do nothing
//                                                if gameBoard2[row-1][col-1].piece?.type == .king {
//                                                    print("elelelel")
//                                                    return
//                                                }
//                                                
//                                                // swapping the two pieces
//                                                let oldPos = selectedTile.position.to()
//                                                gameBoard2[row-1][col-1].piece = gameBoard2[oldPos.row-1][oldPos.col-1].piece
//                                                gameBoard2[oldPos.row-1][oldPos.col-1].piece = nil
////                                                
//                                                // if pawn reach end turn it into a queen
//                                                if gameBoard2[row-1][col-1].piece?.type == .pawn {
//                                                    if gameBoard2[row-1][col-1].piece?.side == .white && row == 1 {
//                                                        gameBoard2[row-1][col-1].piece?.type = .queen
//                                                    } else if gameBoard2[row-1][col-1].piece?.side == .black && row == 8 {
//                                                        gameBoard2[row-1][col-1].piece?.type = .queen
//                                                    }
//                                                }
//                                                
//                                                for i in gameBoard2.indices {
//                                                    for j in gameBoard2[i].indices {
////                                                        print(i, j)
//                                                        gameBoard[i][j].isHighlighted = false
//                                                        gameBoard2[i][j].isHighlighted = false
//                                                        if let piece = gameBoard2[i][j].piece, piece.side != whoMoves {
//                                                            showAvailableMoves2(for: piece, i, j)
//                                                            print("moves for", i, j, piece.type)
//                                                        }
//                                                    }
//                                                }
//                                                
//                                                var tempIsInCheck = false
//                                                for i in gameBoard2.indices {
//                                                    for j in gameBoard2[i].indices {
//                                                        if gameBoard2[i][j].isHighlighted {
//                                                            print("hihglighted", i, j)
//                                                            if gameBoard2[i][j].piece?.type == .king {
//                                                                tempIsInCheck = true
//                                                                print("check at \(i),\(j)")
//                                                            }
//                                                        }
//                                                    }
//                                                }
//                                                print("NEW NEW", isInCheck, tempIsInCheck)
//                                                isInCheck = tempIsInCheck
//                                                
//                                                if isInCheck {
//                                                    return
//                                                }
//                                            } else {
//                                                print("not check but pre move")
//                                                gameBoard2 = gameBoard
//                                                
//                                                // if tries to take king do nothing
//                                                if gameBoard2[row-1][col-1].piece?.type == .king {
//                                                    print("elelelel")
//                                                    return
//                                                }
//                                                
//                                                // swapping the two pieces
//                                                let oldPos = selectedTile.position.to()
//                                                gameBoard2[row-1][col-1].piece = gameBoard2[oldPos.row-1][oldPos.col-1].piece
//                                                gameBoard2[oldPos.row-1][oldPos.col-1].piece = nil
//                                                //
//                                                // if pawn reach end turn it into a queen
//                                                if gameBoard2[row-1][col-1].piece?.type == .pawn {
//                                                    if gameBoard2[row-1][col-1].piece?.side == .white && row == 1 {
//                                                        gameBoard2[row-1][col-1].piece?.type = .queen
//                                                    } else if gameBoard2[row-1][col-1].piece?.side == .black && row == 8 {
//                                                        gameBoard2[row-1][col-1].piece?.type = .queen
//                                                    }
//                                                }
//                                                
//                                                for i in gameBoard2.indices {
//                                                    for j in gameBoard2[i].indices {
//                                                        //                                                        print(i, j)
//                                                        gameBoard[i][j].isHighlighted = false
//                                                        gameBoard2[i][j].isHighlighted = false
//                                                        if let piece = gameBoard2[i][j].piece, piece.side != whoMoves {
//                                                            showAvailableMoves2(for: piece, i, j)
//                                                            print("moves for", i, j, piece.type)
//                                                        }
//                                                    }
//                                                }
//                                                
//                                                var tempIsInCheck = false
//                                                for i in gameBoard2.indices {
//                                                    for j in gameBoard2[i].indices {
//                                                        if gameBoard2[i][j].isHighlighted {
//                                                            print("hihglighted", i, j)
//                                                            if gameBoard2[i][j].piece?.type == .king {
//                                                                tempIsInCheck = true
//                                                                print("check at \(i),\(j)")
//                                                            }
//                                                        }
//                                                    }
//                                                }
//                                                print("NEW NEW", isInCheck, tempIsInCheck)
//                                                isInCheck = tempIsInCheck
//                                                
//                                                if isInCheck {
//                                                    print("resetting")
//                                                    isInCheck = false
//                                                    return
//                                                }
//                                            }
//                                            print("overglow")
                                            // if tries to take king do nothing
                                            if gameBoard[row-1][col-1].piece?.type == .king {
                                                return
                                            }
                                            
                                            // if takes a piece then add it to the deaths list
                                            if let oldPiece = gameBoard[row-1][col-1].piece {
                                                if whoMoves == .white {
                                                    withAnimation(.easeIn) {
                                                        blackDeaths.append(oldPiece)
                                                    }
                                                } else {
                                                    withAnimation(.easeIn) {
                                                        whiteDeaths.append(oldPiece)
                                                    }
                                                }
                                            }
                                            
                                            // swapping the two pieces
                                            let oldPos = selectedTile.position.to()
                                            withAnimation(.easeInOut) {
                                                gameBoard[row-1][col-1].piece = gameBoard[oldPos.row-1][oldPos.col-1].piece
                                                gameBoard[oldPos.row-1][oldPos.col-1].piece = nil
                                            }
                                            
                                            // if pawn reach end turn it into a queen
                                            if gameBoard[row-1][col-1].piece?.type == .pawn {
                                                if gameBoard[row-1][col-1].piece?.side == .white && row == 1 {
                                                    withAnimation {
                                                        gameBoard[row-1][col-1].piece?.type = .queen
                                                    }
                                                } else if gameBoard[row-1][col-1].piece?.side == .black && row == 8 {
                                                    withAnimation {
                                                        gameBoard[row-1][col-1].piece?.type = .queen
                                                    }
                                                }
                                            }
                                            
                                            // removing highlights
                                            withAnimation(.easeOut) {
                                                resetHighlightedTiles()
                                                self.selectedTile = nil
                                            }
                                            
                                            // checking if we are in check now
                                            
                                            
                                            for i in gameBoard2.indices {
                                                for j in gameBoard2[i].indices {
                                                    gameBoard2[i][j].isHighlighted = false
                                                }
                                            }
                                            
                                            
                                            var c = 0
                                            var avm = 0
                                            
                                            for i in gameBoard.indices {
                                                for j in gameBoard[i].indices {
//                                                    print(whoMoves)
//                                            print(row-1,col-1,gameBoard[row-1][col-1].piece, gameBoard[row-1][col-1].piece?.side, whoMoves)
                                                    if let piece = gameBoard[i][j].piece, piece.side == whoMoves {
                                                        // row col original pos, i j new pos
//                                                        print(row-1, col-1)
                                                        
                                                        gameBoard2 = gameBoard
                                                        
                                                        showAvailableMoves2(for: piece, i, j, isPreMove: false)
                                                        
                                                        for xi in gameBoard2.indices {
                                                            for xj in gameBoard2[xi].indices {
                                                                if gameBoard2[xi][xj].isHighlighted {
                                                                    avm += 1
//                                                                    print("avm at \(xi),\(xj) for \(piece)")
//                                                                    print("we have a highlighted")
                                                                    if gameBoard2[xi][xj].piece?.type == .king {
//                                                                        print("-----check found at (\(xi),\(xj)), (\(row-1), \(col-1)), ")
                                                                        c += 1
                                                                        print("c king at \(xi),\(xj)")
                                                                        gameBoard[xi][xj].isHighlighted = true
//                                                                        gameBoard[row-1][col-1].isHighlighted = true
                                                                        isInCheck = true
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                            print(avm, c)
                                            gameBoard2 = gameBoard
                                            
//                                            for i in gameBoard2.indices {
//                                                for j in gameBoard2[i].indices {
//                                                    gameBoard2[i][j].isHighlighted = false
//                                                }
//                                            }
//                                            
//                                            avm = 0
//                                            
//                                            for i in gameBoard2.indices {
//                                                for j in gameBoard2[i].indices {
//                                                    if let piece = gameBoard2[i][j].piece, piece.side != whoMoves {
//                                                        showAvailableMoves2(for: piece, i, j, isPreMove: false)
//                                                    }
//                                                    
//                                                }
//                                            }
//                                            
//                                            for i in gameBoard2.indices {
//                                                for j in gameBoard2[i].indices {
//                                                    if gameBoard2[i][j].isHighlighted {
//                                                        print("high", i, j)
//                                                    }
//                                                }
//                                            }
                                            
//                                                    if gameBoard[i][j].isHighlighted {
//                                                        print("sim1")
//                                                        gameBoard2 = gameBoard
//                                                        
//                                                        //                     row col original pos, i j new pos
//                                                        //                    print(i, j, row, col)
//                                                        gameBoard2[i][j].piece = gameBoard2[row][col].piece
//                                                        gameBoard2[row][col].piece = nil
//                                                        
//                                                        for xi in gameBoard2.indices {
//                                                            for xj in gameBoard2[xi].indices {
//                                                                gameBoard2[xi][xj].isHighlighted = false
//                                                            }
//                                                        }
//                                                        
//                                                        for xi in gameBoard2.indices {
//                                                            for xj in gameBoard2[xi].indices {
//                                                                if let piece = gameBoard2[xi][xj].piece, piece.side == whoMoves {
//                                                                    showAvailableMoves2(for: piece, xi, xj, isPreMove: false)
//                                                                }
//                                                            }
//                                                        }
//                                                        //
//                                                        for xi in gameBoard2.indices {
//                                                            for xj in gameBoard2[xi].indices {
//                                                                if gameBoard2[xi][xj].isHighlighted {
//                                                                    print(xi, xj)
//                                                                    avm += 1
//                                                                }
//                                                            }
//                                                        }
//                                                    }
//                                                }
//                                            }
//                                            print(avm)
                                            
//                                            guard let piece = gameBoard[row-1][col-1].piece, piece.side == whoMoves else { return }
//                                            showAvailableMoves(for: piece, row-1, col-1)
//                                            withAnimation(.easeOut) {
//                                                resetHighlightedTiles()
//                                                self.selectedTile = nil
//                                            }
//                                            print("comt")
                                            
                                            // switching whose move it is
                                            withAnimation {
                                                whoMoves.toggle()
                                            }
                                        }
                                    } else {
                                        // no selected piece so select it now
                                        guard let piece = gameBoard[row-1][col-1].piece, piece.side == whoMoves else { return }
                                        if isInCheck {
                                            print("HELP IN CHCE")
//                                            gameBoard2 = gameBoard
//                                            for i in gameBoard2.indices {
//                                                for j in gameBoard2[i].indices {
//                                                    if let piece = gameBoard2[i][j].piece, piece.side == whoMoves {
//                                                        showAvailableMoves2(for: piece, i, j, isPreMove: false)
//                                                    }
//                                                }
//                                            }
//                                            var counter = 0
//                                            for i in gameBoard2.indices {
//                                                for j in gameBoard2[i].indices {
//                                                    if gameBoard2[i][j].isHighlighted {
//                                                        counter += 1
//                                                    }
//                                                }
//                                            }
//                                            print(counter)
//                                            return
//                                            
                                        }
                                        withAnimation(.easeIn) {
                                            selectedTile = gameBoard[row-1][col-1]
                                            showAvailableMoves(for: piece, row-1, col-1)
                                        }
                                    }
                                }
                        }
                    }
                }
            }
        }
    }
//    @State private var isCheckingMate = false
    func defaultSetup() {
        for row in gameBoard.indices {
            for col in gameBoard[row].indices {
                switch (row, col) {
                    case (0,0): gameBoard[row][col].piece = Piece(type: .rook, side: .black, position: .a8)
                    case (0,1): gameBoard[row][col].piece = Piece(type: .knight, side: .black, position: .b8)
                    case (0,2): gameBoard[row][col].piece = Piece(type: .bishop, side: .black, position: .c8)
                    case (0,3): gameBoard[row][col].piece = Piece(type: .queen, side: .black, position: .d8)
                    case (0,4): gameBoard[row][col].piece = Piece(type: .king, side: .black, position: .e8)
                    case (0,5): gameBoard[row][col].piece = Piece(type: .bishop, side: .black, position: .f8)
                    case (0,6): gameBoard[row][col].piece = Piece(type: .knight, side: .black, position: .g8)
                    case (0,7): gameBoard[row][col].piece = Piece(type: .rook, side: .black, position: .h8)
                        
                    case (1, 0): gameBoard[row][col].piece = Piece(type: .pawn, side: .black, position: .a7)
                    case (1, 1): gameBoard[row][col].piece = Piece(type: .pawn, side: .black, position: .b7)
                    case (1, 2): gameBoard[row][col].piece = Piece(type: .pawn, side: .black, position: .c7)
                    case (1, 3): gameBoard[row][col].piece = Piece(type: .pawn, side: .black, position: .d7)
                    case (1, 4): gameBoard[row][col].piece = Piece(type: .pawn, side: .black, position: .e7)
                    case (1, 5): gameBoard[row][col].piece = Piece(type: .pawn, side: .black, position: .f7)
                    case (1, 6): gameBoard[row][col].piece = Piece(type: .pawn, side: .black, position: .g7)
                    case (1, 7): gameBoard[row][col].piece = Piece(type: .pawn, side: .black, position: .h7)
                        
                    case (6, 0): gameBoard[row][col].piece = Piece(type: .pawn, side: .white, position: .a2)
                    case (6, 1): gameBoard[row][col].piece = Piece(type: .pawn, side: .white, position: .b2)
                    case (6, 2): gameBoard[row][col].piece = Piece(type: .pawn, side: .white, position: .c2)
                    case (6, 3): gameBoard[row][col].piece = Piece(type: .pawn, side: .white, position: .d2)
                    case (6, 4): gameBoard[row][col].piece = Piece(type: .pawn, side: .white, position: .e2)
                    case (6, 5): gameBoard[row][col].piece = Piece(type: .pawn, side: .white, position: .f2)
                    case (6, 6): gameBoard[row][col].piece = Piece(type: .pawn, side: .white, position: .g2)
                    case (6, 7): gameBoard[row][col].piece = Piece(type: .pawn, side: .white, position: .h2)
                        
                    case (7,0): gameBoard[row][col].piece = Piece(type: .rook, side: .white, position: .a1)
                    case (7,1): gameBoard[row][col].piece = Piece(type: .knight, side: .white, position: .b1)
                    case (7,2): gameBoard[row][col].piece = Piece(type: .bishop, side: .white, position: .c1)
                    case (7,3): gameBoard[row][col].piece = Piece(type: .queen, side: .white, position: .d1)
                    case (7,4): gameBoard[row][col].piece = Piece(type: .king, side: .white, position: .e1)
                    case (7,5): gameBoard[row][col].piece = Piece(type: .bishop, side: .white, position: .f1)
                    case (7,6): gameBoard[row][col].piece = Piece(type: .knight, side: .white, position: .g1)
                    case (7,7): gameBoard[row][col].piece = Piece(type: .rook, side: .white, position: .h1)
                        
                    default: gameBoard[row][col].piece = nil
                }
            }
        }
        
//        gameBoard[0][4].piece = Piece(type: .king, side: .black, position: .e8)
//        gameBoard[6][3].piece = Piece(type: .pawn, side: .white, position: .d2)
//        gameBoard[6][4].piece = Piece(type: .pawn, side: .white, position: .e2)
//        gameBoard[4][2].piece = Piece(type: .king, side: .white, position: .g3)
//        gameBoard[3][5].piece = Piece(type: .knight, side: .black, position: .g3)
//        gameBoard[7][5].piece = Piece(type: .bishop, side: .black, position: .b7)
        
//        gameBoard[2][0].piece = Piece(type: .rook, side: .black, position: .a3)
//        gameBoard[3][2].piece = Piece(type: .queen, side: .white, position: .c3)
//        gameBoard[4][7].piece = Piece(type: .knight, side: .black, position: .g3)
//        gameBoard[5][7].piece = Piece(type: .pawn, side: .black, position: .g3)
//        gameBoard[4][6].piece = Piece(type: .pawn, side: .white, position: .g3)
//        gameBoard[2][0].piece = Piece(type: .pawn, side: .black, position: .b7)
//        gameBoard[3][1].piece = Piece(type: .rook, side: .white, position: .b7)
    }
    
    @State private var isInCheck = false
    // TODO: castle, en passant, check (mate), stalemate, resetgame, kings cant be together or take each other, pieces cant take king
    func showAvailableMoves(for piece: Piece, _ row: Int, _ col: Int) {
//        print(piece, row, col)
        switch piece.type {
            case .pawn:
                if piece.side == .white {
                    guard row > 0 else { return }
                    
                    // if forward tile empty then highlight it
                    if gameBoard[row-1][col].piece == nil {
                        gameBoard[row-1][col].isHighlighted = true
                    }
                    
                    // if at base then check if can move forward 2 tiles
                    if row == 6 && gameBoard[row-2][col].piece == nil && gameBoard[row-1][col].piece == nil {
                        gameBoard[row-2][col].isHighlighted = true
                    }
                    
                    // check if can take left diagonal
                    if col > 0, let new = gameBoard[row-1][col-1].piece, piece.side != new.side {
                        gameBoard[row-1][col-1].isHighlighted = true
                    }
                    
                    // check if can take right diagonal
                    if col < 7, let new = gameBoard[row-1][col+1].piece, piece.side != new.side {
                        gameBoard[row-1][col+1].isHighlighted = true
                    }
                } else {
                    guard row < 7 else { return }
                    
                    if gameBoard[row+1][col].piece == nil {
                        gameBoard[row+1][col].isHighlighted = true
                    }
                    
                    if row == 1 && gameBoard[row+2][col].piece == nil && gameBoard[row+1][col].piece == nil {
                        gameBoard[row+2][col].isHighlighted = true
                    }
                    
                    if col > 0, let new = gameBoard[row+1][col-1].piece, piece.side != new.side {
                        gameBoard[row+1][col-1].isHighlighted = true
                    }
                    
                    if col < 7, let new = gameBoard[row+1][col+1].piece, piece.side != new.side {
                        gameBoard[row+1][col+1].isHighlighted = true
                    }
                }
            case .rook:
                var irow = row
                var icol = col
                
                // upwards going clockwise
                irow = row - 1
                while irow >= 0 {
                    if gameBoard[irow][col].piece == nil {
                        // on blank piece, highlight and move to next tile
                        gameBoard[irow][col].isHighlighted = true
                        irow -= 1
                    } else if gameBoard[irow][col].piece?.side != whoMoves {
                        // on opposition piece, highlight tile
                        gameBoard[irow][col].isHighlighted = true
                        break
                    } else {
                        // on same side piece, dont highlight tile
                        break
                    }
                }
                
                irow = row + 1
                while irow <= 7 {
                    if gameBoard[irow][col].piece == nil {
                        gameBoard[irow][col].isHighlighted = true
                        irow += 1
                    } else if gameBoard[irow][col].piece?.side != whoMoves {
                        gameBoard[irow][col].isHighlighted = true
                        break
                    } else {
                        break
                    }
                }
                
                icol = col - 1
                while icol >= 0 {
                    if gameBoard[row][icol].piece == nil {
                        gameBoard[row][icol].isHighlighted = true
                        icol -= 1
                    } else if gameBoard[row][icol].piece?.side != whoMoves {
                        gameBoard[row][icol].isHighlighted = true
                        break
                    } else {
                        break
                    }
                }
                
                icol = col + 1
                while icol <= 7 {
                    if gameBoard[row][icol].piece == nil {
                        gameBoard[row][icol].isHighlighted = true
                        icol += 1
                    } else if gameBoard[row][icol].piece?.side != whoMoves {
                        gameBoard[row][icol].isHighlighted = true
                        break
                    } else {
                        break
                    }
                }
            case .knight:
                // starting from upper left, clockwise round to below left
                if row >= 1, col >= 2, gameBoard[row-1][col-2].piece?.side != piece.side {
                    gameBoard[row-1][col-2].isHighlighted = true
                }
                if row >= 2, col >= 1, gameBoard[row-2][col-1].piece?.side != piece.side {
                    gameBoard[row-2][col-1].isHighlighted = true
                }
                if row >= 2, col <= 6, gameBoard[row-2][col+1].piece?.side != piece.side {
                    gameBoard[row-2][col+1].isHighlighted = true
                }
                if row >= 1, col <= 5, gameBoard[row-1][col+2].piece?.side != piece.side {
                    gameBoard[row-1][col+2].isHighlighted = true
                }
                if row <= 6, col <= 5, gameBoard[row+1][col+2].piece?.side != piece.side {
                    gameBoard[row+1][col+2].isHighlighted = true
                }
                if row <= 5, col <= 6, gameBoard[row+2][col+1].piece?.side != piece.side {
                    gameBoard[row+2][col+1].isHighlighted = true
                }
                if row <= 5, col >= 1, gameBoard[row+2][col-1].piece?.side != piece.side {
                    gameBoard[row+2][col-1].isHighlighted = true
                }
                if row <= 6, col >= 2, gameBoard[row+1][col-2].piece?.side != piece.side {
                    gameBoard[row+1][col-2].isHighlighted = true
                }
            case .bishop:
                var irow = row
                var icol = col
                
                // top right going clockwise
                irow = row - 1
                icol = col + 1
                while irow >= 0, icol <= 7 {
                    if gameBoard[irow][icol].piece == nil {
                        gameBoard[irow][icol].isHighlighted = true
                        irow -= 1
                        icol += 1
                    } else if gameBoard[irow][icol].piece?.side != whoMoves {
                        gameBoard[irow][icol].isHighlighted = true
                        break
                    } else {
                        break
                    }
                }
                
                irow = row + 1
                icol = col + 1
                while irow <= 7, icol <= 7 {
                    if gameBoard[irow][icol].piece == nil {
                        gameBoard[irow][icol].isHighlighted = true
                        irow += 1
                        icol += 1
                    } else if gameBoard[irow][icol].piece?.side != whoMoves {
                        gameBoard[irow][icol].isHighlighted = true
                        break
                    } else {
                        break
                    }
                }
                
                irow = row + 1
                icol = col - 1
                while irow <= 7, icol >= 0 {
                    if gameBoard[irow][icol].piece == nil {
                        gameBoard[irow][icol].isHighlighted = true
                        irow += 1
                        icol -= 1
                    } else if gameBoard[irow][icol].piece?.side != whoMoves {
                        gameBoard[irow][icol].isHighlighted = true
                        break
                    } else {
                        break
                    }
                }
                
                irow = row - 1
                icol = col - 1
                while irow >= 0, icol >= 0 {
                    if gameBoard[irow][icol].piece == nil {
                        gameBoard[irow][icol].isHighlighted = true
                        irow -= 1
                        icol -= 1
                    } else if gameBoard[irow][icol].piece?.side != whoMoves {
                        gameBoard[irow][icol].isHighlighted = true
                        break
                    } else {
                        break
                    }
                }
            case .queen:
                var irow = row
                var icol = col
                
                // rook moves copy, upwards going clockwise
                irow = row - 1
                while irow >= 0 {
                    if gameBoard[irow][col].piece == nil {
                        // on blank piece, highlight and move to next tile
                        gameBoard[irow][col].isHighlighted = true
                        irow -= 1
                    } else if gameBoard[irow][col].piece?.side != whoMoves {
                        // on opposition piece, highlight tile
                        gameBoard[irow][col].isHighlighted = true
                        break
                    } else {
                        // on same side piece, dont highlight tile
                        break
                    }
                }
                
                irow = row + 1
                while irow <= 7 {
                    if gameBoard[irow][col].piece == nil {
                        gameBoard[irow][col].isHighlighted = true
                        irow += 1
                    } else if gameBoard[irow][col].piece?.side != whoMoves {
                        gameBoard[irow][col].isHighlighted = true
                        break
                    } else {
                        break
                    }
                }
                
                icol = col - 1
                while icol >= 0 {
                    if gameBoard[row][icol].piece == nil {
                        gameBoard[row][icol].isHighlighted = true
                        icol -= 1
                    } else if gameBoard[row][icol].piece?.side != whoMoves {
                        gameBoard[row][icol].isHighlighted = true
                        break
                    } else {
                        break
                    }
                }
                
                icol = col + 1
                while icol <= 7 {
                    if gameBoard[row][icol].piece == nil {
                        gameBoard[row][icol].isHighlighted = true
                        icol += 1
                    } else if gameBoard[row][icol].piece?.side != whoMoves {
                        gameBoard[row][icol].isHighlighted = true
                        break
                    } else {
                        break
                    }
                }
                
                // bishop moves copy, top right going clockwise
                irow = row - 1
                icol = col + 1
                while irow >= 0, icol <= 7 {
                    if gameBoard[irow][icol].piece == nil {
                        gameBoard[irow][icol].isHighlighted = true
                        irow -= 1
                        icol += 1
                    } else if gameBoard[irow][icol].piece?.side != whoMoves {
                        gameBoard[irow][icol].isHighlighted = true
                        break
                    } else {
                        break
                    }
                }
                
                irow = row + 1
                icol = col + 1
                while irow <= 7, icol <= 7 {
                    if gameBoard[irow][icol].piece == nil {
                        gameBoard[irow][icol].isHighlighted = true
                        irow += 1
                        icol += 1
                    } else if gameBoard[irow][icol].piece?.side != whoMoves {
                        gameBoard[irow][icol].isHighlighted = true
                        break
                    } else {
                        break
                    }
                }
                
                irow = row + 1
                icol = col - 1
                while irow <= 7, icol >= 0 {
                    if gameBoard[irow][icol].piece == nil {
                        gameBoard[irow][icol].isHighlighted = true
                        irow += 1
                        icol -= 1
                    } else if gameBoard[irow][icol].piece?.side != whoMoves {
                        gameBoard[irow][icol].isHighlighted = true
                        break
                    } else {
                        break
                    }
                }
                
                irow = row - 1
                icol = col - 1
                while irow >= 0, icol >= 0 {
                    if gameBoard[irow][icol].piece == nil {
                        gameBoard[irow][icol].isHighlighted = true
                        irow -= 1
                        icol -= 1
                    } else if gameBoard[irow][icol].piece?.side != whoMoves {
                        gameBoard[irow][icol].isHighlighted = true
                        break
                    } else {
                        break
                    }
                }
            case .king:
                if row > 0 {
                    if gameBoard[row-1][col].piece == nil {
                        gameBoard[row-1][col].isHighlighted = true
                    } else if gameBoard[row-1][col].piece?.side != whoMoves {
                        gameBoard[row-1][col].isHighlighted = true
                    } else {
                        
                    }
                }
                
                if row < 7 {
                    if gameBoard[row+1][col].piece == nil {
                        gameBoard[row+1][col].isHighlighted = true
                    } else if gameBoard[row+1][col].piece?.side != whoMoves {
                        gameBoard[row+1][col].isHighlighted = true
                    } else {
                        
                    }
                }
                
                if col > 0 {
                    if gameBoard[row][col-1].piece == nil {
                        gameBoard[row][col-1].isHighlighted = true
                    } else if gameBoard[row][col-1].piece?.side != whoMoves {
                        gameBoard[row][col-1].isHighlighted = true
                    } else {
                        
                    }
                }
                
                if col < 7 {
                    if gameBoard[row][col+1].piece == nil {
                        gameBoard[row][col+1].isHighlighted = true
                    } else if gameBoard[row][col+1].piece?.side != whoMoves {
                        gameBoard[row][col+1].isHighlighted = true
                    } else {
                        
                    }
                }
                
                if row > 0, col < 7 {
                    if gameBoard[row-1][col+1].piece == nil {
                        gameBoard[row-1][col+1].isHighlighted = true
                    } else if gameBoard[row-1][col+1].piece?.side != whoMoves {
                        gameBoard[row-1][col+1].isHighlighted = true
                    } else {
                        
                    }
                }
                
                if row < 7, col < 7 {
                    if gameBoard[row+1][col+1].piece == nil {
                        gameBoard[row+1][col+1].isHighlighted = true
                    } else if gameBoard[row+1][col+1].piece?.side != whoMoves {
                        gameBoard[row+1][col+1].isHighlighted = true
                    } else {
                        
                    }
                }
                
                if row < 7, col > 0 {
                    if gameBoard[row+1][col-1].piece == nil {
                        gameBoard[row+1][col-1].isHighlighted = true
                    } else if gameBoard[row+1][col-1].piece?.side != whoMoves {
                        gameBoard[row+1][col-1].isHighlighted = true
                    } else {
                        
                    }
                }
                
                if row > 0, col > 0 {
                    if gameBoard[row-1][col-1].piece == nil {
                        gameBoard[row-1][col-1].isHighlighted = true
                    } else if gameBoard[row-1][col-1].piece?.side != whoMoves {
                        gameBoard[row-1][col-1].isHighlighted = true
                    } else {
                        
                    }
                }
        }
        
        // Filtering out possible moves which cause player to get into check
        // for each highlighted spot (avilable move), move to it and see if in check
//        var tempIsInCheck = false
//        var gameBoard2 = gameBoard
//        print(gameBoard2.count)
        for i in gameBoard.indices {
            for j in gameBoard[i].indices {
                if gameBoard[i][j].isHighlighted {
                    gameBoard2 = gameBoard
                    
//                     row col original pos, i j new pos
//                    print(i, j, row, col)
                    gameBoard2[i][j].piece = gameBoard2[row][col].piece
                    gameBoard2[row][col].piece = nil
                    
                    for xi in gameBoard2.indices {
                        for xj in gameBoard2[xi].indices {
                            gameBoard2[xi][xj].isHighlighted = false
                        }
                    }
                    
                    for xi in gameBoard2.indices {
                        for xj in gameBoard2[xi].indices {
                            if let piece = gameBoard2[xi][xj].piece, piece.side != whoMoves {
                                showAvailableMoves2(for: piece, xi, xj, isPreMove: true)
                            }
                        }
                    }
//                    
                    for xi in gameBoard2.indices {
                        for xj in gameBoard2[xi].indices {
                            if gameBoard2[xi][xj].isHighlighted {
//                                print("we have a match", i, j, xi, xj)
                                if gameBoard2[xi][xj].piece?.type == .king {
//                                    tempIsInCheck = true
                                    print("check found at (\(xi),\(xj)), (\(i), \(j)), \(row), \(col)")
                                    gameBoard[i][j].isHighlighted = false
                                }
                            }
                        }
                    }
                }
            }
        }
        gameBoard2 = gameBoard
//        self.gameBoard2 = gameBoard
//        print("AFTER EVAL CHECK IS ", tempIsInCheck)
        
        
//        for i in gameBoard2.indices {
//            for j in gameBoard2[i].indices {
//                if gameBoard2[i][j].isHighlighted {
//                    if gameBoard2[i][j].piece?.type == .king {
//                        tempIsInCheck = true
//                        print("check at \(i),\(j)")
//                    }
//                }
//            }
//        }
//        print("NEW NEW", isInCheck, tempIsInCheck)
//        isInCheck = tempIsInCheck
//        
//        
//        
////        var tempIsInCheck = false
//        print("std checking move")
//        for i in gameBoard.indices {
//            for j in gameBoard[i].indices {
//                if gameBoard[i][j].isHighlighted {
//                    if gameBoard[i][j].piece?.type == .king {
//                        isInCheck = true
////                        tempIsInCheck = true
//                        print("check at \(i),\(j)")
//                    }
//                }
//            }
//        }
//        isInCheck = tempIsInCheck
    }
    
    func showAvailableMoves2(for piece: Piece, _ row: Int, _ col: Int, isPreMove: Bool) {
        // switch who moves as predicting what happens when opponent moves
        let whoMoves: Side = isPreMove ? (self.whoMoves == .black ? .white : .black) : self.whoMoves
        
        switch piece.type {
            case .pawn:
                if piece.side == .white {
                    guard row > 0 else { return }
                    
                    // if forward tile empty then highlight it
                    if gameBoard2[row-1][col].piece == nil {
                        gameBoard2[row-1][col].isHighlighted = true
                    }
                    
                    // if at base then check if can move forward 2 tiles
                    if row == 6 && gameBoard2[row-2][col].piece == nil && gameBoard2[row-1][col].piece == nil {
                        gameBoard2[row-2][col].isHighlighted = true
                    }
                    
                    // check if can take left diagonal
                    if col > 0, let new = gameBoard2[row-1][col-1].piece, piece.side != new.side {
                        gameBoard2[row-1][col-1].isHighlighted = true
                    }
                    
                    // check if can take right diagonal
                    if col < 7, let new = gameBoard2[row-1][col+1].piece, piece.side != new.side {
                        gameBoard2[row-1][col+1].isHighlighted = true
                    }
                } else {
                    guard row < 7 else { return }
                    
                    if gameBoard2[row+1][col].piece == nil {
                        gameBoard2[row+1][col].isHighlighted = true
                    }
                    
                    if row == 1 && gameBoard2[row+2][col].piece == nil && gameBoard2[row+1][col].piece == nil {
                        gameBoard2[row+2][col].isHighlighted = true
                    }
                    
                    if col > 0, let new = gameBoard2[row+1][col-1].piece, piece.side != new.side {
                        gameBoard2[row+1][col-1].isHighlighted = true
                    }
                    
                    if col < 7, let new = gameBoard2[row+1][col+1].piece, piece.side != new.side {
                        gameBoard2[row+1][col+1].isHighlighted = true
                    }
                }
            case .rook:
                var irow = row
                var icol = col
                
                // upwards going clockwise
                irow = row - 1
                while irow >= 0 {
                    if gameBoard2[irow][col].piece == nil {
                        // on blank piece, highlight and move to next tile
                        gameBoard2[irow][col].isHighlighted = true
                        irow -= 1
                    } else if gameBoard2[irow][col].piece?.side != whoMoves {
                        // on opposition piece, highlight tile
                        gameBoard2[irow][col].isHighlighted = true
                        break
                    } else {
                        // on same side piece, dont highlight tile
                        break
                    }
                }
                
                irow = row + 1
                while irow <= 7 {
                    if gameBoard2[irow][col].piece == nil {
                        gameBoard2[irow][col].isHighlighted = true
                        irow += 1
                    } else if gameBoard2[irow][col].piece?.side != whoMoves {
                        gameBoard2[irow][col].isHighlighted = true
                        break
                    } else {
                        break
                    }
                }
                
                icol = col - 1
                while icol >= 0 {
                    if gameBoard2[row][icol].piece == nil {
                        gameBoard2[row][icol].isHighlighted = true
                        icol -= 1
                    } else if gameBoard2[row][icol].piece?.side != whoMoves {
                        gameBoard2[row][icol].isHighlighted = true
                        break
                    } else {
                        break
                    }
                }
                
                icol = col + 1
                while icol <= 7 {
                    if gameBoard2[row][icol].piece == nil {
                        gameBoard2[row][icol].isHighlighted = true
                        icol += 1
                    } else if gameBoard2[row][icol].piece?.side != whoMoves {
                        gameBoard2[row][icol].isHighlighted = true
                        break
                    } else {
                        break
                    }
                }
            case .knight:
                // starting from upper left, clockwise round to below left
                if row >= 1, col >= 2, gameBoard2[row-1][col-2].piece?.side != piece.side {
                    gameBoard2[row-1][col-2].isHighlighted = true
                }
                if row >= 2, col >= 1, gameBoard2[row-2][col-1].piece?.side != piece.side {
                    gameBoard2[row-2][col-1].isHighlighted = true
                }
                if row >= 2, col <= 6, gameBoard2[row-2][col+1].piece?.side != piece.side {
                    gameBoard2[row-2][col+1].isHighlighted = true
                }
                if row >= 1, col <= 5, gameBoard2[row-1][col+2].piece?.side != piece.side {
                    gameBoard2[row-1][col+2].isHighlighted = true
                }
                if row <= 6, col <= 5, gameBoard2[row+1][col+2].piece?.side != piece.side {
                    gameBoard2[row+1][col+2].isHighlighted = true
                }
                if row <= 5, col <= 6, gameBoard2[row+2][col+1].piece?.side != piece.side {
                    gameBoard2[row+2][col+1].isHighlighted = true
                }
                if row <= 5, col >= 1, gameBoard2[row+2][col-1].piece?.side != piece.side {
                    gameBoard2[row+2][col-1].isHighlighted = true
                }
                if row <= 6, col >= 2, gameBoard2[row+1][col-2].piece?.side != piece.side {
                    gameBoard2[row+1][col-2].isHighlighted = true
                }
            case .bishop:
                var irow = row
                var icol = col
                
                // top right going clockwise
                irow = row - 1
                icol = col + 1
                while irow >= 0, icol <= 7 {
                    if gameBoard2[irow][icol].piece == nil {
                        gameBoard2[irow][icol].isHighlighted = true
                        irow -= 1
                        icol += 1
                    } else if gameBoard2[irow][icol].piece?.side != whoMoves {
                        gameBoard2[irow][icol].isHighlighted = true
                        break
                    } else {
                        break
                    }
                }
                
                irow = row + 1
                icol = col + 1
                while irow <= 7, icol <= 7 {
                    if gameBoard2[irow][icol].piece == nil {
                        gameBoard2[irow][icol].isHighlighted = true
                        irow += 1
                        icol += 1
                    } else if gameBoard2[irow][icol].piece?.side != whoMoves {
                        gameBoard2[irow][icol].isHighlighted = true
                        break
                    } else {
                        break
                    }
                }
                
                irow = row + 1
                icol = col - 1
                while irow <= 7, icol >= 0 {
                    if gameBoard2[irow][icol].piece == nil {
                        gameBoard2[irow][icol].isHighlighted = true
                        irow += 1
                        icol -= 1
                    } else if gameBoard2[irow][icol].piece?.side != whoMoves {
                        gameBoard2[irow][icol].isHighlighted = true
                        break
                    } else {
                        break
                    }
                }
                
                irow = row - 1
                icol = col - 1
                while irow >= 0, icol >= 0 {
                    if gameBoard2[irow][icol].piece == nil {
                        gameBoard2[irow][icol].isHighlighted = true
                        irow -= 1
                        icol -= 1
                    } else if gameBoard2[irow][icol].piece?.side != whoMoves {
                        gameBoard2[irow][icol].isHighlighted = true
                        break
                    } else {
                        break
                    }
                }
            case .queen:
                var irow = row
                var icol = col
                
                // rook moves copy, upwards going clockwise
                irow = row - 1
                while irow >= 0 {
                    if gameBoard2[irow][col].piece == nil {
                        // on blank piece, highlight and move to next tile
                        gameBoard2[irow][col].isHighlighted = true
                        irow -= 1
                    } else if gameBoard2[irow][col].piece?.side != whoMoves {
                        // on opposition piece, highlight tile
                        gameBoard2[irow][col].isHighlighted = true
                        break
                    } else {
                        // on same side piece, dont highlight tile
                        break
                    }
                }
                
                irow = row + 1
                while irow <= 7 {
                    if gameBoard2[irow][col].piece == nil {
                        gameBoard2[irow][col].isHighlighted = true
                        irow += 1
                    } else if gameBoard2[irow][col].piece?.side != whoMoves {
                        gameBoard2[irow][col].isHighlighted = true
                        break
                    } else {
                        break
                    }
                }
                
                icol = col - 1
                while icol >= 0 {
                    if gameBoard2[row][icol].piece == nil {
                        gameBoard2[row][icol].isHighlighted = true
                        icol -= 1
                    } else if gameBoard2[row][icol].piece?.side != whoMoves {
                        gameBoard2[row][icol].isHighlighted = true
                        break
                    } else {
                        break
                    }
                }
                
                icol = col + 1
                while icol <= 7 {
                    if gameBoard2[row][icol].piece == nil {
                        gameBoard2[row][icol].isHighlighted = true
                        icol += 1
                    } else if gameBoard2[row][icol].piece?.side != whoMoves {
                        gameBoard2[row][icol].isHighlighted = true
                        break
                    } else {
                        break
                    }
                }
                
                // bishop moves copy, top right going clockwise
                irow = row - 1
                icol = col + 1
                while irow >= 0, icol <= 7 {
                    if gameBoard2[irow][icol].piece == nil {
                        gameBoard2[irow][icol].isHighlighted = true
                        irow -= 1
                        icol += 1
                    } else if gameBoard2[irow][icol].piece?.side != whoMoves {
                        gameBoard2[irow][icol].isHighlighted = true
                        break
                    } else {
                        break
                    }
                }
                
                irow = row + 1
                icol = col + 1
                while irow <= 7, icol <= 7 {
                    if gameBoard2[irow][icol].piece == nil {
                        gameBoard2[irow][icol].isHighlighted = true
                        irow += 1
                        icol += 1
                    } else if gameBoard2[irow][icol].piece?.side != whoMoves {
                        gameBoard2[irow][icol].isHighlighted = true
                        break
                    } else {
                        break
                    }
                }
                
                irow = row + 1
                icol = col - 1
                while irow <= 7, icol >= 0 {
                    if gameBoard2[irow][icol].piece == nil {
                        gameBoard2[irow][icol].isHighlighted = true
                        irow += 1
                        icol -= 1
                    } else if gameBoard2[irow][icol].piece?.side != whoMoves {
                        gameBoard2[irow][icol].isHighlighted = true
                        break
                    } else {
                        break
                    }
                }
                
                irow = row - 1
                icol = col - 1
                while irow >= 0, icol >= 0 {
                    if gameBoard2[irow][icol].piece == nil {
                        gameBoard2[irow][icol].isHighlighted = true
                        irow -= 1
                        icol -= 1
                    } else if gameBoard2[irow][icol].piece?.side != whoMoves {
                        gameBoard2[irow][icol].isHighlighted = true
                        break
                    } else {
                        break
                    }
                }
            case .king:
                if row > 0 {
                    if gameBoard2[row-1][col].piece == nil {
                        gameBoard2[row-1][col].isHighlighted = true
                    } else if gameBoard2[row-1][col].piece?.side != whoMoves {
                        gameBoard2[row-1][col].isHighlighted = true
                    } else {
                        
                    }
                }
                
                if row < 7 {
                    if gameBoard2[row+1][col].piece == nil {
                        gameBoard2[row+1][col].isHighlighted = true
                    } else if gameBoard2[row+1][col].piece?.side != whoMoves {
                        gameBoard2[row+1][col].isHighlighted = true
                    } else {
                        
                    }
                }
                
                if col > 0 {
                    if gameBoard2[row][col-1].piece == nil {
                        gameBoard2[row][col-1].isHighlighted = true
                    } else if gameBoard2[row][col-1].piece?.side != whoMoves {
                        gameBoard2[row][col-1].isHighlighted = true
                    } else {
                        
                    }
                }
                
                if col < 7 {
                    if gameBoard2[row][col+1].piece == nil {
                        gameBoard2[row][col+1].isHighlighted = true
                    } else if gameBoard2[row][col+1].piece?.side != whoMoves {
                        gameBoard2[row][col+1].isHighlighted = true
                    } else {
                        
                    }
                }
                
                if row > 0, col < 7 {
                    if gameBoard2[row-1][col+1].piece == nil {
                        gameBoard2[row-1][col+1].isHighlighted = true
                    } else if gameBoard2[row-1][col+1].piece?.side != whoMoves {
                        gameBoard2[row-1][col+1].isHighlighted = true
                    } else {
                        
                    }
                }
                
                if row < 7, col < 7 {
                    if gameBoard2[row+1][col+1].piece == nil {
                        gameBoard2[row+1][col+1].isHighlighted = true
                    } else if gameBoard2[row+1][col+1].piece?.side != whoMoves {
                        gameBoard2[row+1][col+1].isHighlighted = true
                    } else {
                        
                    }
                }
                
                if row < 7, col > 0 {
                    if gameBoard2[row+1][col-1].piece == nil {
                        gameBoard2[row+1][col-1].isHighlighted = true
                    } else if gameBoard2[row+1][col-1].piece?.side != whoMoves {
                        gameBoard2[row+1][col-1].isHighlighted = true
                    } else {
                        
                    }
                }
                
                if row > 0, col > 0 {
                    if gameBoard2[row-1][col-1].piece == nil {
                        gameBoard2[row-1][col-1].isHighlighted = true
                    } else if gameBoard2[row-1][col-1].piece?.side != whoMoves {
                        gameBoard2[row-1][col-1].isHighlighted = true
                    } else {
                        
                    }
                }
        }
    }
    
    func resetHighlightedTiles() {
        for i in gameBoard.indices {
            for j in gameBoard[i].indices {
                gameBoard[i][j].isHighlighted = false
            }
        }
    }
    
    @ViewBuilder func edgeLabel(_ row: Int, _ col: Int) -> some View {
        let rowText = String(9-row)
        let colText = String(Character(UnicodeScalar(col+64+32)!))
        
        if col == 0 {
            Text(rowText)
                .foregroundStyle(accentColor)
                .opacity(row == 0 || row == 9 ? 0 : 1)
                .padding(.horizontal, 6)
        } else if col == 9 {
            Text(rowText)
                .foregroundStyle(accentColor)
                .rotationEffect(Angle(degrees: 180))
                .opacity(row == 0 || row == 9 ? 0 : 1)
                .padding(.horizontal, 6)
        } else {
            if row == 0 {
                Text(colText)
                    .foregroundStyle(accentColor)
                    .rotationEffect(Angle(degrees: 180))
                    .opacity(col == 0 || col == 9 ? 0 : 1)
                    .padding(.vertical, 6)
            } else if row == 9 {
                Text(colText)
                    .foregroundStyle(accentColor)
                    .opacity(col == 0 || col == 9 ? 0 : 1)
                    .padding(.vertical, 6)
            } else {
                
            }
        }
    }
    
    func tile(_ row: Int, _ col: Int, _ item: Tile) -> some View {
        let rowText = String(9-row)
        let colText = String(Character(UnicodeScalar(col+64+32)!))
        
        return ZStack {
            Rectangle()
                .aspectRatio(1, contentMode: .fit)
                .frame(width: 45, height: 45)
                .foregroundStyle((row.isMultiple(of: 2) && col.isMultiple(of: 2) || !row.isMultiple(of: 2) && !col.isMultiple(of: 2)) ? .gray.mix(with: .yellow, by: 0.5).mix(with: .white, by: 0.25) : .brown.mix(with: .gray, by: 0.2))
                .border(selectedTile?.id == "\(rowText)\(colText)" ? .black : .clear, width: 3)
                //.border(item.isHighlighted && selectedTile == nil/*&& item.piece?.type == .king */? .red : .clear, width: 3)
                .border(isInCheck && item.piece?.type == .king && item.piece?.side == whoMoves ? .red : .clear, width: 2)
            
            if let piece = item.piece {
                Image(piece.imageName())
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 35, maxHeight: 35)
//                    .rotationEffect(item.piece?.side == .black ? .degrees(180) : .degrees(0))
            }
            
            if item.isHighlighted && selectedTile != nil {
                Circle()
                    .fill(item.piece?.side == .black ? .white : .black)
                    .opacity(0.4)
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 10, maxHeight: 10)
            } else if item.isHighlighted {
                Circle()
                    .fill(.red)
                    .opacity(0.2)
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 10, maxHeight: 10)
            }
        }
    }
}

#Preview("Chess by Rishi") {
    ContentView()
}
