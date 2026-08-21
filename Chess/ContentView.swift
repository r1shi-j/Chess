//
//  ContentView.swift
//  Chess
//
//  Created by Rishi Jansari on 18/08/2026.
//

import SwiftUI

// TODO: better animations, sound effects, make use of chess notation
struct ContentView: View {
    // MARK: - Properties
    
    @State private var gameBoard: [[Tile]]
    @State private var selectedTile: Tile?
    @State private var whoMoves: Side = .white
    @State private var whiteDeaths: [Piece] = []
    @State private var blackDeaths: [Piece] = []
    @State private var enPassantTarget: (row: Int, col: Int)?
    @State private var isInCheck = false
    @State private var endState: EndState?
    @State private var isObserving = false
    @State private var isShowingRestartConfirmation = false
    
    
    // MARK: - Init
    
    init() {
        var gameBoard: [[Tile]] = []
        for row in 0..<8 {
            gameBoard.append([])
            for col in 0..<8 {
                let rowText = String(9-1-row)
                let colText = String(Character(UnicodeScalar(col+1+64+32)!))
                gameBoard[row].append(Tile(id: "\(rowText)\(colText)", position: Position.fromIndex(row: row, col: col)))
            }
        }
        _gameBoard = State(initialValue: gameBoard)
    }
    
    
    // MARK: - Main View
    
