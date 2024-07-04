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
        "가나다라", "마바사", "아자", "차", "카타파하", "나는 심상갑", "구인구직중이지", "아아 테스트 중이다", "1", "2", "3", "4"
    ]
    
    var body: some View {
//        FlowLayoutView<Test, Text>(item: list,
//                       configuration: .init(lineSpacing: 5,
//                                            itemSpacing: 5),
//                       alignment: .leading) { element in
//            Text("hi")
//        }
//        FlowLayoutView(item: list,
//                       configuration: .init(lineSpacing: 5,
//                                            itemSpacing: 5),
//                       alignment: .leading,
//                       content: { element in
//            Text(element)
//                .font(.system(size: 15))
//                .foregroundStyle(.black)
//                .padding(5)
//                .background(.gray)
//        })
//        .padding(.all, 5)
        
        FlowLayoutView(.horizontal) {
            Text("1")
                .background(Color.white)
            
            Text("222")
                .background(Color.white)
            
            Text("333333")
                .font(.system(size: 20))
                .background(Color.white)
            
            Text("444444444444444dadsadddddddd")
                .font(.system(size: 20))
                .background(Color.white)

            Text("5555555555555555555555")
                .background(Color.white)

            Text("6666666666666666666666666")
                .background(Color.white)
            
            Text("666666666666666666666666666666666666aaaaa")
                .background(Color.white)
        }
        .configurationSpacing(line: 5, item: 5)
    }
}

#Preview {
    ContentView()
}
