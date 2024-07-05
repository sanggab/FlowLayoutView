//
//  FlowLayoutView.swift
//  GabFlowLayout
//
//  Created by Gab on 2024/07/03.
//

import SwiftUI

struct BoundsPreferenceKey: PreferenceKey {
    typealias Bounds = Anchor<CGRect>
    static var defaultValue = [Bounds]()

    static func reduce(
        value: inout [Bounds],
        nextValue: () -> [Bounds]
    ) {
        value.append(contentsOf: nextValue())
    }
}

public struct FlowLayoutView<Content: View>: View {
//    @StateObject private var viewModel: FlowLayoutViewModel<String> = .init()
    @ViewBuilder private var content: () -> Content
    
    private var axis: Axis
    
    private var configuration: FlowConfiguration = .zero
    
    public init(_ axis: Axis, @ViewBuilder content: @escaping () -> Content) {
        self.axis = axis
        self.content = content
    }
    
    public var body: some View {
        GeometryReader { proxy in
            var lineWidth: CGFloat = .zero
            var lineHeight: CGFloat = .zero
            
            var alignmentsSize: [CGSize] = []
            
            ZStack(alignment: .topLeading) {
                
                content()
                    .alignmentGuide(.leading) { d in
                        
                        var result: CGFloat = .zero
                        
                        switch axis {
                        case .horizontal:
                            print("horizontal leading")
                            
                            if abs(lineWidth) + d.width > proxy.size.width {
                                print("현재 라인에 못 담음")
                                let height: CGFloat = (alignmentsSize
                                                    .map{ $0.height }
                                                    .max() ?? d.height) + configuration.lineSpacing
                                
                                lineHeight = height
                                lineWidth = .zero
                                result = d[.leading]
                            } else {
                                print("현재 라인에 담을 수 있음")
                                result = lineWidth
                            }
                            
                            let width: CGFloat = d.width + configuration.itemSpacing
                            lineWidth -= width
                            
                            alignmentsSize.append(CGSize(width: width, height: lineHeight + d.height))
                            
                            return result
                            
                        case .vertical:
                            print("vertical leading")
                            
                            if abs(lineHeight) + d.height > proxy.size.height {
                                print("현재 라인에 못 담음")
                                let width: CGFloat = (alignmentsSize
                                                    .map{ $0.width }
                                                    .max() ?? d.width) + configuration.itemSpacing
                                
                                lineHeight = .zero
                                lineWidth -= width
                                result = lineWidth
                            } else {
                                print("현재 라인에 담을 수 있음")
                                
                                let height: CGFloat = d.height + configuration.lineSpacing
                                let width: CGFloat = d.width + configuration.itemSpacing
                                alignmentsSize.append(CGSize(width: abs(lineWidth) + width, height: height))
                                
                                result = lineWidth
                            }
                        }
                        
                        return result
                    }
                    .alignmentGuide(.top) { d in
                        switch axis {
                        case .horizontal:
                            print("horizontal top")
                            
                            return -lineHeight
                            
                        case .vertical:
                            print("vertical top")
                            
                            var result: CGFloat = .zero
                            
                            result -= lineHeight
                            
                            let height: CGFloat = d.height + configuration.lineSpacing
                            
                            lineHeight += height
                            
                            return result
                        }
                    }
                
                Color.clear
                    .frame(width: .zero, height: .zero)
                    .alignmentGuide(.leading, computeValue: { dimension in
                        
                        alignmentsSize = []
                        lineWidth = .zero
                        lineHeight = .zero
                        
                        return dimension[.leading]
                    })
                    .hidden()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.pink)
    }
}

public extension FlowLayoutView {
    
    func configurationSpacing(line: CGFloat = .zero, item: CGFloat = .zero) -> FlowLayoutView {
        var view = self
        view.configuration = FlowConfiguration(lineSpacing: line,
                                               itemSpacing: item)
        return view
    }
}

private extension Array {
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
