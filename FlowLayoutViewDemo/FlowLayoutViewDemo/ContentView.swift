//
//  ContentView.swift
//  FlowLayoutViewDemo
//
//  Created by Gab on 2024/07/01.
//

import SwiftUI

import GabFlowLayout

struct ContentView: View {
    
    var list: [String] = [
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
        FlowLayoutView(.vertical) {
            ForEach(list, id: \.self) { string in
                Text(string)
                    .font(.headline)
                    .padding(.all, 2)
                    .background(.mint)
                    .cornerRadius(8)
            }
            
            Rectangle()
                .fill(.pink)
                .frame(width: 100, height: 500)
            
            RoundedRectangle(cornerRadius: 12)
                .fill(.blue)
                .frame(width: 100, height: 500)
        }
        .configurationSpacing(line: 5, item: 5)
        .padding(.all, 10)
    }
}

#Preview {
    ContentView()
}
