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
        
        FlowLayoutView(.horizontal) {
            Text("222")
                .frame(width: 30, height: 30)
                .background(.white)
            
            Text("333333")
                .font(.system(size: 20))
                .background(Color.white)
            
            Text("444444444444")
                .font(.system(size: 20))
                .frame(height: 500, alignment: .top)
            
            Rectangle()
                .fill(.gray)
                .frame(width: 100, height: 100)
            
            Rectangle()
                .fill(.gray)
                .frame(width: 100, height: 100)
        }
        .configurationSpacing(line: 5, item: 5)
    }
}

#Preview {
    ContentView()
}
