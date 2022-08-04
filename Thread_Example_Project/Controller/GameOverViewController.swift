//
//  GameOverViewController.swift
//  Thread_Example_Project
//
//  Created by 이주송 on 2022/08/04.
//

import UIKit

class GameOverViewController: UIViewController {

    @IBOutlet weak var sumSELL: UILabel!
    var SELL: String?
    
    @IBOutlet weak var sumCount: UILabel!
    var Count: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let pushedSELL = SELL {
             self.sumSELL.text = pushedSELL
         }
        if let pushedCount = Count {
             self.sumCount.text = pushedCount
         }
    }
    
    
}
