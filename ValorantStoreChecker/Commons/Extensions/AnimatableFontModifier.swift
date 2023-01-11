//
//  AnimatableFontModifier.swift
//  JPDesignCode_iOS15
//
//  Created by 周健平 on 2022/6/8.
//

import SwiftUI

struct AnimatableFontModifier: AnimatableModifier {
    var size: Double
    let weight: Font.Weight
    let design: Font.Design
    
    var animatableData: Double {
        set { size = newValue }
        get { size }
    }
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: size, weight: weight, design: design))
    }
}

extension View {
    func animatableFont(size: CGFloat,
                        weight: Font.Weight = .regular,
                        design: Font.Design = .default) -> some View {
        modifier(AnimatableFontModifier(size: size, weight: weight, design: design))
    }
}
