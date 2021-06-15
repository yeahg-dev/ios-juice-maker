//
//  JuiceMaker - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {
    private var juiceMaker: JuiceMaker!
    private var labelList = [Fruit: UILabel]()
    // MARK: - IBOutlet
    @IBOutlet weak var strawberryBananaJuiceButton: UIButton!
    @IBOutlet weak var mangoKiwiJuiceButton: UIButton!
    @IBOutlet weak var strawberryJuiceButton: UIButton!
    @IBOutlet weak var bananaJuiceButton: UIButton!
    @IBOutlet weak var pineappleJuiceButton: UIButton!
    @IBOutlet weak var kiwiJuiceButton: UIButton!
    @IBOutlet weak var mangoJuiceButton: UIButton!
    
    @IBOutlet weak var strawberryLabel: UILabel!
    @IBOutlet weak var bananaLabel: UILabel!
    @IBOutlet weak var pineappleLabel: UILabel!
    @IBOutlet weak var kiwiLabel: UILabel!
    @IBOutlet weak var mangoLabel: UILabel!
    
    // MARK: - Method
    override func viewDidLoad() {
        super.viewDidLoad()
        let fruitStore = FruitStore()
        juiceMaker = JuiceMaker(fruitStore: fruitStore)
        initLabelList()
        initLabelsText(of: fruitStore)
    }
    
    func initLabelList() {
        labelList[.strawberry] = strawberryLabel
        labelList[.banana] = bananaLabel
        labelList[.pineapple] = pineappleLabel
        labelList[.kiwi] = kiwiLabel
        labelList[.mango] = mangoLabel
    }
    
    func initLabelsText(of fruitStore: FruitStore) {
        do {
            let fruitList = Fruit.makeFruitList()
            for fruit in fruitList {
                let fruitStock = try fruitStore.getStocks(of: fruit)
                if let uiLabel = labelList[fruit] {
                    uiLabel.text = "\(fruitStock)"
                }
            }
        } catch {
            
        }
    }
    
    func showAlert(title: String?, message: String?) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default)
        
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func showConfirm(title: String?, message: String?, yesHandler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "예", style: .default, handler: yesHandler)
        let noAction = UIAlertAction(title: "아니오", style: .cancel)
        
        alert.addAction(yesAction)
        alert.addAction(noAction)
        present(alert, animated: true)
    }
    
    func orderJuice(of juice: Juice) {
        showConfirm(title: "재고 부족", message: "재료가 모자라요. 재고를 수정할까요?" , yesHandler: { _ in
            guard let uvc = self.storyboard?.instantiateViewController(withIdentifier: "StockManagerNC") else {
                return
            }
            
            self.present(uvc, animated: true)
        })
    }
    
    // MARK: - IBAction
    @IBAction func orderStrawberryBananaJuice(_ sender: UIButton) {
        orderJuice(of: .strawberryBanana)
    }
    
    @IBAction func orderMangoKiwiJuice(_ sender: UIButton) {
        orderJuice(of: .mangoKiwi)
    }
    
    @IBAction func orderStrawberryJuice(_ sender: UIButton) {
        orderJuice(of: .strawberry)
    }
    
    @IBAction func orderBananaJuice(_ sender: UIButton) {
        orderJuice(of: .banana)
    }
    
    @IBAction func orderPineappleJuice(_ sender: UIButton) {
        orderJuice(of: .pineapple)
    }
    
    @IBAction func orderKiwiJuice(_ sender: UIButton) {
        orderJuice(of: .kiwi)
    }
    
    @IBAction func orderMangoJuice(_ sender: UIButton) {
        orderJuice(of: .mango)
    }
}