    var body: some View {
        ZStack {
            Color.brown.mix(with: .black, by: 0.3).ignoresSafeArea()
            
            VStack(spacing: 20) {
                #if os(iOS)
                header(for: .black)
                #endif
                
                jail(for: .black, deaths: whiteDeaths)
                
                HStack {
                    #if os(macOS)
                    header(rotationAngle: .degrees(-90))
                    #endif
                    board()
                    #if os(macOS)
                    header(rotationAngle: .degrees(90))
                    #endif
                }
                
                jail(for: .white, deaths: blackDeaths)
                
                #if os(iOS)
                header(for: .white)
                #endif
            }
            .padding(40)
        }
        .allowsHitTesting(!isObserving)
        .alert("\(whoMoves.swapped().rawValue) Won", item: $endState, actions: { endState in
            Button("Observe", role: .close) {
                withAnimation {
                    isInCheck = false
                    isObserving = true
                }
            }
            Button("New Game", role: .confirm) {
                withAnimation {
                    resetGame()
                }
            }
        }, message: { endState in
            Text(endState.description())
        })
        
        .alert("Are you sure you want to restart?", isPresented: $isShowingRestartConfirmation) {
            Button("Cancel", role: .cancel) { }
            Button("OK", role: .confirm) {
                withAnimation {
                    resetGame()
                }
            }
        }
        .toolbarVisibility(.hidden, for: .statusBar)
        .safeAreaInset(edge: .top) {
            Button("Reset", systemImage: "arrow.counterclockwise") {
                withAnimation {
                    if isObserving {
                        resetGame()
                    } else {
                        isShowingRestartConfirmation = true
                    }
                }
            }
            .clipShape(.capsule)
            .labelStyle(.iconOnly)
            .buttonStyle(.glass)
            .padding()
            .padding(.leading, 35)
//            .padding(.top, 35)
            .ignoresSafeArea()
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: .zero)
        }
//        .frame(width: 700, height: 1000)
        .onAppear(perform: setupGame)
    }
    
    
    // MARK: - Sub Views
    
    private func header(rotationAngle: Angle) -> some View {
        Text(isObserving ? (endState == .draw ? "Draw" : ("\(whoMoves.rawValue) Won")) : "\(whoMoves.rawValue.lowercased()) move")
            .font(.system(.largeTitle, design: .serif, weight: .black))
            .foregroundStyle(whoMoves == .black ? .black : Colors.accentColor)
            .fixedSize()
            .rotationEffect(rotationAngle)
            .frame(width: 40, height: 200)
            .padding(.horizontal)
    }
    
    private func header(for side: Side) -> some View {
        Text(isObserving ? (endState == .draw ? "Draw" : ("You \(whoMoves == side ? "Lost" : "Won")")) : "\(whoMoves == side ? "Your" : "Opponents") move")
            .font(.system(.largeTitle, design: .serif, weight: .black))
            .foregroundStyle(side.color)
            .rotationEffect(side.rotationAngle)
    }
    
    private func jail(for side: Side, deaths: [Piece]) -> some View {
        ZStack {
            Rectangle()
                .fill(side.color)
                .opacity(0.7)
            LazyHGrid(rows: [.init(.fixed(20)), .init(.fixed(20))], alignment: .center, spacing: 5) {
                ForEach(deaths.sorted(), id: \.id) { piece in
                    Image(piece.imageName())
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 25, maxHeight: 25)
                    
                }
            }
            if deaths.count == 0 {
                Text("Jail")
                    .font(.system(.largeTitle, design: .serif, weight: .thin))
                    .foregroundStyle(Colors.accentColor.opacity(0.25))
            }
        }
        .rotationEffect(side.rotationAngle)
        .frame(width: 200, height: 70)
    }
    
    private func board() -> some View {
        Grid(alignment: .center, horizontalSpacing: 0, verticalSpacing: 0) {
            ForEach(0..<10) { row in
                GridRow {
                    ForEach(0..<10) { col in
                        if row == 0 || col == 0 || row == 9 || col == 9 {
                            indexLabel(row: row, col: col)
                        } else {
                            tile(row: row, col: col, piece: gameBoard[row-1][col-1])
                                .onTapGesture {
                                    handleTileTapped(row: row-1, col: col-1)
                                }
                        }
                    }
                }
            }
        }
    }
    
    private func indexLabel(row: Int, col: Int) -> some View {
        Group {
            let rowText = String(9-row)
            let colText = String(Character(UnicodeScalar(col+64+32)!))
            
            if col == 0 {
                Text(rowText)
                    .foregroundStyle(Colors.accentColor)
                    .opacity(row == 0 || row == 9 ? 0 : 1)
                    .padding(.horizontal, 6)
            } else if col == 9 {
                Text(rowText)
                    .foregroundStyle(Colors.accentColor)
                    .rotationEffect(Angle(degrees: 180))
                    .opacity(row == 0 || row == 9 ? 0 : 1)
                    .padding(.horizontal, 6)
            } else {
                if row == 0 {
                    Text(colText)
                        .foregroundStyle(Colors.accentColor)
                        .rotationEffect(Angle(degrees: 180))
                        .opacity(col == 0 || col == 9 ? 0 : 1)
                        .padding(.vertical, 6)
                } else if row == 9 {
                    Text(colText)
                        .foregroundStyle(Colors.accentColor)
                        .opacity(col == 0 || col == 9 ? 0 : 1)
                        .padding(.vertical, 6)
                } else {
                    
                }
            }
        }
    }
    
    private func tile(row: Int, col: Int, piece item: Tile) -> some View {
        let rowText = String(9-row)
        let colText = String(Character(UnicodeScalar(col+64+32)!))
        
        return ZStack {
            Rectangle()
                .aspectRatio(1, contentMode: .fit)
                .frame(width: 45, height: 45)
                .foregroundStyle((row.isMultiple(of: 2) && col.isMultiple(of: 2) || !row.isMultiple(of: 2) && !col.isMultiple(of: 2)) ? .gray.mix(with: .yellow, by: 0.5).mix(with: .white, by: 0.25) : .brown.mix(with: .gray, by: 0.2))
                .border(selectedTile?.id == "\(rowText)\(colText)" ? .black : .clear, width: 3)
                .border(isInCheck && item.piece?.type == .king && item.piece?.side == whoMoves ? .red : .clear, width: 2)
            
            if let piece = item.piece {
                Image(piece.imageName())
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 35, maxHeight: 35)
//                    .rotationEffect(item.piece?.side == .black ? .degrees(180) : .degrees(0))
            }
            
            if item.isHighlighted && !(isInCheck && item.piece?.type == .king && item.piece?.side == whoMoves) {
                if selectedTile != nil {
                    Circle()
                        .fill(item.piece?.side == .black ? .white : .black)
                        .opacity(0.4)
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 10, maxHeight: 10)
                } else {
                    Circle()
                        .fill(.red)
                        .opacity(0.2)
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 10, maxHeight: 10)
                }
            } else {
                
            }
        }
    }
    
    
    // MARK: - Functions
    
    // setting up the default chess opening
    private func setupGame() {
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
        
//        gameBoard[0][4].piece = Piece(type: .king, side: .black, position: .e8)
//        gameBoard[5][3].piece = Piece(type: .pawn, side: .white, position: .d2)
//        gameBoard[6][4].piece = Piece(type: .pawn, side: .white, position: .e2)
//        gameBoard[3][3].piece = Piece(type: .king, side: .white, position: .g3)
//        gameBoard[5][5].piece = Piece(type: .knight, side: .black, position: .g3)
//        gameBoard[7][7].piece = Piece(type: .bishop, side: .black, position: .b7)
        
//        gameBoard[1][0].piece = Piece(type: .rook, side: .black, position: .e8)
//        gameBoard[1][3].piece = Piece(type: .pawn, side: .white, position: .d2)
//        gameBoard[0][6].piece = Piece(type: .king, side: .white, position: .e2)
//        gameBoard[4][2].piece = Piece(type: .king, side: .black, position: .g3)
//        gameBoard[3][5].piece = Piece(type: .queen, side: .black, position: .g3)
//        gameBoard[5][5].piece = Piece(type: .bishop, side: .white, position: .b7)
        
//        gameBoard[2][7].piece = Piece(type: .king, side: .black, position: .e8)
//        gameBoard[3][2].piece = Piece(type: .pawn, side: .white, position: .d2)
//        gameBoard[3][4].piece = Piece(type: .queen, side: .white, position: .e2)
//        gameBoard[4][4].piece = Piece(type: .bishop, side: .white, position: .g3)
//        gameBoard[5][6].piece = Piece(type: .king, side: .white, position: .g3)
        
//        gameBoard[2][0].piece = Piece(type: .rook, side: .black, position: .a3)
//        gameBoard[3][2].piece = Piece(type: .queen, side: .white, position: .c3)
//        gameBoard[4][7].piece = Piece(type: .knight, side: .black, position: .g3)
//        gameBoard[5][7].piece = Piece(type: .pawn, side: .black, position: .g3)
//        gameBoard[4][6].piece = Piece(type: .pawn, side: .white, position: .g3)
//        gameBoard[2][0].piece = Piece(type: .pawn, side: .black, position: .b7)
//        gameBoard[3][1].piece = Piece(type: .rook, side: .white, position: .b7)
    }
    
    // resetting the game board to normal
    private func resetGame() {
        selectedTile = nil
        whoMoves = .white
        whiteDeaths = []
        blackDeaths = []
        enPassantTarget = nil
        isInCheck = false
        endState = nil
        isObserving = false
        setupGame()
    }
    
    // decide what to happen when a tile is clicked, most likely to show available moves and check for check(mate)
    private func handleTileTapped(row: Int, col: Int) {
        // if we have a tile selected
        if let selectedTile {
            if selectedTile.piece == gameBoard[row][col].piece {
                // if selects the same tile then deselect it
                withAnimation(.easeOut) {
                    resetHighlightedTiles()
                    self.selectedTile = nil
                }
            } else if let piece = gameBoard[row][col].piece, piece.side == whoMoves {
                // if selects a different piece on same team then show options for that tile
                withAnimation(.easeIn) {
                    resetHighlightedTiles()
                    self.selectedTile = gameBoard[row][col]
                    showAvailableMoves(for: piece, row, col, gameBoard: &gameBoard, whoMoves: whoMoves, enPassantTarget: enPassantTarget)
                    filterAvailableMoves(for: piece, row, col, gameBoard: &gameBoard, whoMoves: whoMoves)
                }
            } else {
                // else selects enemy or empty tile: standard move
                
                // only continue if clicked tile is highlighted as an available move
                guard gameBoard[row][col].isHighlighted else { return }
                
                // if tries to take king do nothing
                if gameBoard[row][col].piece?.type == .king { return }
                
                // must have made a valid move so now out of check
                if isInCheck { isInCheck = false }
                
                let oldPos = selectedTile.position.toIndex()
                let movingPiece = gameBoard[oldPos.row][oldPos.col].piece
                
                // enpassant capture handling
                var nextEnPassantTarget: (row: Int, col: Int)? = nil
                
                if movingPiece?.type == .pawn {
                    // if pawn lands on active enPassantTarget, remove the side pawn
                    if let target = enPassantTarget, row == target.row && col == target.col {
                        let capturedRow = (whoMoves == .white) ? row+1 : row-1
                        if let enPassantPiece = gameBoard[capturedRow][col].piece {
                            withAnimation(.easeIn) {
                                if whoMoves == .white {
                                    blackDeaths.append(enPassantPiece)
                                } else {
                                    whiteDeaths.append(enPassantPiece)
                                }
                                gameBoard[capturedRow][col].piece = nil
                            }
                        }
                    }
                    
                    // If pawn moves 2 squares forward, establish next turn's target
                    if abs(row - oldPos.row) == 2 {
                        let passedRow = (whoMoves == .white) ? oldPos.row-1 : oldPos.row+1
                        nextEnPassantTarget = (passedRow, col)
                    }
                }
                
                // if takes a piece then add it to the deaths list
                if let oldPiece = gameBoard[row][col].piece {
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
                
                // swapping the two pieces, and changing the position of the new piece
                withAnimation(.easeInOut) {
                    gameBoard[row][col].piece = gameBoard[oldPos.row][oldPos.col].piece
                    gameBoard[row][col].piece?.position = gameBoard[row][col].position
                    gameBoard[row][col].piece?.hasMoved = true
                    gameBoard[oldPos.row][oldPos.col].piece = nil
                    
                    // if user chose to castle, then move rook
                    if gameBoard[row][col].piece?.type == .king && abs(col - oldPos.col) == 2 {
                        if col == 6 {
                            // short side move 2 places
                            gameBoard[row][5].piece = gameBoard[row][7].piece
                            gameBoard[row][5].piece?.position = gameBoard[row][5].position
                            gameBoard[row][5].piece?.hasMoved = true
                            gameBoard[row][7].piece = nil
                        } else if col == 2 {
                            // long side move 3 places
                            gameBoard[row][3].piece = gameBoard[row][0].piece
                            gameBoard[row][3].piece?.position = gameBoard[row][3].position
                            gameBoard[row][3].piece?.hasMoved = true
                            gameBoard[row][0].piece = nil
                        }
                    }
                }
                
                // if pawn reach end turn it into a queen
                if gameBoard[row][col].piece?.type == .pawn {
                    if gameBoard[row][col].piece?.side == .white && row == 0 {
                        withAnimation {
                            gameBoard[row][col].piece?.type = .queen
                        }
                    } else if gameBoard[row][col].piece?.side == .black && row == 7 {
                        withAnimation {
                            gameBoard[row][col].piece?.type = .queen
                        }
                    }
                }
                
                // et the new enPassantTarget for the next turn
                self.enPassantTarget = nextEnPassantTarget
                
                // removing highlights
                withAnimation(.easeOut) {
                    resetHighlightedTiles()
                    self.selectedTile = nil
                }
                
                
                // checking if we have put opposition in check after our move
                
                // for each tile
                for i in gameBoard.indices {
                    for j in gameBoard[i].indices {
                        // for each piece on the side we just moved
                        if let piece = gameBoard[i][j].piece, piece.side == whoMoves {
                            var gameBoard2 = gameBoard
                            
                            // show moves for each piece
                            showAvailableMoves(for: piece, i, j, gameBoard: &gameBoard2, whoMoves: whoMoves)
                            
                            // for each available move, if can take king right now then mark as in check
                            for xi in gameBoard2.indices {
                                for xj in gameBoard2[xi].indices {
                                    if gameBoard2[xi][xj].isHighlighted {
                                        if let targetPiece = gameBoard2[xi][xj].piece, targetPiece.type == .king, targetPiece.side != whoMoves {
                                            isInCheck = true
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                
                // counting available moves to see if checkmate or stalemate occured as a result of our move
                
                var validMoveCount = 0
                // for each tile
                for i in gameBoard.indices {
                    for j in gameBoard[i].indices {
                        // for each piece on the opposition
                        if let piece = gameBoard[i][j].piece, piece.side != whoMoves {
                            var gameBoard2 = gameBoard
                            
                            // show moves for each piece
                            showAvailableMoves(for: piece, i, j, gameBoard: &gameBoard2, whoMoves: whoMoves.swapped())
                            
                            for yi in gameBoard.indices {
                                for yj in gameBoard[yi].indices {
                                    // for each available move
                                    if gameBoard2[yi][yj].isHighlighted {
                                        var gameBoard3 = gameBoard
                                        
                                        // make the move
                                        gameBoard3[yi][yj].piece = gameBoard3[i][j].piece
                                        gameBoard3[i][j].piece = nil
                                        
                                        // tracking if king can be taken
                                        var kingExposed = false
                                        
                                        exposureCheck: for xi in gameBoard3.indices {
                                            for xj in gameBoard3[xi].indices {
                                                // for each piece on current team
                                                if let xpiece = gameBoard3[xi][xj].piece, xpiece.side == whoMoves {
                                                    var gameBoard4 = gameBoard3
                                                    
                                                    // show moves for each piece
                                                    showAvailableMoves(for: xpiece, xi, xj, gameBoard: &gameBoard4, whoMoves: whoMoves)
                                                    
                                                    for zi in gameBoard4.indices {
                                                        for zj in gameBoard4[zi].indices {
                                                            // for each available move on current team
                                                            if gameBoard4[zi][zj].isHighlighted {
                                                                // are we able to capture the king if so flag it
                                                                if let targetPiece = gameBoard4[zi][zj].piece, targetPiece.type == .king, targetPiece.side != whoMoves {
                                                                    kingExposed = true
                                                                    break exposureCheck
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                        
                                        // sum up all valid moves that dont involve exposing the king
                                        if !kingExposed {
                                            validMoveCount += 1
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                
                // if no valid moves, determine checkmate or stalemate
                if validMoveCount == 0 {
                    if isInCheck {
                        endState = .checkmate
                    } else {
                        endState = .stalemate
                    }
                }
                
                // switching whose move it is
                withAnimation {
                    whoMoves.swap()
                }
            }
        } else {
            // no selected piece so select it now
            guard let piece = gameBoard[row][col].piece, piece.side == whoMoves else { return }
            withAnimation(.easeIn) {
                selectedTile = gameBoard[row][col]
                showAvailableMoves(for: piece, row, col, gameBoard: &gameBoard, whoMoves: whoMoves, enPassantTarget: enPassantTarget)
                filterAvailableMoves(for: piece, row, col, gameBoard: &gameBoard, whoMoves: whoMoves)
            }
        }
    }
    
    // showing all possible (unfiltered) moves for a piece
    private func showAvailableMoves(for piece: Piece, _ row: Int, _ col: Int, gameBoard: inout [[Tile]], whoMoves: Side, allowCastling: Bool = true, enPassantTarget: (row: Int, col: Int)? = nil) {
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
                    if col > 0 {
                        let isStandardCapture = (gameBoard[row-1][col-1].piece != nil && gameBoard[row-1][col-1].piece?.side != piece.side)
                        let isEnPassant = (enPassantTarget?.row == row-1 && enPassantTarget?.col == col-1)
                        if isStandardCapture || isEnPassant {
                            gameBoard[row-1][col-1].isHighlighted = true
                        }
                    }
                    
                    // check if can take right diagonal
                    if col < 7 {
                        let isStandardCapture = (gameBoard[row-1][col+1].piece != nil && gameBoard[row-1][col+1].piece?.side != piece.side)
                        let isEnPassant = (enPassantTarget?.row == row-1 && enPassantTarget?.col == col+1)
                        if isStandardCapture || isEnPassant {
                            gameBoard[row-1][col+1].isHighlighted = true
                        }
                    }
                } else {
                    guard row < 7 else { return }
                    
                    if gameBoard[row+1][col].piece == nil {
                        gameBoard[row+1][col].isHighlighted = true
                    }
                    
                    if row == 1 && gameBoard[row+2][col].piece == nil && gameBoard[row+1][col].piece == nil {
                        gameBoard[row+2][col].isHighlighted = true
                    }
                    
                    if col > 0 {
                        let isStandardCapture = (gameBoard[row+1][col-1].piece != nil && gameBoard[row+1][col-1].piece?.side != piece.side)
                        let isEnPassant = (enPassantTarget?.row == row+1 && enPassantTarget?.col == col-1)
                        if isStandardCapture || isEnPassant {
                            gameBoard[row+1][col-1].isHighlighted = true
                        }
                    }
                    
                    if col < 7 {
                        let isStandardCapture = (gameBoard[row+1][col+1].piece != nil && gameBoard[row+1][col+1].piece?.side != piece.side)
                        let isEnPassant = (enPassantTarget?.row == row+1 && enPassantTarget?.col == col+1)
                        if isStandardCapture || isEnPassant {
                            gameBoard[row+1][col+1].isHighlighted = true
                        }
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
                if allowCastling {
                    checkForCastling(for: piece, row, col, gameBoard: &gameBoard, whoMoves: whoMoves)
                }
        }
    }
    
    // check if a tile is under attack by opposition: they can move/take this tile
    private func isTileAttacked(row: Int, col: Int, by side: Side, gameBoard: [[Tile]]) -> Bool {
        for i in gameBoard.indices {
            for j in gameBoard[i].indices {
                if let piece = gameBoard[i][j].piece, piece.side == side {
                    var gameBoard2 = gameBoard
                    
                    for xi in gameBoard2.indices {
                        for xj in gameBoard2[xi].indices {
                            gameBoard2[xi][xj].isHighlighted = false
                        }
                    }
                    
                    showAvailableMoves(for: piece, i, j, gameBoard: &gameBoard2, whoMoves: side, allowCastling: false)
                    if gameBoard2[row][col].isHighlighted {
                        return true
                    }
                }
            }
        }
        return false
    }
    
    // to castle, tap on the king then if available, a tile two spaces left/right will be highlighted
    private func checkForCastling(for piece: Piece, _ row: Int, _ col: Int, gameBoard: inout [[Tile]], whoMoves: Side) {
        guard piece.type == .king, !piece.hasMoved, !isInCheck else { return }
        
        let opponent = whoMoves.swapped()
        
        // for white
        if whoMoves == .white && row == 7 && col == 4 {
            // checking if right side available, if tiles in between empty and not under attack
            if let rook = gameBoard[7][7].piece, rook.type == .rook, !rook.hasMoved,
               gameBoard[7][5].piece == nil, gameBoard[7][6].piece == nil {
                if !isTileAttacked(row: 7, col: 5, by: opponent, gameBoard: gameBoard) && !isTileAttacked(row: 7, col: 6, by: opponent, gameBoard: gameBoard) {
                    gameBoard[7][6].isHighlighted = true
                }
            }
            
            // checking if left side available
            if let rook = gameBoard[7][0].piece, rook.type == .rook, !rook.hasMoved,
               gameBoard[7][1].piece == nil, gameBoard[7][2].piece == nil, gameBoard[7][3].piece == nil {
                if !isTileAttacked(row: 7, col: 3, by: opponent, gameBoard: gameBoard) &&
                    !isTileAttacked(row: 7, col: 2, by: opponent, gameBoard: gameBoard) {
                    gameBoard[7][2].isHighlighted = true
                }
            }
        }
        
        // for black
        if whoMoves == .black && row == 0 && col == 4 {
            if let rook = gameBoard[0][7].piece, rook.type == .rook, !rook.hasMoved,
               gameBoard[0][5].piece == nil, gameBoard[0][6].piece == nil {
                if !isTileAttacked(row: 0, col: 5, by: opponent, gameBoard: gameBoard) &&
                    !isTileAttacked(row: 0, col: 6, by: opponent, gameBoard: gameBoard) {
                    gameBoard[0][6].isHighlighted = true
                }
            }
            
            if let rook = gameBoard[0][0].piece, rook.type == .rook, !rook.hasMoved,
               gameBoard[0][1].piece == nil, gameBoard[0][2].piece == nil, gameBoard[0][3].piece == nil {
                if !isTileAttacked(row: 0, col: 3, by: opponent, gameBoard: gameBoard) &&
                    !isTileAttacked(row: 0, col: 2, by: opponent, gameBoard: gameBoard) {
                    gameBoard[0][2].isHighlighted = true
                }
            }
        }
    }
    
    // filtering the possible moves for a piece to prevent from putting oneself into check
    private func filterAvailableMoves(for piece: Piece, _ row: Int, _ col: Int, gameBoard: inout [[Tile]], whoMoves: Side) {
        for i in gameBoard.indices {
            for j in gameBoard[i].indices {
                // iterating over each possible move
                if gameBoard[i][j].isHighlighted {
                    var gameBoard2 = gameBoard
                    
                    // making the move
                    gameBoard2[i][j].piece = gameBoard2[row][col].piece
                    gameBoard2[row][col].piece = nil
                    
                    // removing all previous highlights
                    for xi in gameBoard2.indices {
                        for xj in gameBoard2[xi].indices {
                            gameBoard2[xi][xj].isHighlighted = false
                        }
                    }
                    
                    // for each piece on opposition, calculating available moves
                    for xi in gameBoard2.indices {
                        for xj in gameBoard2[xi].indices {
                            if let piece = gameBoard2[xi][xj].piece, piece.side != whoMoves {
                                showAvailableMoves(for: piece, xi, xj, gameBoard: &gameBoard2, whoMoves: whoMoves.swapped())
                            }
                        }
                    }
                    
                    // for each available move by oppositon, if we can take the king then this grand move is banned
                    for xi in gameBoard2.indices {
                        for xj in gameBoard2[xi].indices {
                            if gameBoard2[xi][xj].isHighlighted {
                                if gameBoard2[xi][xj].piece?.type == .king {
                                    gameBoard[i][j].isHighlighted = false
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    // remove all highlighted positions from the grid
    private func resetHighlightedTiles() {
        for i in gameBoard.indices {
            for j in gameBoard[i].indices {
                gameBoard[i][j].isHighlighted = false
            }
        }
    }
}

#Preview("Chess by Rishi") {
    ContentView()
}
