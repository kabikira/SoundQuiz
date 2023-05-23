//
//  QuizViewController.swift
//  SoundQuiz
//
//  Created by koala panda on 2023/03/29.
//

import UIKit
import AVFoundation

class QuizViewController: UIViewController {
    @IBOutlet private var anserButton1: UIButton!
    @IBOutlet private var anserButton2: UIButton!
    @IBOutlet private var anserButton3: UIButton!
    
    @IBOutlet private var scoreLabel: UILabel!
    @IBOutlet private var numberOfProblems: UILabel!
    
    private var countries = ["ド", "レ", "ミ", "ファ", "ソ", "ラ", "シ"]
    private var correctAnswer = 0
    private var tapCount = TapCountModel()
    private var audioPlayer: AVAudioPlayer?
    private var questionCount = QuestionCountModel()
    private var scoreCountModel = ScoreCountModel()
    
    static func makeFromStoryboard() -> QuizViewController {
        let vc = UIStoryboard(name: "Quiz", bundle: nil).instantiateInitialViewController() as! QuizViewController
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(setting))
        
        anserButton1.tag = 0
        anserButton2.tag = 1
        anserButton3.tag = 2
        anserButton1.titleLabel?.font = .systemFont(ofSize: 60)

        askQuestion(action: nil)
        
    }
    
    func askQuestion(action: UIAlertAction!) {
        
        if questionCount.count == 10 {
            Router.shared.showQuizExit(from: self, scoreCountModel: scoreCountModel)
        } else {
            numberOfProblems.text = "第　\(tapCount.count.description)　問"
            scoreLabel.text = "スコア:\(scoreCountModel.scoreCount.description)/100"
            transformLabel()
            countries.shuffle()
            anserButton1.setTitle(countries[0], for: .normal)
            anserButton2.setTitle(countries[1], for: .normal)
            anserButton3.setTitle(countries[2], for: .normal)
            correctAnswer = Int.random(in: 0...2)
            print("答え:\(countries[correctAnswer])")
            setAudio(from: countries[correctAnswer])
            audioPlay()
        }
        
    }
    @IBAction func buttonTapped(_ sender: UIButton) {
        
        if sender.tag == correctAnswer {
            print("正解:")
            
            setAudio(from: "Answer")
            audioPlay()
            scoreCountModel.countUp()
            tapCount.countUp()
            questionCount.countUp()
            let ac = UIAlertController(title: "正解", message: "やったね！！", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            present(ac, animated: true)
            
        } else {
            print("不正解:")
            
            setAudio(from: "Buzzer")
            audioPlay()
            tapCount.countUp()
            questionCount.countUp()
            let ac = UIAlertController(title: "不正解", message: "答えは`\(countries[correctAnswer])`です！", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion(action:)))
            present(ac, animated: true)
        }
    }

    @objc func setting() {
        let ac = UIAlertController(title: "ゲームを中断してタイトルへ戻りますか?", message: "'はい'を選ぶとタイトル画面にうつります", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "はい", style: .default) { _ in
            Router.shared.showReStart()
        })
        ac.addAction(UIAlertAction(title: "いいえ", style: .cancel))
        present(ac, animated: true)
    }

    func transformLabel() {
        UIView.animate(withDuration: 0.5, animations: {
            self.numberOfProblems.transform = CGAffineTransform(scaleX: 2, y: 2)
        }, completion: { _ in
            UIView.animate(withDuration: 1.5, animations: {
                self.numberOfProblems.transform = .identity
            })
        })

    }

    
    @IBAction func soundPlay(_ sender: Any) {
        setAudio(from: countries[correctAnswer])
        audioPlay()
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
extension QuizViewController: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            print("再生終了:答え\(countries[correctAnswer])")
        }
    }
}

