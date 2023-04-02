//
//  QuizExitViewController.swift
//  SoundQuiz
//
//  Created by koala panda on 2023/03/29.
//

import UIKit
import Lottie

class QuizExitViewController: UIViewController {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var continueButton: UIButton!
    
    @IBOutlet weak var animationContainerView1: UIView!
    private var animationView1 = LottieAnimationView()
    
    
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
        
        guard let animation = LottieAnimation.named("4329-confetti", subdirectory: nil)
        else {
            print("\(#line) file not found")
            return
        }
        animationContainerView1.addSubview(animationView1)
        animationView1.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
                animationView1.heightAnchor.constraint(equalTo: animationContainerView1.heightAnchor),
                animationView1.leadingAnchor.constraint(equalTo: animationContainerView1.leadingAnchor),
                animationView1.trailingAnchor.constraint(equalTo: animationContainerView1.trailingAnchor),
                animationView1.bottomAnchor.constraint(equalTo: animationContainerView1.bottomAnchor),
            ])
        animationView1.contentMode = .scaleAspectFit
        animationView1.animation = animation
        animationView1.play(fromProgress: 0, toProgress: 1, loopMode: .loop)
       
    }
    


}
