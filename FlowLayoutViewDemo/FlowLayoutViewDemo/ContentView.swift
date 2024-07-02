//
//  ContentView.swift
//  FlowLayoutViewDemo
//
//  Created by Gab on 2024/07/01.
//

import SwiftUI
//import FlowLayoutView
import GabFlowLayout

struct ContentView: View {
    var body: some View {
        FlowLayoutView(style: FlowLayoutModel(item: ["1", "2", "3"],
                                              configuration: .init(lineSpacing: 5,
                                                                   itemSpacing: 5),
                                              alignment: .leading))
        
    }
}

#Preview {
    ContentView()
}
