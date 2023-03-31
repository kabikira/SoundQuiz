//
//  SecondTimeViewController.swift
//  SoundQuiz
//
//  Created by koala panda on 2023/03/29.
//

import UIKit

class SecondTimeViewController: UIViewController {

    static func makeFromStoryboard() -> SecondTimeViewController {
        let vc = UIStoryboard(name: "SecondTime", bundle: nil).instantiateInitialViewController() as! SecondTimeViewController
        return vc
    }
    
    
    @IBAction func goNext(_ sender: Any) {
        Router.shared.showQuiz(from: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        
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

   

}
