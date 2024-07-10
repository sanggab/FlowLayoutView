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
//        FlowLayoutView(.horizontal) {
//            ForEach(list, id: \.self) { string in
//                Text(string)
//                    .font(.headline)
//                    .padding(.all, 2)
//                    .background(.mint)
//                    .cornerRadius(8)
//            }
//
//        }
//        .configurationSpacing(line: 5, item: 5)
//        .scrollMode(true)
//        .padding(.all, 10)
//        .background(.pink)
        
        FlowLayoutView(.horizontal) {
            ForEach(list, id: \.self) { string in
                Text(string)
                    .font(.headline)
                    .padding(.all, 2)
                    .background(.mint)
                    .cornerRadius(8)
            }
            
            Rectangle()
                .fill(.blue)
                .frame(width: 100, height: 200)
            
            Rectangle()
                .fill(.blue)
                .frame(width: 100, height: 300)
        }
        .configurationSpacing(line: 5, item: 5)
        .scrollMode(true)
//        .frame(width: 300, height: 300)
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.pink)
    }
}

#Preview {
    ContentView()
}
