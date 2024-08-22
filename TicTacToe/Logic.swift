//
//  Logic.swift
//  TicTacToe
//
//  Created by Abhijay Nair on 8/19/24.
//

import Foundation
import Swift

class Logic: ObservableObject {
    // Maximum depth of the minimax tree to evaluate
    private let MAX_DEPTH: Int = 8
    
    // Use the maximum and minimum values to perform alpha-beta pruning
    private let MAX_VAL: Int = Int.max
    private let MIN_VAL: Int = Int.min
    
    @Published var board: [[String]] = [["", "", ""], ["", "", ""], ["", "", ""]]
    @Published var p1Marker: String
    @Published var p2Marker: String
    @Published var isP1Turn: Bool = Bool.random()
    @Published var isGameOver: Bool = false
    
    init(p1Marker: String, p2Marker: String){
        self.p1Marker = p1Marker
        self.p2Marker = p2Marker
        startNewGame()
    }
    
    func aiTurn() -> [Int] {
        guard !self.isGameOver else {return []}
        var bestM: [Int] = []
        (_, bestM) = minimax(board: board, depth: 0, alpha: MIN_VAL, beta: MAX_VAL, isMaxNode: true)
        return bestM
    }
    
    func checkIfGameOver(tboard: [[String]]) -> Bool {
        if heurA(pboard: tboard, sym: p2Marker) >= 1 || heurA(pboard: tboard, sym: p1Marker) >= 1 || isBoardFilled(tboard: tboard){
            isGameOver = true
            return true
        }
        return false
    }
    
    
    func startNewGame() -> Void{
        for i in 0...2 {
            for j in 0...2 {
                self.board[i][j] = ""
            }
        }
        isP1Turn = Bool.random()
        isGameOver = false
        if !isP1Turn{
            let nextPos = aiTurn()
            board[nextPos[0]][nextPos[1]] = p2Marker
            isP1Turn.toggle()
        }
    }
    
    // Heurisitics computation for the minimax algorithm
    
    private func heuristic(pboard: [[String]]) -> Int{
        var res: Int
        let A = heurA(pboard: pboard, sym: p2Marker)
        let B = heurB(pboard: pboard, sym: p2Marker)
        let C = heurC(pboard: pboard, sym: p2Marker)
        let D = heurA(pboard: pboard, sym: p1Marker)
        let E = heurB(pboard: pboard, sym: p1Marker)
        let F = heurC(pboard: pboard, sym: p1Marker)
        let partA = 100*A + 10*B + C
        let partB = (100*D + 10*E + F)
        res =  partA - partB
        return res
    }
    
    // Check the winning condition
    private func heurA(pboard:[[String]], sym: String) -> Int{
        var res: Int = 0
        for i in 0...2{
            
            // Check the rows
            if pboard[i][0] == sym && pboard[i][1] == sym && pboard[i][2] == sym {
                res += 1
            }
            
            // Check the column
            if pboard[0][i] == sym && pboard[1][i] == sym && pboard[2][i] == sym {
                res += 1
            }
        }
        
        // Check the two diagonals
        if pboard[0][0] == sym && pboard[1][1] == sym && pboard[2][2] == sym {
            res += 1
        }
        if pboard[0][2] == sym && pboard[1][1] == sym && pboard[2][0] == sym {
            res += 1
        }
        return res
    }
    
