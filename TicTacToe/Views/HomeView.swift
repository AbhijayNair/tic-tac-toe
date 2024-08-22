//
//  HomeView.swift
//  TicTacToe
//
//  Created by Abhijay Nair on 8/18/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
            NavigationStack{
            GeometryReader{ cont in
                ZStack{
                    AnimatedBackground()
                    VStack{
                        Spacer()
                        VStack{
                            Text("Noughts").font(.custom("Chalkduster", size: 64)).bold().foregroundStyle(.white).frame(maxWidth: .infinity, alignment: .center)
                            
                            Text("&").font(.custom("Chalkduster", size: 64)).bold().foregroundStyle(.white).frame(maxWidth: .infinity, alignment: .center)
                            
                            Text("Crosses").font(.custom("Chalkduster", size: 64)).bold().foregroundStyle(.white).frame(maxWidth: .infinity, alignment: .center)
                        }
                        Spacer()
                        VStack(spacing:10){
                            NavigationLink(destination: PickSide(oper: 0)){
                                Text("Against AI").padding(16.0).frame(width:cont.size.width/1.2).font(.custom("Chalkduster", size: 28)).foregroundStyle(.white).background(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, style: .continuous).stroke(lineWidth: 4.0)).foregroundStyle(.white)
                            }
                            NavigationLink(destination: PickSide(oper: 1)){
                                Text("Against Friend").padding(16.0).frame(width:cont.size.width/1.2).font(.custom("Chalkduster", size: 28)).foregroundStyle(.white).background(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, style: .continuous).stroke(lineWidth: 4.0)).foregroundStyle(.white)
                            }
                        }
                        Spacer()
                    }
                }
            }
            }.navigationBarBackButtonHidden()
    }
}

#Preview {
    HomeView()
}
