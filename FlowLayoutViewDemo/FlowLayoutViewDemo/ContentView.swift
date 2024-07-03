//
//  ContentView.swift
//  FlowLayoutViewDemo
//
//  Created by Gab on 2024/07/01.
//

import SwiftUI
//import FlowLayoutView
import GabFlowLayout

struct Test: FlowLayoutStyle {
    var item: FlowItem<String>
    
    var configuration: FlowConfiguration
    
    var alignment: FlowAlignment
    
}

struct ContentView: View {
    var list: [String] = [
        "가나다라", "마바사", "아자", "차", "카타파하", "나는 심상갑", "구인구직중이지"
    ]
    
    var body: some View {
        Text("1")
    }
}

#Preview {
    ContentView()
}
