//
//  AnimationExtension.swift
//  LifePal
//
//  Created by Shengyuan Lu on 5/29/23.
//

import Foundation
import SwiftUI

extension Animation {
    static func ripple() -> Animation {
        Animation.linear(duration: 0.5)
            .speed(1)
    }
}
