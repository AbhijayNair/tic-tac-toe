# Noughts & Crosses

A simple Swift-based game for iOS to play a game of Tic-Tac-Toe against an AI or another player. The game utilizes the minimax algorithm with alpha-beta pruning to search and evaluate the future game states and pick the next move by choosing the position on the board that maximizes the possibility of winning. By pruning the search tree, the algorithm is able to search for 9 levels of depth. Since the AI can look ahead to a
bunch of different states, the only possibility for it is to either win or draw the game.

## Screenshots
<img src="https://github.com/user-attachments/assets/54261b68-fc75-43db-8b07-738031001186" width="200" height="400"/>
<img src="https://github.com/user-attachments/assets/021e4d6e-e1d0-4aa1-9055-a5321f864faf" width="200" height="400"/>

## Try it out

1. Clone the repository to your system using
    ```bash
    git clone https://github.com/AbhijayNair/tic-tac-toe.git
    ```
2. Open the xcodeproj file on Xcode, choose your target phone and run it.
