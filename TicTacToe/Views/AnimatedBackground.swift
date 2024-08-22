//
//  AnimatedBackground.swift
//  TicTacToe
//
//  Created by Abhijay Nair on 8/18/24.
//

import SwiftUI

struct AnimatedBackground: View {
    var xos: [String] = ["X", "O"]
    @State var xoffset: CGFloat = -100
    @State var yoffset: CGFloat = -200
    var body: some View {
        GeometryReader { screen in
            let size = screen.size.width / 4
            ZStack{
                Color(.black)
                VStack(spacing: 40){
                    ForEach(1...100, id:\.self){ _ in
                        HStack(spacing:20){
                            ForEach(xos, id:\.self){ char in
                                Text(char).font(.title).bold().foregroundStyle(.gray).opacity(0.2).frame(width: size/4, height: size/4)
                            }.offset(x: xoffset, y: yoffset)
                            ForEach(xos, id:\.self){ char in
                                Text(char).font(.title).bold().foregroundStyle(.gray).opacity(0.2).frame(width: size/4, height: size/4)
                            }.offset(x: xoffset, y: yoffset)
                            ForEach(xos, id:\.self){ char in
                                Text(char).font(.title).bold().foregroundStyle(.gray).opacity(0.2).frame(width: size/4, height: size/4)
                            }.offset(x: xoffset, y: yoffset)
                            ForEach(xos, id:\.self){ char in
                                Text(char).font(.title).bold().foregroundStyle(.gray).opacity(0.2).frame(width: size/4, height: size/4)
                            }.offset(x: xoffset, y: yoffset)
                            ForEach(xos, id:\.self){ char in
                                Text(char).font(.title).bold().foregroundStyle(.gray).opacity(0.2).frame(width: size/4, height: size/4)
                            }.offset(x: xoffset, y: yoffset)
                            ForEach(xos, id:\.self){ char in
                                Text(char).font(.title).bold().foregroundStyle(.gray).opacity(0.2).frame(width: size/4, height: size/4)
                            }.offset(x: xoffset, y: yoffset)
                            ForEach(xos, id:\.self){ char in
                                Text(char).font(.title).bold().foregroundStyle(.gray).opacity(0.2).frame(width: size/4, height: size/4)
                            }.offset(x: xoffset, y: yoffset)
                            ForEach(xos, id:\.self){ char in
                                Text(char).font(.title).bold().foregroundStyle(.gray).opacity(0.2).frame(width: size/4, height: size/4)
                            }.offset(x: xoffset, y: yoffset)
                        }.rotationEffect(.degrees(-45)).onAppear{
                            withAnimation(.linear(duration: 4).repeatForever(autoreverses: true)){
                                xoffset = size/4
                                
                            }
                        }
                    }
                }
            }.ignoresSafeArea()
        }
    }
}

#Preview {
    AnimatedBackground()
}
