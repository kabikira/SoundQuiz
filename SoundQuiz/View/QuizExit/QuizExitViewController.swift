//
//  QuizExitViewController.swift
//  SoundQuiz
//
//  Created by koala panda on 2023/03/29.
//

import UIKit

class QuizExitViewController: UIViewController {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var continueButton: UIButton!
    static func makeFromStoryboard(scoreCountModel: ScoreCountModel) -> QuizExitViewController {
            let vc = UIStoryboard(name: "QuizExit", bundle: nil).instantiateInitialViewController() as! QuizExitViewController
        vc.scoreCountModel = scoreCountModel
        
            return vc
        }
    private var scoreCountModel = ScoreCountModel(scoreCount: 0)
    // いらんかもメモリ食うからリセットした方がいいかな
    @IBAction func continueGame(_ sender: Any) {
        Router.shared.showReStart()
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        titleLabel.text = "\(scoreCountModel.scoreCount.description)点/100点"

        // Do any additional setup after loading the view.
    }
    


}
