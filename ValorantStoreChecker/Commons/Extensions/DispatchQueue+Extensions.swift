//
//  DispatchQueue+Extensions.swift
//  ValorantStoreChecker
//
//  Created by Gordon on 2022-09-18.
//

import Foundation

typealias Dispatch = DispatchQueue

extension Dispatch {

    static func background(_ task: @escaping () -> ()) {
        Dispatch.global(qos: .background).async {
            task()
        }
    }

    static func main(_ task: @escaping () -> ()) {
        Dispatch.main.async {
            task()
        }
    }
}
