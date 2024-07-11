//
//  ContentView.swift
//  FlowLayoutViewDemo
//
//  Created by Gab on 2024/07/01.
//

import SwiftUI

import GabFlowLayout

struct ContentView: View {
    
    @State var list: [String] = [
        "Sim",
        "Sang",
        "Gab",
        "KaPPa",
        "GabFlowLayout",
        "GabChipView",
        "swiftui-flowLayout",
        "Gab's 4th SwiftUI Library"
    ]
    
    var body: some View {
        FlowLayoutView(.horizontal) {
            ForEach(list, id: \.self) { string in
                Text(string)
                    .font(.headline)
                    .padding(.all, 2)
                    .background(.mint)
                    .cornerRadius(8)
            }
            
            Rectangle()
                .fill(.pink)
                .frame(width: 300, height: 100)
            
            RoundedRectangle(cornerRadius: 12)
                .fill(.blue)
            .frame(width: 350, height: 150)
        }
        .configurationSpacing(line: 5, item: 5)
        .layoutMode(.scroll(false))
        .frame(width: 300, height: 300)
        .padding(.all, 10)
        .background(.gray)
    }
}

#Preview {
    ContentView()
}
