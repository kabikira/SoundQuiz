//
//  Roter.swift
//  SoundQuiz
//
//  Created by koala panda on 2023/03/29.
//

import UIKit

final class Router {
    static let shared: Router = .init()
    private init() {}
    
    private var window: UIWindow?
    func showRoot(window: UIWindow?) {
        
        if !UserDefaults.standard.bool(forKey: "logined") {
            let vc = StartUpViewController.makeFromStoryboard()
            let nav = UINavigationController(rootViewController: vc)
            window?.rootViewController = nav
        } else {
            let vc = SecondTimeViewController.makeFromStoryboard()
            let nav = UINavigationController(rootViewController: vc)
            window?.rootViewController = nav
        }
        window?.makeKeyAndVisible()
        self.window = window
    }
    func showStart(from: UIViewController) {
        let vc = StartUpViewController.makeFromStoryboard()
        show(from: from, next: vc)
    }
    func showSecondTime(from: UIViewController) {
        let vc = SecondTimeViewController.makeFromStoryboard()
        show(from: from, next: vc)
    }
    func showQuiz(from: UIViewController) {
        let vc = QuizViewController.makeFromStoryboard()
        show(from: from, next: vc)
    }
    func showQuizExit(from: UIViewController, scoreCountModel: ScoreCountModel) {
        let vc = QuizExitViewController.makeFromStoryboard(scoreCountModel: scoreCountModel)
        show(from: from, next: vc)
    }
    func showReStart() {
        //        UserDefaults.standard.set(false, forKey: "logined")
        // 最初から画面を構築しなおす
        showRoot(window: window)
    }
    func ResetGame() {
        UserDefaults.standard.set(false, forKey: "logined")
        // 最初から画面を構築しなおす
        showRoot(window: window)
    }
}

private extension Router {
    func show(from: UIViewController, next: UIViewController, animated: Bool = true) {
        if let nav = from.navigationController {
            nav.pushViewController(next, animated: animated)
        } else {
            from.present(next, animated: animated, completion: nil)
        }
    }
}
