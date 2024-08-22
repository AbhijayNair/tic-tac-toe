//
//  GameScreen.swift
//  TicTacToe
//
//  Created by Abhijay Nair on 8/18/24.
//

import SwiftUI

struct GameScreen: View {
    @Environment (\.dismiss) var dismiss
    @StateObject private var gameLogicModel: Logic
    
    @State var oper: Int
    @State var startDrawingBoard:[[Bool]] = [[false, false, false], [false, false, false], [false, false, false]]
    @State var p1Name: String = "P1"
    @State var p2Name: String
    @State var hasBoardRendered: Bool = false
    
    
    init(oper: Int, p1Marker: String) {
        self.oper = oper
        self.p2Name = oper==0 ? "AI" : "P2"
        _gameLogicModel = StateObject(wrappedValue: Logic(p1Marker: p1Marker, p2Marker: p1Marker == "X" ? "O" : "X"))
    }
    
    var body: some View {
        GeometryReader{ _screen in
            NavigationStack{
                ZStack{
                    AnimatedBackground()
                    VStack {
                        Spacer()
                        Text(gameLogicModel.isP1Turn ? "\(p1Name)'s Turn" : "\(p2Name)'s Turn").padding(16.0).font(.custom("Chalkduster", size: 56)).foregroundStyle(.white)
                       
                        Spacer()
                        drawBoard()
                        Spacer()
                        VStack{
                            Button {
                                gameLogicModel.startNewGame()
                            }label: {
                                Text("Play Again!").padding(16.0).frame(width:buttonWidth()*2.5).font(.custom("Chalkduster", size: 28)).foregroundStyle(.white).background(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, style: .continuous).stroke(lineWidth: 4.0)).foregroundStyle(.white)
                            }
                            
                            NavigationLink(destination: HomeView()){
                                Text("Back to Home").padding(16.0).frame(width:buttonWidth()*2.5).font(.custom("Chalkduster", size: 28)).foregroundStyle(.white).foregroundStyle(.white)
                            }
                        }.frame(height: buttonWidth()*2.5).opacity(gameLogicModel.isGameOver ? 1 : 0)
                    }
                }
            }.navigationBarBackButtonHidden()
        }
    }
}

func buttonWidth() -> CGFloat {
    return (abs(UIScreen.main.bounds.width - (5*12))) / 3
}

extension GameScreen {
    
    private func handleGameButtonPressed(i: Int, j: Int) -> Void {
        guard gameLogicModel.board[i][j] == "" else{
            debugPrint("not set in guard")
            return
        }
        if (gameLogicModel.isP1Turn){
            gameLogicModel.board[i][j] = gameLogicModel.p1Marker
            let _ = gameLogicModel.checkIfGameOver(tboard: gameLogicModel.board)
            gameLogicModel.isP1Turn.toggle()
            if oper == 0 {
                let nCoords = gameLogicModel.aiTurn()
                guard !nCoords.isEmpty else {
                    debugPrint("invalid next move")
                    let _ = gameLogicModel.checkIfGameOver(tboard: gameLogicModel.board)
                    return
                }
                gameLogicModel.board[nCoords[0]][nCoords[1]] = gameLogicModel.p2Marker
                gameLogicModel.isP1Turn.toggle()
                let _ = gameLogicModel.checkIfGameOver(tboard: gameLogicModel.board)
                debugPrint(gameLogicModel.board)
            }
        }
        else if(!gameLogicModel.isP1Turn && oper == 1){
            gameLogicModel.board[i][j] = gameLogicModel.p2Marker
            let _ = gameLogicModel.checkIfGameOver(tboard: gameLogicModel.board)
            gameLogicModel.isP1Turn.toggle()
        }
    }
    
    private func gameButtonLabel(i: Int, j: Int, idx: Int) -> some View{
        Text(gameLogicModel.board[i][j]).padding(16.0).frame(width:buttonWidth(), height:buttonWidth()).font(.custom("Chalkduster", size: 56)).foregroundStyle(.white).background(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, style: .continuous).stroke(lineWidth: 4.0)).foregroundStyle(.white).opacity(startDrawingBoard[i][j] ? 1 : 0).onAppear{
            withAnimation(.easeIn(duration: 0.5).delay(0.1*Double(idx))){
                startDrawingBoard[i][j].toggle()
            }
        }
        
    }
    
    func drawBoard() -> some View {  Grid{
        GridRow{
            Button{
                handleGameButtonPressed(i: 0, j: 0)
            }label: {
                gameButtonLabel(i: 0, j: 0, idx: 1)
            }
            
                Button{
                    handleGameButtonPressed(i: 0, j: 1)
                }label: {
                    gameButtonLabel(i: 0, j: 1, idx: 2)
                }
            
                Button{
                    handleGameButtonPressed(i: 0, j: 2)
                }label: {
                    gameButtonLabel(i: 0, j: 2, idx: 3)
                }
        }.padding(4)
        
            GridRow{
                Button{
                    handleGameButtonPressed(i: 1, j: 0)
                }label: {
                    gameButtonLabel(i: 1, j: 0, idx: 4)
                }
                
                    Button{
                        handleGameButtonPressed(i: 1, j: 1)
                    }label: {
                        gameButtonLabel(i: 1, j: 1, idx: 5)
                    }
                
                    Button{
                        handleGameButtonPressed(i: 1, j: 2)
                    }label: {
                        gameButtonLabel(i: 1, j: 2, idx: 6)
                    }
            }.padding(4)
        
            GridRow{
                Button{
                    handleGameButtonPressed(i: 2, j: 0)
                }label: {
                    gameButtonLabel(i: 2, j: 0, idx: 7)
                }
                
                    Button{
                        handleGameButtonPressed(i: 2, j: 1)
                    }label: {
                        gameButtonLabel(i: 2, j: 1, idx: 8)
                    }
                
                    Button{
                        handleGameButtonPressed(i: 2, j: 2)
                    }label: {
                        gameButtonLabel(i: 2, j: 2, idx: 9)
                    }
            }.padding(4)
    }.onAppear{
        withAnimation(Animation.easeOut(duration: 1)){
            
        }
    }
}
}


#Preview {
    GameScreen(oper:1, p1Marker: "X")
}
