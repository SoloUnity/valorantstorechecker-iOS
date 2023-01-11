//
//  Styles.swift
//  JPDesignCode_iOS15
//
//  Created by 周健平 on 2022/5/23.
//

import SwiftUI

struct TitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.footnote.weight(.semibold))
            .foregroundColor(.secondary)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(20)
            .accessibilityAddTraits(.isHeader) // 声明该[可访问性]元素的类型（可作用于画外音的读取）
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(TitleModifier())
    }
}

struct StrokeModifier: ViewModifier {
    let cornerRadius: CGFloat
    let style: RoundedCornerStyle
    
    @Environment(\.colorScheme) var colorScheme
    
    func body(content: Content) -> some View {
        content
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius, style: style)
                    .stroke(
                        .linearGradient(
                            colors: [
                                .white.opacity(colorScheme == .dark ? 0.1 : 0.3),
                                .black.opacity(colorScheme == .dark ? 0.3 : 0.1)
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .blendMode(.overlay)
            )
    }
}

extension View {
    func strokeStyle(cornerRadius: CGFloat = 30, style: RoundedCornerStyle = .continuous) -> some View {
        modifier(StrokeModifier(cornerRadius: cornerRadius, style: style))
    }
}
