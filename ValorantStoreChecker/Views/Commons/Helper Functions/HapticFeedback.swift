//
//  HapticFeedback.swift
//  ValorantStoreChecker
//
//  Created by Gordon on 2022-12-28.
//

import Foundation
import SwiftUI

func haptic() {
    let impactMed = UIImpactFeedbackGenerator(style: .soft)
    impactMed.impactOccurred()
}
