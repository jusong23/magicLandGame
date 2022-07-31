//
//  ViewController.swift
//  Thread_Example_Project
//
//  Created by 김우성 on 2021/07/09.
//

import UIKit

enum TimerStatus {
    case start
    case end
}

class ViewController: UIViewController {

    var numB: Int = 0
    var numC: Int = 0
    var numS: Int = 0

    @IBOutlet weak var testLaaaabel: UILabel!
    
    var BakeryTimer: DispatchSourceTimer?
    var CoffeeTimer: DispatchSourceTimer?
    var SmoothieTimer: DispatchSourceTimer?
    var MainTimer: DispatchSourceTimer?
    var wellComeGuestTimer: DispatchSourceTimer?
    var guestDataModel = GuestDataModel ()
    var completeOrder:[Int] = []
    var sumOfToday:[Int] = []

    var sumOfBakery:Int = 0
    var sumOfCoffee:Int = 0
    var sumOfSmoothie:Int = 0
    
    
    
    @IBOutlet weak var sumOfToday_label: UILabel!
    @IBOutlet weak var priceOfBakery: UILabel!
    @IBOutlet weak var prcieOfCoffee: UILabel!
    @IBOutlet weak var priceOfSmoothie: UILabel!
    
    @IBOutlet weak var tapComplete: UIButton!
    @IBOutlet weak var firstOrder_Bakery: UILabel!
    @IBOutlet weak var firstOrder_Coffee: UILabel!
    @IBOutlet weak var firstOrder_Smoothie: UILabel!

    @IBOutlet weak var bakeryTime: UILabel!
    @IBOutlet weak var coffeeTime: UILabel!
    @IBOutlet weak var smoothieTime: UILabel!
    
    @IBOutlet weak var numOfBakery: UILabel!
    @IBOutlet weak var numOfCoffee: UILabel!
    @IBOutlet weak var numOfSmoothie: UILabel!
    
    @IBOutlet weak var mainTimeLabel: UILabel!
    @IBOutlet weak var tapBakery: UIButton!
    @IBOutlet weak var tapCoffee: UIButton!
    @IBOutlet weak var tapSmoothie: UIButton!
 
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func wellComeGuest() {
        if self.wellComeGuestTimer == nil{
            self.wellComeGuestTimer = DispatchSource.makeTimerSource(flags: [], queue: .main)
            self.wellComeGuestTimer?.schedule(deadline: .now(), repeating: 3) // 타이머의 주기 설정 메소드
            self.wellComeGuestTimer?.setEventHandler(handler: { [weak self] in
                guard let self = self else { return }
                if self.guestDataModel.arrayGuestStruct.count < 3 {
                    print("손님이 3명 이하이니 추가")
                    var numberOfBakery = Int(arc4random_uniform(3)+1)
                    var numberOfCoffee  = Int(arc4random_uniform(3)+1)
                    var numberOfSmoothie = Int(arc4random_uniform(3)+1)

                    self.guestDataModel.inputData(Bakery: numberOfBakery, Coffee: numberOfCoffee, Smoothie: numberOfSmoothie)
                    
                    self.firstOrder_Bakery.text? = String(self.guestDataModel.arrayGuestStruct[0].Bakery ?? 0)
                    self.firstOrder_Coffee.text = String(self.guestDataModel.arrayGuestStruct[0].Coffee ?? 0)
                    self.firstOrder_Smoothie.text = String(self.guestDataModel.arrayGuestStruct[0].Smoothie ?? 0)
                }
            })
        }
        self.wellComeGuestTimer?.resume()
    }
    
    func preventComeGuest() {
        self.wellComeGuestTimer?.cancel()
        self.wellComeGuestTimer = nil
    }
    
    // 손님 3초에 한번씩 오게 손님은 종류별로 각각 1개 이상씩 주문할 것임 갯수는 랜덤
    
    func onButton() {
        self.tapBakery.isEnabled = true
        self.tapCoffee.isEnabled = true
        self.tapSmoothie.isEnabled = true
    }
    
