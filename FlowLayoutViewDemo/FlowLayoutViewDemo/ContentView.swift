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
        
//        ScrollView(.horizontal) {
//            Text("1")
//                .background(Color.white)
//            
//            Text("222")
//                .background(Color.white)
//            
//            Text("333333")
//                .font(.system(size: 20))
//                .background(Color.white)
//            
//            Text("444444444444")
//                .font(.system(size: 20))
//                .frame(height: 500)
//                .background(Color.white)
//            
//            Text("444444444444")
//                .font(.system(size: 20))
//                .frame(height: 300)
//                .background(Color.white)
//            
//            Rectangle()
//                .fill(.blue)
//                .frame(width: 1000, height: 300)
//        }
//        .background(Color.pink)
        
        FlowLayoutView(.horizontal) {
            Text("1")
                .frame(width: 20, height: 20)
                .background(.mint)
            
            Text("222")
                .frame(width: 30, height: 30)
                .background(.pink)
//
//            Text("333333")
//                .font(.system(size: 20))
//                .background(Color.white)
//            
//            Text("444444444444")
//                .font(.system(size: 20))
//                .frame(height: 500)
//                .background(Color.white)
////
//            Text("444444444444")
//                .frame(height: 300)
//                .font(.system(size: 20))
//                .background(Color.white)
        }
        .configurationSpacing(line: 5, item: 5)
//        .background(.pink)
        
//        ScrollView(.vertical) {
//            FlowLayoutView(.horizontal) {
//                Group {
//                    Text("1")
//                        .background(Color.white)
//                    
//                    Text("222")
//                        .background(Color.white)
//                    
//                    Text("333333")
//                        .font(.system(size: 20))
//                        .frame(width: 300)
//                        .background(Color.white)
//                    
//                    Text("444444444444")
//                        .font(.system(size: 20))
//                        .frame(height: 500)
//                        .background(Color.gray)
//                    
//                    Text("444444444444")
//                        .font(.system(size: 20))
//                        .frame(height: 300)
//                        .background(Color.red)
//                    
//                    Rectangle()
//                        .fill(.blue)
//                        .frame(width: 300, height: 300)
//                    
//                    Text("222")
//                        .background(Color.white)
//
//                }
//            }
//            .configurationSpacing(line: 5, item: 5)
//            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
//        }
    }
}

#Preview {
    ContentView()
}
