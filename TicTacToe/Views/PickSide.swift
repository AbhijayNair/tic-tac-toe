//
//  GameScreen.swift
//  TicTacToe
//
//  Created by Abhijay Nair on 8/18/24.
//

import SwiftUI

struct PickSide: View {
    @State var oper: Int
    @Environment(\.dismiss) var dismiss
    init(oper: Int) {
        self.oper = oper
    }
    
    var body: some View {
        GeometryReader{ _cont in
            let screenWidth = _cont.size.width
            let screenHeight = _cont.size.height
            NavigationStack{
                ZStack{
                    AnimatedBackground()
                    VStack{
                        HStack{
                            Button{
                                dismiss()
                            }label: {
                                Image(systemName: "arrow.left").resizable().frame(width: 24, height: 24).foregroundStyle(.white).padding(8.0)
                            }
                            Spacer()
                            Text(oper == 1 ? "P1's Mark" : "Your Mark").font(.custom("Chalkduster", size: 54)).bold().foregroundStyle(.white).frame(maxWidth: .infinity, alignment: .center)
                            Spacer()
                            
                        }
                        Spacer()
                        NavigationLink(destination: {}){
                            VStack(spacing:30){
                                NavigationLink(destination: GameScreen(oper: oper, p1Marker: "X")){
                                    Text("X").padding(16.0).frame(width:screenWidth/1.2, height: screenHeight/3).font(.custom("Chalkduster", size: 80)).foregroundStyle(.white).background(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, style: .continuous).stroke(lineWidth: 4.0)).foregroundStyle(.white)
                                }
                                NavigationLink(destination: GameScreen(oper: oper, p1Marker: "O")){
                                    Text("O").padding(16.0).frame(width:screenWidth/1.2, height:screenHeight/3).font(.custom("Chalkduster", size: 80)).foregroundStyle(.white).background(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, style: .continuous).stroke(lineWidth: 4.0)).foregroundStyle(.white)
                                }
                            }
                        }
                        Spacer()
                    }
                }
            }.navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    PickSide(oper: 0)
}
