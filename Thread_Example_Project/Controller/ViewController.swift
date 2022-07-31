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

    // SingleTon
    var myMoney: Int = 100 // -5
    
    var BakeryTimer: DispatchSourceTimer?
    var CoffeeTimer: DispatchSourceTimer?
    var SmoothieTimer: DispatchSourceTimer?
    var MainTimer: DispatchSourceTimer?
    var wellComeGuestTimer: DispatchSourceTimer? // 몇 초 뒤에 특정 작업을 수행 할 수 있음
    // GCD : 작업을 병렬적으로 실행
    
    var guestDataModel = GuestDataModel ()
    
    @IBOutlet weak var mainTimeLabel: UILabel!
    @IBOutlet weak var tapBakery: UIButton!
    @IBOutlet weak var tapCoffee: UIButton!
    @IBOutlet weak var tapSmoothie: UIButton!
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
//        setupData01()
//        setupData02()
//        setupData03()
    }
    
// intermidate GCD, COVID esapin
// DispatchQueue 쓰기

//MARK: - wellComeGuest
    
    func wellComeGuest() {
        var wellComeGuest = self.guestDataModel.numberOfGuest()

        if self.wellComeGuestTimer == nil{
            self.wellComeGuestTimer = DispatchSource.makeTimerSource(flags: [], queue: .main)
            // queue : 어떤 스레드에서할지! but UI작업이니 main 스레드(interface thread)로 설정해줘야함!
            // 안그러면 네트워크랑 같이 백그라운드에서 같이 돌면서 오류남
            self.wellComeGuestTimer?.schedule(deadline: .now(), repeating: 3) // 타이머의 주기 설정 메소드
            self.wellComeGuestTimer?.setEventHandler(handler: { [weak self] in
                // 그냥 self.로 설정해두면 handler 안의 값들이 계속 돌아갈 것이므로 메모리누수. weak self를 통해 일시적으로 사용할 때에만 self가 돌아가도록 설정 -> self?.timer 이런식으로 써야함
                guard let self = self else { return }
                // 일시적으로 self를 Strong Refernce만들어 타이머가 실행할 때에 쓰이는 self. 는 확실하게 있음을 보장, 즉 Controller에 타이머가 있든 없든 상관없이 이 안에서 쓰일때 만큼은 있으므로 self?. 안써도 됨
                if wellComeGuest < 3 {
                    var numberOfBakery = Int(arc4random_uniform(6)+1)
                    var numberOfCoffee  = Int(arc4random_uniform(6)+1)
                    var numberOfSmoothie = Int(arc4random_uniform(6)+1)
//                    print(numberOfBakery)
                    print("현재 손님 수 : \(wellComeGuest)")
                    print("손님이 3명 이하이니 추가")
                    self.guestDataModel.inputData(Bakery: 1, Coffee: 1, Smoothie: 1)
                }
            })
        }
        self.wellComeGuestTimer?.resume()
    } // 주문 시작 버튼
    
    func preventComeGuest() {
        self.wellComeGuestTimer?.cancel()
        self.wellComeGuestTimer = nil
    }
    
    // 손님 3초에 한번씩 오게 손님은 종류별로 각각 1개 이상씩 주문할 것임 갯수는 랜덤
    
//MARK: - GameStart
    
    @IBAction func go(_ sender: Any) {
        DispatchQueue.global(qos: .userInteractive).async {
            self.wellComeGuest() // 이 타이머랑 이 타이머를
        }
        
        DispatchQueue.global(qos: .userInteractive).async {
            var RestrictTime:Int = 30
            if self.MainTimer == nil{
                self.MainTimer = DispatchSource.makeTimerSource(flags: [], queue: .main)
                self.MainTimer?.schedule(deadline: .now(), repeating: 1) // 타이머의 주기 설정 메소드
                self.MainTimer?.setEventHandler(handler: { [weak self] in
                    guard let self = self else { return }
                    RestrictTime -= 1
                    self.mainTimeLabel.text = String(RestrictTime)
                    
                    if self.BakeryTimer == nil {
                        DispatchQueue.global(qos: .userInitiated).async {
                            self.bakeryTimer() // 0 -> 100
                        }
                    }
                    
                    if self.CoffeeTimer == nil {
                        DispatchQueue.global(qos: .userInitiated).async {
                            self.coffeeTimer() // 100 -> 0
                        }
                    }

                    if self.SmoothieTimer == nil {
                        DispatchQueue.global(qos: .userInitiated).async {
                            self.smoothieTimer() // 100 -> 0
                        }   
                    }
                    
                    if RestrictTime == 1 {
                        self.stopMainTimer()
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
        self.mainTimeLabel.text = "00:00:00"
    }
    
//    /// 2. 데이터가 섞여서 나타나는 경우
//    private func setupData02() {
//
//        DispatchQueue.global(qos: .userInitiated).async {
//            self.bakeryTimer() // 0 -> 100
//        }
//
//        DispatchQueue.global(qos: .userInitiated).async {
//            self.coffeeTimer() // 100 -> 0
//        }
//
//        DispatchQueue.global(qos: .userInitiated).async {
//            self.smoothieTimer() // 100 -> 0
//        }
//    }
//
    @IBAction func tapBakery(_ sender: Any) {
        self.tapBakery.isEnabled = false
        bakeryTimer()
    }
    
    @IBAction func tapCoffee(_ sender: Any) {
        self.tapCoffee.isEnabled = false
        coffeeTimer()
    }
    
    @IBAction func tapSmoothie(_ sender: Any) {
        self.tapSmoothie.isEnabled = false
        smoothieTimer()
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
                print("베이커리 : \(makeTime)초")
                if makeTime == 1 {
                    self.tapBakery.isEnabled = true
                    self.stopBakeryTimer()
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
                print("커피 : \(makeTime)초")
                if makeTime == 1 {
                    self.tapCoffee.isEnabled = true
                    self.stopCoffeeTimer()
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
                print("스무디 : \(makeTime)초")
                if makeTime == 1 {
                    self.tapSmoothie.isEnabled = true
                    self.stopSmoothieTimer()
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


