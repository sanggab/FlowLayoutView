//
//  ContentView.swift
//  FlowLayoutViewDemo
//
//  Created by Gab on 2024/07/01.
//

import SwiftUI
//import FlowLayoutView
import GabFlowLayout

//struct Test: FlowLayoutStyle {
//    var item: FlowItem<String>
//    
//    var configuration: FlowConfiguration
//    
//    var alignment: FlowAlignment
//    
//}

struct ContentView: View {
    var body: some View {
        FlowLayoutView(style: FlowLayoutModel(item: ["1", "2", "3"],
                                              configuration: .init(lineSpacing: 5,
                                                                   itemSpacing: 5),
                                              alignment: .leading)) { element in
            
        }
        
        
//        FlowLayoutView(style: Test(item: .init(list: ["1"]), configuration: .zero, alignment: .leading)) { value in
//            
//        }
    }
}

#Preview {
    ContentView()
}