    // Check the number of unblocked 2 symbols
    private func heurB(pboard:[[String]], sym: String) -> Int{
        var res: Int = 0
        
        for i in 0...2{
            
            // Check the rows
            if pboard[i][0] == sym && pboard[i][1] == "" && pboard[i][2] == sym {
                res += 1
            }
            else if pboard[i][0] == "" && pboard[i][1] == sym && pboard[i][2] == sym {
                res += 1
            }
            else if pboard[i][0] == sym && pboard[i][1] == sym && pboard[i][2] == "" {
                res += 1
            }
            
            // Check the columns
            if pboard[0][i] == sym && pboard[1][i] == "" && pboard[2][i] == sym {
                res += 1
            }
            else if pboard[0][i] == "" && pboard[1][i] == sym && pboard[2][i] == sym {
                res += 1
            }
            else if pboard[0][i] == sym && pboard[1][i] == sym && pboard[2][i] == "" {
                res += 1
            }
        }
        
        // Check the right diagonal
        if pboard[0][0] == sym && pboard[1][1] == "" && pboard[2][2] == sym {
            res += 1
        }
        else if pboard[0][0] == "" && pboard[1][1] == sym && pboard[2][2] == sym {
            res += 1
        }
        else if pboard[0][0] == sym && pboard[1][1] == sym && pboard[2][2] == "" {
            res += 1
        }
        
        // Check the left diagonal
        if pboard[0][2] == sym && pboard[1][1] == "" && pboard[2][0] == sym {
            res += 1
        }
        else if pboard[0][2] == "" && pboard[1][1] == sym && pboard[2][0] == sym  {
            res += 1
        }
        else if pboard[0][2] == sym && pboard[1][1] == sym && pboard[2][0] == "" {
            res += 1
        }
        
        return res
    }
    private func heurC(pboard:[[String]], sym: String) -> Int{
        var res: Int = 0
        
        for i in 0...2{
            
            // Check the rows
            if pboard[i][0] == sym && pboard[i][1] == "" && pboard[i][2] == "" {
                res += 1
            }
            else if pboard[i][0] == "" && pboard[i][1] == sym && pboard[i][2] == "" {
                res += 1
            }
            else if pboard[i][0] == "" && pboard[i][1] == "" && pboard[i][2] == sym {
                res += 1
            }
            
            // Check the columns
            if pboard[i][0] == sym && pboard[i][1] == "" && pboard[i][2] == "" {
                res += 1
            }
            else if pboard[i][0] == "" && pboard[i][1] == sym && pboard[i][2] == "" {
                res += 1
            }
            else if pboard[i][0] == "" && pboard[i][1] == "" && pboard[i][2] == sym {
                res += 1
            }
        }
        
        // Check the right diagonal
        if pboard[0][0] == sym && pboard[1][1] == "" && pboard[2][2] == "" {
            res += 1
        }
        else if pboard[0][0] == "" && pboard[1][1] == sym && pboard[2][2] == "" {
            res += 1
        }
        else if pboard[0][0] == "" && pboard[1][1] == "" && pboard[2][2] == sym {
            res += 1
        }
        
        // Check the left diagonal
        if pboard[0][2] == sym && pboard[1][1] == "" && pboard[2][0] == "" {
            res += 1
        }
        else if pboard[0][2] == "" && pboard[1][1] == sym && pboard[2][0] == "" {
            res += 1
        }
        else if pboard[0][2] == "" && pboard[1][1] == "" && pboard[2][0] == sym {
            res += 1
        }
        return res
    }
    
    // Helper functions
    
    private func isBoardFilled(tboard: [[String]]) -> Bool {
        for i in 0...2 {
            for j in 0...2 {
                if tboard[i][j] == ""{
                    return false
                }
            }
        }
        return true
    }
    
    private func minimax(board: [[String]], depth: Int, alpha: Int, beta: Int, isMaxNode: Bool) -> (Int, [Int]) {
        if depth == MAX_DEPTH || _checkIfGameOver(tboard: board){
            return (heuristic(pboard: board), [])
        }
        var talpha = alpha
        var tbeta = beta
        var bestM: [Int] = []
        if isMaxNode {
            var maxEval: Int = MIN_VAL
            let nextCoords = successors(board: board)
            for coord in nextCoords {
                let (eval, _) = minimax(board: addSymbol(board: board, coords: coord, sym: p2Marker), depth: depth+1, alpha: talpha, beta: tbeta, isMaxNode: false)
                if eval > maxEval {
                    maxEval = eval
                    bestM = coord
                }
                talpha = max(talpha, maxEval)
                if tbeta <= talpha{
                    break
                }
            }
            return (maxEval, bestM)
        }
        else{
            var minEval: Int = MAX_VAL
            let nextCoords = successors(board: board)
            for coord in nextCoords {
                let (eval, _) = minimax(board: addSymbol(board: board, coords: coord, sym: p1Marker), depth: depth+1, alpha: talpha, beta: tbeta, isMaxNode: true)
                if eval < minEval {
                    minEval = eval
                    bestM = coord
                }
                tbeta = min(tbeta, minEval)
                if tbeta <= talpha{
                    break
                }
            }
            return (minEval, bestM)
        }
    }
    
    private func addSymbol(board: [[String]], coords: [Int], sym: String) -> [[String]]{
        var tboard = board
        tboard[coords[0]][coords[1]] = sym
        return tboard
    }
    
    private func _checkIfGameOver(tboard: [[String]]) -> Bool {
        if heurA(pboard: tboard, sym: p2Marker) >= 1 || heurA(pboard: tboard, sym: p1Marker) >= 1 || isBoardFilled(tboard: tboard){
            return true
        }
        return false
    }
    
    private func successors(board: [[String]]) -> [[Int]] {
        var coords: [[Int]] = []
        for i in 0...2{
            for j in 0...2{
                if board[i][j] == ""{
                    coords.append([i, j])
                }
            }
        }
        return coords
    }
}
