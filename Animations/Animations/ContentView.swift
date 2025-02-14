//
//  ContentView.swift
//  Animations
//
//  Created by Jae Chun Yang on 2024-12-16.
//

import SwiftUI

let letters = Array("EdgarMoo")

struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint
    
    func body(content: Content) -> some View {
        content
            .rotation3DEffect(Angle(degrees: amount), axis: (x: 0, y: 1, z: 0))
    }
}

extension AnyTransition {
    static var rotate: AnyTransition {
        .modifier(active: CornerRotateModifier(amount: -270, anchor: .topLeading), identity: CornerRotateModifier(amount: 0, anchor: .topLeading))
    }
}

struct ContentView: View {
    @State private var enabled: [Bool] = [Bool](repeating: false, count: letters.count)
    @State private var dragAmount: [CGSize] = [CGSize](repeating: .zero, count: letters.count)
    @State private var isShowingRectangle: Bool = false
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.yellow, .red], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                Spacer()
                HStack(spacing: 10) {
                    ForEach(0 ..< letters.count, id: \.self) { num in
                        Text(String(letters[num]))
                            .padding(8)
                            .font(.title)
                            .background(enabled[num] ? .green : .red)
                            .clipShape(.rect(cornerRadius: 8))
                            .offset(dragAmount[num])
                            .gesture(
                                DragGesture()
                                    .onChanged { dragAmount[num] = $0.translation }
                                    .onEnded { _ in
                                        withAnimation(.spring){
                                            dragAmount[num] = .zero
                                        }
                                        withAnimation(.default) {
                                            enabled[num].toggle()
                                        }
                                    }
                            )
                    }
                }
                Spacer()
                Button("Tap Me to Show Rectangle!") {
                    withAnimation() {
                        isShowingRectangle.toggle()
                    }
                }
                .padding(16)
                .background( LinearGradient(
                    colors: [.cyan, .indigo, .cyan],
                    startPoint: .top,
                    endPoint: .bottom
                ))
                .foregroundStyle(.white)
                .font(.headline)
                .clipShape(.rect(cornerRadius: 8))
                
                Spacer()
                if isShowingRectangle {
                    Rectangle()
                        .fill(
                            LinearGradient(
                                colors: [.green, .indigo],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .frame(width: 200, height: 200)
                        .transition(.rotate)
                    
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