    @IBAction func go(_ sender: Any) {
        self.onButton()
        DispatchQueue.global(qos: .userInteractive).async {
            self.wellComeGuest()
        }
        DispatchQueue.global(qos: .userInteractive).async {
            var RestrictTime:Int = 60
            if self.MainTimer == nil{
                self.MainTimer = DispatchSource.makeTimerSource(flags: [], queue: .main)
                self.MainTimer?.schedule(deadline: .now(), repeating: 1) // 타이머의 주기 설정 메소드
                self.MainTimer?.setEventHandler(handler: { [weak self] in
                    guard let self = self else { return }
                    RestrictTime -= 1
                    self.mainTimeLabel.text = String(RestrictTime)
                    
                    if RestrictTime == 0 {
                        self.stopMainTimer()
                    }
                    
                    if self.completeOrder.count == 3 {
                        self.tapComplete.isEnabled = true
                    }
                })
            }
            self.MainTimer?.resume()
        }
    }

    
    func stopMainTimer() {
        self.tapBakery.isEnabled = false
        self.stopBakeryTimer()
        self.tapCoffee.isEnabled = false
        self.stopCoffeeTimer()
        self.tapSmoothie.isEnabled = false
        self.stopSmoothieTimer()
        self.preventComeGuest()
        
        self.MainTimer?.cancel()
        self.MainTimer = nil
        self.mainTimeLabel.text = "끝"
    }

    @IBAction func tapBakery(_ sender: Any) {
        self.tapBakery.isEnabled = false
        
        DispatchQueue.global().async {
            self.bakeryTimer()
        }
        
        DispatchQueue.global().async {
            for i in 0...100 {
                DispatchQueue.main.async {
                    self.testLaaaabel.text = String(i)
                }
                usleep(1000000)
            }
        }
    } // global 위에 main 쓰레드를 올려둠으로써 두개의 main 스레드를 동시에 관리할 수 있음 -- 애니메이션 넣기 & escaping closure 활용
    
    @IBAction func tapCoffee(_ sender: Any) {
        self.tapCoffee.isEnabled = false
        coffeeTimer()
    }
    
    @IBAction func tapSmoothie(_ sender: Any) {
        self.tapSmoothie.isEnabled = false
        smoothieTimer()
    }
    
    @IBAction func CompleteOrder(_ sender: Any) {
        print("주문완료")
        self.sumOfToday.append(sumOfBakery + sumOfCoffee + sumOfSmoothie)
        
        print("판매건수 : \(self.sumOfToday.count)")
        var total = self.sumOfToday.reduce(0, { x, y in
            x + y
        })
        print("매출 : \(total)")
        self.sumOfToday_label.text = String(total)
        
        self.completeOrder.removeAll()
        
        self.numOfBakery.text = "0"
        self.numOfCoffee.text = "0"
        self.numOfSmoothie.text = "0"
        
        self.numB = 0
        self.numC = 0
        self.numS = 0
        
        self.numOfBakery.textColor = .black
        self.numOfCoffee.textColor = .black
        self.numOfSmoothie.textColor = .black

        self.tapBakery.isEnabled = true
        self.tapCoffee.isEnabled = true
        self.tapSmoothie.isEnabled = true
    
        self.guestDataModel.removeData() // 첫번째꺼 지워짐, 3초마다 한번 씩 추가 됨
    
        self.firstOrder_Bakery.text = String(self.guestDataModel.arrayGuestStruct[0].Bakery ?? 0)
        self.firstOrder_Coffee.text = String(self.guestDataModel.arrayGuestStruct[0].Coffee ?? 0)
        self.firstOrder_Smoothie.text = String(self.guestDataModel.arrayGuestStruct[0].Smoothie ?? 0)
            
        self.priceOfBakery.text = "0"
        self.prcieOfCoffee.text = "0"
        self.priceOfSmoothie.text = "0"

        self.sumOfBakery = 0
        self.sumOfCoffee = 0
        self.sumOfSmoothie = 0
        
        self.tapComplete.isEnabled = false
    }

    
    
    
//MARK: - BAKERY

