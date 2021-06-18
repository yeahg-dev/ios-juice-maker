//
//  JuiceMaker - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var strawberryLabel: UILabel!
    @IBOutlet weak var bananaLabel: UILabel!
    @IBOutlet weak var mangoLabel: UILabel!
    @IBOutlet weak var kiwiLabel: UILabel!
    @IBOutlet weak var pineappleLabel: UILabel!

    let juiceMaker = JuiceMaker()
    
    let strawberryJuice = Juice(name: "딸기쥬스", ingredients: [.strawberry:16])
    let bananaJuice = Juice(name: "바나나쥬스", ingredients: [.banana:2])
    let pineappleJuice = Juice(name: "파인애플쥬스", ingredients: [.pineapple:2])
    let kiwiJuice = Juice(name: "키위쥬스", ingredients: [.kiwi:3])
    let mangoJuice = Juice(name: "망고쥬스", ingredients: [.mango:3])
    let strawberryBananaJuice = Juice(name: "딸바쥬스", ingredients: [.strawberry:10, .banana:1])
    let mangoKiwiJuice = Juice(name: "망키쥬스", ingredients: [.mango:2, .kiwi:1])
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        NotificationCenter.default.addObserver(self, selector: #selector(alertMakingJuiceSuccess(_:)),
                                               name: Notification.Name(rawValue: "makeJuiceSuccess"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(alertMakingJuiceFail),
                                               name: Notification.Name(rawValue: "makeJuiceFail"), object: nil)
        
        for fruit in Fruit.allCases {
            
        }
    }
    
    @IBAction func strawberryJuiceOrder(_ sender: Any) {
        juiceMaker.makeJuice(strawberryJuice)
    }
    @IBAction func bananaJuiceOrder(_ sender: Any) {
        juiceMaker.makeJuice(bananaJuice)
    }
    @IBAction func mangoJuiceOrder(_ sender: Any) {
        juiceMaker.makeJuice(pineappleJuice)
    }
    @IBAction func kiwiJuiceOrder(_ sender: Any) {
        juiceMaker.makeJuice(kiwiJuice)
    }
    @IBAction func pineappleJuiceOrder(_ sender: Any) {
        juiceMaker.makeJuice(pineappleJuice)
    }
    @IBAction func strawberryBananaJuiceOrder(_ sender: Any) {
        juiceMaker.makeJuice(strawberryBananaJuice)
    }
    @IBAction func mangoKiwiJuiceOrder(_ sender: Any) {
        juiceMaker.makeJuice(mangoKiwiJuice)
    }
}

extension MainViewController {
    func updateUILabel(_ fruit: Fruit) {
        let currentStock = String(juiceMaker.fruitStore.currentStock(fruit))
        switch fruit {
        case .strawberry:
            strawberryLabel.text = currentStock
        case .banana:
            bananaLabel.text = currentStock
        case .pineapple:
            pineappleLabel.text = currentStock
        case .kiwi:
            kiwiLabel.text = currentStock
        case .mango:
            mangoLabel.text = currentStock
        }
    }
    @objc func alertMakingJuiceSuccess(_ notification: Notification) {
        guard let userInfo = notification.userInfo else {
            print("userInfo 에러"); return
        }
        guard let userInfoValue = userInfo["쥬스이름"], let juiceName = userInfoValue as? String else {
            print("userInfoValue 에러"); return
        }
        let alert = UIAlertController(title: "\(juiceName) 쥬스 나왔습니다! 맛있게 드세요!", message: nil, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "감사합니다.", style: .default) { _ in print("주문성공")}
        alert.addAction(confirmAction)
        present(alert, animated: true, completion: nil)
    }
    @objc func alertMakingJuiceFail() {
        let alert = UIAlertController(title: "재료가 모자라요. 재고를 수정할까요?", message: nil, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "예", style: .default){ _ in print("주문실패 - 예 선택")}
        let cancelAction = UIAlertAction(title: "아니오", style: .default){ _ in print("주문실패 - 아니오 선택")}
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
}
