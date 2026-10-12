import SwiftUI

enum Player {
    case x, o
}

class GameViewModel: ObservableObject {
    @Published var board: [[Player?]] = Array(repeating: Array(repeating: nil, count: 3), count: 3)
    @Published var currentPlayer: Player = .x
    @Published var winner: Player? = nil
    @Published var isDraw: Bool = false
    @Published var winningCells: [(Int, Int)] = []

    func makeMove(row: Int, col: Int) {
        guard winner == nil && !isDraw && board[row][col] == nil else { return }

        board[row][col] = currentPlayer

        if checkWinner() {
            winner = currentPlayer
        } else if isBoardFull() {
            isDraw = true
        } else {
            currentPlayer = currentPlayer == .x ? .o : .x
        }
    }

    func checkWinner() -> Bool {
        // Проверка строк
        for row in 0..<3 {
            if let player = board[row][0],
               board[row][1] == player,
               board[row][2] == player {
                winningCells = [(row, 0), (row, 1), (row, 2)]
                return true
            }
        }

        // Проверка столбцов
        for col in 0..<3 {
            if let player = board[0][col],
               board[1][col] == player,
               board[2][col] == player {
                winningCells = [(0, col), (1, col), (2, col)]
                return true
            }
        }

        // Проверка диагоналей
        if let player = board[0][0],
           board[1][1] == player,
           board[2][2] == player {
            winningCells = [(0, 0), (1, 1), (2, 2)]
            return true
        }

        if let player = board[0][2],
           board[1][1] == player,
           board[2][0] == player {
            winningCells = [(0, 2), (1, 1), (2, 0)]
            return true
        }

        return false
    }

    func isBoardFull() -> Bool {
        for row in board {
            for cell in row {
                if cell == nil {
                    return false
                }
            }
        }
        return true
    }

    func isWinningCell(row: Int, col: Int) -> Bool {
        return winningCells.contains { $0 == row && $1 == col }
    }

    func resetGame() {
        board = Array(repeating: Array(repeating: nil, count: 3), count: 3)
        currentPlayer = .x
        winner = nil
        isDraw = false
        winningCells = []
    }
}