    func bakeryTimer() {
        if self.BakeryTimer == nil{
            var makeTime: Int = 8
            self.BakeryTimer = DispatchSource.makeTimerSource(flags: [], queue: .main)
            self.BakeryTimer?.schedule(deadline: .now(), repeating: 1) // 타이머의 주기 설정 메소드
            self.BakeryTimer?.setEventHandler(handler: { [weak self] in
                guard let self = self else { return }
                makeTime -= 1
                self.bakeryTime.text = String(makeTime)
//                print("베이커리 : \(makeTime)초")
                if makeTime == 0 {
                    self.tapBakery.isEnabled = true
                    self.stopBakeryTimer()
                    self.numB += 1
                    self.numOfBakery.text = String(self.numB)
                    self.sumOfBakery = 5000 * self.numB
                    self.priceOfBakery.text = String(self.sumOfBakery)
                    if self.numB == self.guestDataModel.arrayGuestStruct[0].Bakery! {
                        print("베이커리 완료")
                        self.tapBakery.isEnabled = false
                        self.numOfBakery.textColor = .red
                        self.completeOrder.append(1)
                    }
                 
                }
            })
        }
        self.BakeryTimer?.resume()
    }
    
    func stopBakeryTimer() {
        self.BakeryTimer?.cancel()
        self.BakeryTimer = nil
    }
    
// MARK: - COFFEE
    
    func coffeeTimer() {
        if self.CoffeeTimer == nil{
            var makeTime: Int = 4
            self.CoffeeTimer = DispatchSource.makeTimerSource(flags: [], queue: .main)
            self.CoffeeTimer?.schedule(deadline: .now(), repeating: 1) // 타이머의 주기 설정 메소드
            self.CoffeeTimer?.setEventHandler(handler: { [weak self] in
                guard let self = self else { return }
                makeTime -= 1
                self.coffeeTime.text = String(makeTime)
                if makeTime == 0 {
                    self.tapCoffee.isEnabled = true
                    self.stopCoffeeTimer()
                    self.numC += 1
                    self.numOfCoffee.text = String(self.numC)
                    self.sumOfCoffee = 4000 * self.numC
                    self.prcieOfCoffee.text = String(self.sumOfCoffee)
                    if self.numC == self.guestDataModel.arrayGuestStruct[0].Coffee! {
                        print("커피 완료")
                        self.tapCoffee.isEnabled = false
                        self.numOfCoffee.textColor = .red
                        self.completeOrder.append(1)

                    }
                }
            })
        }
        self.CoffeeTimer?.resume()
    }

    func stopCoffeeTimer() {
        self.CoffeeTimer?.cancel()
        self.CoffeeTimer = nil
    }
    
//MARK: - SMOOTHIE
    
    func smoothieTimer() {
        if self.SmoothieTimer == nil{
            var makeTime: Int = 6
            self.SmoothieTimer = DispatchSource.makeTimerSource(flags: [], queue: .main)
            self.SmoothieTimer?.schedule(deadline: .now(), repeating: 1) // 타이머의 주기 설정 메소드
            self.SmoothieTimer?.setEventHandler(handler: { [weak self] in
                guard let self = self else { return }
                makeTime -= 1
                self.smoothieTime.text = String(makeTime)
                if makeTime == 1 {
                    self.tapSmoothie.isEnabled = true
                    self.stopSmoothieTimer()
                    self.numS += 1
                    self.numOfSmoothie.text = String(self.numS)
                    self.sumOfSmoothie = 3000 * self.numS
                    self.priceOfSmoothie.text = String(self.sumOfSmoothie)
                    if self.numS == self.guestDataModel.arrayGuestStruct[0].Smoothie! {
                        print("스무디 완료")
                        self.tapSmoothie.isEnabled = false
                        self.numOfSmoothie.textColor = .red
                        self.completeOrder.append(1)
                    }
                }
            })
        }
        self.SmoothieTimer?.resume()
    }
    
    func stopSmoothieTimer() {
        self.SmoothieTimer?.cancel()
        self.SmoothieTimer = nil
    }
    
        
//        didFinishDoSomething { result in
//            if result == 100 {
//                print("돈이 부족합니다.")
//            } else {
//                print("UI Update")
//            }
//        }
    
//    func didFinishDoSomething(onCompleted : @escaping (Int) -> Void) {
//        let result = 123 // <-- 100분
//        onCompleted(result)
//    }
} // @escaping는 주문 완료되었을 시에 그 다음 음료나가는 거 구현할 때 사용


