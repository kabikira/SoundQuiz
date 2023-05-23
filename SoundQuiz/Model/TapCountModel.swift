//
//  TapCount.swift
//  SoundQuiz
//
//  Created by koala panda on 2023/05/22.
//

import Foundation

struct TapCountModel {
    var count: Int = 1

    mutating func countUp() {
        self.count += 1
    }
}
