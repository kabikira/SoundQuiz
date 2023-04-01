//
//  SecondTimeViewController.swift
//  SoundQuiz
//
//  Created by koala panda on 2023/03/29.
//

import UIKit
import AVFoundation

class SecondTimeViewController: UIViewController, AVAudioPlayerDelegate {
    var audioPlayer: AVAudioPlayer?

    static func makeFromStoryboard() -> SecondTimeViewController {
        let vc = UIStoryboard(name: "SecondTime", bundle: nil).instantiateInitialViewController() as! SecondTimeViewController
        return vc
    }
    
    
    @IBAction func goNext(_ sender: Any) {
        audioPlay()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            //ここに処理
            Router.shared.showQuiz(from: self)
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        setAudio(from: "Start")
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(setting))
    }
    @objc func setting() {
        let ac = UIAlertController(title: "アプリの説明を見ますか？", message: "`はい`を選ぶと説明画面にうつります", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "はい", style: .default) { _ in
            Router.shared.ResetGame()
        })
        ac.addAction(UIAlertAction(title: "いいえ", style: .cancel))
        present(ac, animated: true)
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
    
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            print("再生終了:SecondTimeViewController")
        }
    }

}
