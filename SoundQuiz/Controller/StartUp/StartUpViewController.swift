//
//  StartUpViewController.swift
//  SoundQuiz
//
//  Created by koala panda on 2023/03/29.
//

import UIKit
import AVFoundation

class StartUpViewController: UIViewController {
    private var audioPlayer: AVAudioPlayer?

    @IBOutlet private weak var doneButton: UIButton!


    static func makeFromStoryboard() -> StartUpViewController {
        let vc = UIStoryboard(name: "StartUp", bundle: nil).instantiateInitialViewController() as! StartUpViewController
        return vc
    }
    @IBAction func goNext(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: "logined")
        audioPlay()
        doneButton.isEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            Router.shared.showSecondTime(from: self)
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        setAudio(from: "get_se")

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
extension StartUpViewController: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            print("再生終了:SecondTimeViewController")
        }
    }

}
