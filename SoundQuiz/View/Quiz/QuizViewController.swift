//
//  QuizViewController.swift
//  SoundQuiz
//
//  Created by koala panda on 2023/03/29.
//

import UIKit
import AVFoundation

class QuizViewController: UIViewController, AVAudioPlayerDelegate {
    @IBOutlet var anserButton1: UIButton!
    @IBOutlet var anserButton2: UIButton!
    @IBOutlet var anserButton3: UIButton!
    
    @IBOutlet var numberOfProblems: UILabel!
    
    var countries = [String]()
    var correctAnswer = 0
    var score = 0
    var tapCount = 0
    var audioPlayer: AVAudioPlayer?
    
    static func makeFromStoryboard() -> QuizViewController {
        let vc = UIStoryboard(name: "Quiz", bundle: nil).instantiateInitialViewController() as! QuizViewController
        return vc
    }
    
    override func viewDidLoad() {
        print("a")
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        
        anserButton1.tag = 0
        anserButton2.tag = 1
        anserButton3.tag = 2
        
        countries += ["ド", "レ", "ミ", "ファ", "ソ", "ラ", "シ"]
        askQuestion(action: nil)
        
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        audioPlay()
//    }
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
    
    func askQuestion(action: UIAlertAction!) {
        transformLabel()
        countries.shuffle()
        anserButton1.setTitle(countries[0], for: .normal)
        anserButton2.setTitle(countries[1], for: .normal)
        anserButton3.setTitle(countries[2], for: .normal)
        correctAnswer = Int.random(in: 0...2)
        print("本当の答え:\(countries[correctAnswer])")
        setAudio(from: countries[correctAnswer])
        audioPlay()
        
    }
    @IBAction func buttonTapped(_ sender: UIButton) {
        
        if sender.tag == correctAnswer {
            print("正解:音出す")
            // 正解のアニメだす
            setAudio(from: "Answer")
            audioPlay()
            
            let ac = UIAlertController(title: "正解", message: "Your score is \(score).", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            present(ac, animated: true)
            score += 1
            
        } else {
            print("不正解:音出す")
            // 不正解のアニメだす
            setAudio(from: "Buzzer")
            audioPlay()
            let ac = UIAlertController(title: "不正解", message: "Your score is \(score).", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
            present(ac, animated: true)
        }
    }

    
    @IBAction func soundPlay(_ sender: Any) {
        setAudio(from: countries[correctAnswer])
        audioPlay()
    }
    
    func transformLabel() {
        UIView.animate(withDuration: 1, animations: {
            self.numberOfProblems.transform = CGAffineTransform(scaleX: 3, y: 3)
        }, completion: { _ in
            UIView.animate(withDuration: 1, animations: {
                self.numberOfProblems.transform = .identity
            })
        })
                       
    }
    
    func audioPlay() {
        audioPlayer?.play()
    }
    
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            print("再生終了:答え\(countries[correctAnswer])")
        }
    }
    
}
