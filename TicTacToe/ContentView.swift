import SwiftUI

struct ContentView: View {
    @StateObject private var game = GameViewModel()

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color(hex: "667eea"), Color(hex: "764ba2")]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 30) {
                Text("Крестики-Нолики")
                    .font(.system(size: 44, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)

                StatusView(currentPlayer: game.currentPlayer, winner: game.winner, isDraw: game.isDraw)

                GameBoardView(game: game)

                Button(action: {
                    withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
                        game.resetGame()
                    }
                }) {
                    Text("Новая игра")
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                        .foregroundColor(.white)
                        .padding(.horizontal, 40)
                        .padding(.vertical, 16)
                        .background(
                            Capsule()
                                .fill(Color.white.opacity(0.3))
                                .overlay(
                                    Capsule()
                                        .stroke(Color.white.opacity(0.5), lineWidth: 2)
                                )
                        )
                        .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
                }
                .padding(.top, 20)

                Spacer()
            }
            .padding(.top, 60)
        }
    }
}

struct StatusView: View {
    let currentPlayer: Player
    let winner: Player?
    let isDraw: Bool

    var body: some View {
        VStack(spacing: 12) {
            if let winner = winner {
                HStack(spacing: 12) {
                    Text(winner == .x ? "✕" : "◯")
                        .font(.system(size: 36, weight: .bold))
                        .foregroundColor(winner == .x ? Color(hex: "ff6b6b") : Color(hex: "4ecdc4"))
                    Text("победил!")
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                }
            } else if isDraw {
                Text("Ничья!")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
            } else {
                HStack(spacing: 12) {
                    Text("Ход:")
                        .font(.system(size: 24, weight: .semibold, design: .rounded))
                        .foregroundColor(.white.opacity(0.9))
                    Text(currentPlayer == .x ? "✕" : "◯")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(currentPlayer == .x ? Color(hex: "ff6b6b") : Color(hex: "4ecdc4"))
                }
            }
        }
        .padding(.horizontal, 30)
        .padding(.vertical, 20)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white.opacity(0.2))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.white.opacity(0.3), lineWidth: 2)
                )
        )
        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
    }
}

struct GameBoardView: View {
    @ObservedObject var game: GameViewModel

    var body: some View {
        VStack(spacing: 16) {
            ForEach(0..<3) { row in
                HStack(spacing: 16) {
                    ForEach(0..<3) { col in
                        CellView(
                            player: game.board[row][col],
                            isWinningCell: game.isWinningCell(row: row, col: col)
                        ) {
                            withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                                game.makeMove(row: row, col: col)
                            }
                        }
                    }
                }
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.white.opacity(0.15))
                .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(Color.white.opacity(0.3), lineWidth: 3)
                )
        )
        .shadow(color: .black.opacity(0.2), radius: 20, x: 0, y: 10)
        .padding(.horizontal, 20)
    }
}

struct CellView: View {
    let player: Player?
    let isWinningCell: Bool
    let action: () -> Void

    @State private var isPressed = false

    var body: some View {
        Button(action: action) {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(isWinningCell ? Color.yellow.opacity(0.3) : Color.white.opacity(0.3))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.white.opacity(0.5), lineWidth: 2)
                    )
                    .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 3)

                if let player = player {
                    Text(player == .x ? "✕" : "◯")
                        .font(.system(size: 50, weight: .bold))
                        .foregroundColor(player == .x ? Color(hex: "ff6b6b") : Color(hex: "4ecdc4"))
                        .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
                        .transition(.scale.combined(with: .opacity))
                }
            }
            .frame(width: 100, height: 100)
            .scaleEffect(isPressed ? 0.95 : 1.0)
        }
        .buttonStyle(PlainButtonStyle())
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in isPressed = true }
                .onEnded { _ in isPressed = false }
        )
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
