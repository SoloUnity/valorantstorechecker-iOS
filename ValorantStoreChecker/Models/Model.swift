//
//  ContentView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-12-16.
//

import SwiftUI
import Combine

class Model: ObservableObject {
    @Published var showDetail: Bool = false
    @Published var selectedModal: Modal = .signIn
}

enum Modal: String {
    case signUp
    case signIn
}
