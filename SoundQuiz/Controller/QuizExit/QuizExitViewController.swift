//
//  QuizExitViewController.swift
//  SoundQuiz
//
//  Created by koala panda on 2023/03/29.
//

import UIKit
import Lottie
import AVFoundation

class QuizExitViewController: UIViewController {
    private var audioPlayer: AVAudioPlayer?
    
    @IBOutlet private var titleLabel: UILabel! {
        didSet {
            titleLabel.text = "\(scoreCountModel.scoreCount.description)点/100点"
        }
    }
    @IBOutlet private var continueButton: UIButton!
    
    @IBOutlet private weak var animationContainerView: UIView!

    private var animationView = LottieAnimationView()
    
    static func makeFromStoryboard(scoreCountModel: ScoreCountModel) -> QuizExitViewController {
        let vc = UIStoryboard(name: "QuizExit", bundle: nil).instantiateInitialViewController() as! QuizExitViewController
        vc.scoreCountModel = scoreCountModel

        return vc
    }
    private var scoreCountModel = ScoreCountModel()

    @IBAction func continueGame(_ sender: Any) {
        Router.shared.showReStart()

    }
    func lottiAnimation() {
        var animetionName = "4329-confetti"
        if scoreCountModel.scoreCount > 70 {
            animetionName = "4329-confetti"
        }else if scoreCountModel.scoreCount > 50 {
            animetionName = "31992-game-speak"
        } else {
            animetionName = "56450-game-over"
        }
        guard let animation = LottieAnimation.named(animetionName, subdirectory: nil)
        else {
            print("\(#line) file not found")
            return
        }
        animationContainerView.addSubview(animationView)
        animationView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: animationContainerView.heightAnchor),
            animationView.leadingAnchor.constraint(equalTo: animationContainerView.leadingAnchor),
            animationView.trailingAnchor.constraint(equalTo: animationContainerView.trailingAnchor),
            animationView.bottomAnchor.constraint(equalTo: animationContainerView.bottomAnchor),
        ])
        animationView.contentMode = .scaleAspectFit
        animationView.animation = animation
        animationView.play(fromProgress: 0, toProgress: 1, loopMode: .loop)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        lottiAnimation()
        setAudio(from: "Nocturne")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.audioPlay()
        }


    }
    func setAudio(from: String) {
        guard let url = Bundle.main.url(forResource: from, withExtension: "mp3") else { return }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.delegate = self
            audioPlayer?.prepareToPlay()
        } catch let error {
            print(error.localizedDescription)
        }
    }

    func audioPlay() {
        audioPlayer?.play()
    }
}
extension QuizExitViewController: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            print("再生終了")
        }
    }
}
