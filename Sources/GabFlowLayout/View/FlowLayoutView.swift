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
            var currentLineWidth: CGFloat = .zero
            var alignmentsSize: [CGSize] = []
            var maxHeight: CGFloat = .zero
            var index: Int = .zero
            
            ZStack(alignment: .topLeading) {
                content()
                    .alignmentGuide(.leading) { d in
                        switch axis {
                        case .horizontal:
                            print("horizontal leading")
                            print("index : \(index)")
                            
                            var result: CGFloat = .zero
                            
                            if abs(currentLineWidth) + d.width > proxy.size.width {
                                print("넘엉")
                            } else {
                                print("안넘엉")
                                if index == .zero {
                                    
                                    let width: CGFloat = d.width + configuration.itemSpacing
                                    currentLineWidth -= width
                                    alignmentsSize.append(CGSize(width: currentLineWidth, height: d.height))
                                    
                                    result = d[.leading]
                                    
                                } else {
                                    
                                    let width: CGFloat = d.width + configuration.itemSpacing
                                    currentLineWidth -= width
                                    alignmentsSize.append(CGSize(width: currentLineWidth, height: d.height))
                                    
                                    result = alignmentsSize[safe: index - 1]?.width ?? -width
                                }
                            }
                            
                            print("result: \(result)")
                            
                            return result
                            
                        case .vertical:
                            print("vertical leading")
                        }
                        
                        return d[.leading]
                    }
                    .alignmentGuide(.top) { d in
                        switch axis {
                        case .horizontal:
                            print("horizontal top")
                            
                        case .vertical:
                            print("vertical top")
                        }
                        
                        index += 1
                        
                        return d[.top]
                    }
                
                Color.clear
                    .frame(width: .zero, height: .zero)
                    .alignmentGuide(.leading, computeValue: { dimension in
                        print("hoho")
                        
                        currentLineWidth = .zero
                        maxHeight = .zero
                        index = .zero
                        
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
