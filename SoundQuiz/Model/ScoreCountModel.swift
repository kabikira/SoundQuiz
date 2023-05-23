//
//  ScoreCounterModel.swift
//  SoundQuiz
//
//  Created by koala panda on 2023/03/31.
//

import Foundation
struct ScoreCountModel {
    var scoreCount: Int = 0

    mutating func countUp() {
        self.scoreCount += 10
    }
}
