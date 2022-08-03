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

   var guests:[String] = ["스크린샷_2022-08-03_16.44.53-removebg-preview.png",
                           "스크린샷_2022-08-03_16.49.31-removebg-preview.png",
                           "스크린샷_2022-08-03_16.50.17-removebg-preview.png"
                            ]
    
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
        
    @IBOutlet weak var foodNameStackView: UIStackView!
    @IBOutlet weak var foodCountStackView: UIStackView!
    
    @IBOutlet weak var waitingStackView: UIStackView!
    
    @IBOutlet weak var guestImage: UIImageView!
    
    @IBOutlet weak var waiting: UILabel!
    
    @IBOutlet weak var nickName: UILabel!
    var name: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.setValue(1, forKey: "LOGINED")
        self.navigationController?.navigationBar.isHidden = true
        if let codePresentName = name {
            self.nickName.text = codePresentName
        }
    }
    
    
    @IBOutlet weak var gameStart: UIButton!
    @IBOutlet weak var wellcomeStackView: UIStackView!
    
    @IBOutlet weak var cornImage: UIImageView!
    @IBOutlet weak var starberryImage: UIImageView!
    @IBOutlet weak var potatoImage: UIImageView!
        
    @IBOutlet weak var cornPrograssView: UIProgressView!
    @IBOutlet weak var starberryPrograssView: UIProgressView!
    @IBOutlet weak var potatoPrograssView: UIProgressView!
    
    @IBOutlet weak var sumOfToday_label: UILabel!
    @IBOutlet weak var priceOfBakery: UILabel!
    @IBOutlet weak var prcieOfCoffee: UILabel!
    @IBOutlet weak var priceOfSmoothie: UILabel!
    
    @IBOutlet weak var tapComplete: UIButton!
    @IBOutlet weak var firstOrder_Bakery: UILabel!
    @IBOutlet weak var firstOrder_Coffee: UILabel!
    @IBOutlet weak var firstOrder_Smoothie: UILabel!

//    @IBOutlet weak var bakeryTime: UILabel!
//    @IBOutlet weak var coffeeTime: UILabel!
//    @IBOutlet weak var smoothieTime: UILabel!
    
    @IBOutlet weak var numOfBakery: UILabel!
    @IBOutlet weak var numOfCoffee: UILabel!
    @IBOutlet weak var numOfSmoothie: UILabel!
    
    @IBOutlet weak var mainTimeLabel: UILabel!
    @IBOutlet weak var tapBakery: UIButton!
    @IBOutlet weak var tapCoffee: UIButton!
    @IBOutlet weak var tapSmoothie: UIButton!
 


    func willBeOver(completion: @escaping () -> Void) {
        print("escaping closure가 선언된 함수가 실행되었습니다. 아래 클로저는 이 함수를 탈출할 것이고, 10초 뒤에 클로저에 담긴 print문이 실행될 것입니다.")
        DispatchQueue.main.asyncAfter(deadline: .now() + 50) {
            completion() // 파라미터로 입력된 클로저를 실행시키는 부분
        }
        print("escaping closure가 선언된 함수가 종료되었습니다. 하지만 이 함수에 담긴 클로저는 이와같이 종료되어도 바깥에서 실행될 겁니다.")
    } // viewDidLoad 통해서 foo 함수 실행 start - end  . . .(3초뒤) "살아있지롱" 함수 실행 후! 3초 뒤 이다
    
    func wellComeGuest() {
        if self.wellComeGuestTimer == nil{
            self.wellComeGuestTimer = DispatchSource.makeTimerSource(flags: [], queue: .main)
            self.wellComeGuestTimer?.schedule(deadline: .now(), repeating: 7) // 타이머의 주기 설정 메소드
            self.wellComeGuestTimer?.setEventHandler(handler: { [weak self] in
                guard let self = self else { return }
                if self.guestDataModel.arrayGuestStruct.count < 3 {
                    print("손님이 3명 이하이므로 손님 추가(7초에 한번)")
                   
                    var numberOfBakery = Int(arc4random_uniform(3)+1)
                    var numberOfCoffee  = Int(arc4random_uniform(3)+1)
                    var numberOfSmoothie = Int(arc4random_uniform(3)+1)

                    self.guestDataModel.inputData(Bakery: numberOfBakery, Coffee: numberOfCoffee, Smoothie: numberOfSmoothie)
                    
                    self.firstOrder_Bakery.text = String(self.guestDataModel.arrayGuestStruct[0].Bakery ?? 0)
                    self.firstOrder_Coffee.text = String(self.guestDataModel.arrayGuestStruct[0].Coffee ?? 0)
                    self.firstOrder_Smoothie.text = String(self.guestDataModel.arrayGuestStruct[0].Smoothie ?? 0)
                    self.waiting.text = String(self.guestDataModel.arrayGuestStruct.count)
                    if self.guestDataModel.arrayGuestStruct.count == 3 {
                        self.waiting.textColor = .red
                    }
                }
                else {
                    print("대기인원이 3명 이상입니다. 밖에 손님들이 화가 났어요!")
                }
//
//                DispatchQueue.global(qos: .userInteractive).async {
//                    self.ascendingNumber()
//
//                }
//                DispatchQueue.global(qos: .userInteractive).async {
//                    self.descendingNumber()
//
//                }
//
            })
        }
        self.wellComeGuestTimer?.resume()
    }
    
    func ascendingNumber() {
        for i in 0...5 {

            print("🍺  ",i)
            usleep(100000)
        }
    }
    
    
     func descendingNumber() {
           for i in (0...5).reversed() {
               print("🍗  ",i)
               usleep(100000)
           }
     }
    
    func preventComeGuest() {
        self.wellComeGuestTimer?.cancel()
        self.wellComeGuestTimer = nil
    }
    
    // 손님 3초에 한번씩 오게 손님은 종류별로 각각 1개 이상씩 주문할 것임 갯수는 랜덤
    
    func onButton() {
        self.tapBakery?.isEnabled = true
        self.tapCoffee?.isEnabled = true
        self.tapSmoothie?.isEnabled = true
    }
    
    @IBAction func go(_ sender: Any) {
        self.guestImage.isHidden = false
        self.guestImage.image = UIImage(named: self.guests[0])
        self.gameStart.isHidden = true
        self.wellcomeStackView.isHidden = true
        self.foodNameStackView.isHidden = false
        self.foodCountStackView.isHidden = false
        self.waitingStackView.isHidden = false
        
        self.onButton()
        self.wellComeGuest()
    
        self.tapComplete.backgroundColor = .black
        self.tapComplete.setTitle("재배 중 입니다. . .", for: .normal)
        
        var RestrictTime:Int = 60
        
        if self.MainTimer == nil{
            self.willBeOver {
                self.mainTimeLabel.textColor = UIColor.red
            }
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
                    self.tapComplete.backgroundColor = .red
                    self.tapComplete.setTitle("주문 완료", for: .normal)
                  

                }
            })
        }
        self.MainTimer?.resume()

    }

    
    func stopMainTimer() {
        self.gameStart.isHidden = false
        self.wellcomeStackView.isHidden = false
        self.guestImage.isHidden = true
        self.foodNameStackView.isHidden = true
        self.foodCountStackView.isHidden = true
        self.waitingStackView.isHidden = true

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

    @IBAction func tapBakery_Action(_ sender: Any) {
        self.tapBakery.isEnabled = false

        DispatchQueue.global().async {
            self.bakeryTimer()
        }
        
        DispatchQueue.global().async {
                DispatchQueue.main.async {
//                    self.tapBakery.setTitle("재배 중", for: .normal)
                usleep(1000000)
            }
        }
    } // global 위에 main 쓰레드를 올려둠으로써 두개의 main 스레드를 동시에 관리할 수 있음 -- 애니메이션 넣기 & escaping closure 활용
    
    @IBAction func tapCoffee_Action(_ sender: Any) {
        self.tapCoffee.isEnabled = false
        coffeeTimer()
    }
    
    @IBAction func tapSmoothie_Action(_ sender: Any) {
        self.tapSmoothie.isEnabled = false
        smoothieTimer()
    }
    
    @IBAction func CompleteOrder(_ sender: Any) {
        self.guestImage.image = UIImage(named: self.guests[Int(arc4random_uniform(2))])
        
        self.cornImage.image = nil
        self.starberryImage.image = nil
        self.potatoImage.image = nil

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
        
    }

    
    
    
//MARK: - BAKERY

    func bakeryTimer() {

        if self.BakeryTimer == nil{
            var makeTime: Int = 5
            var duration: Int = 5
            self.BakeryTimer = DispatchSource.makeTimerSource(flags: [], queue: .main)
            self.BakeryTimer?.schedule(deadline: .now(), repeating: 1) // 타이머의 주기 설정 메소드
            
            self.BakeryTimer?.setEventHandler(handler: { [weak self] in
                guard let self = self else { return }
                makeTime -= 1
//                self.bakeryTime.text = String(makeTime)
                self.changeImage_Corn(index: makeTime)
                self.cornPrograssView.progress = Float(makeTime) / Float(duration)
                self.tapBakery.setTitle("재배 중", for: .normal)
                if makeTime == 0 {
                    self.tapBakery.setTitle("재배 하기", for: .normal)
                    self.tapBakery.isEnabled = true
                    self.stopBakeryTimer()
                    self.numB += 1
                    self.numOfBakery.text = String(self.numB)
                    self.sumOfBakery = 5000 * self.numB
                    self.priceOfBakery.text = String(self.sumOfBakery)
                    if self.numB == self.guestDataModel.arrayGuestStruct[0].Bakery! {
                        self.cornImage.image = UIImage.init(named: "스크린샷_2022-08-01_17.49.27-removebg-preview.png")
                        self.tapBakery.setTitle("재배 완료", for: .normal)
                        self.tapBakery.isEnabled = false
                        self.numOfBakery.textColor = .red
                        self.completeOrder.append(1)
                    }
                 
                }
            })
            
            
        }
        self.BakeryTimer?.resume()
    }

    
    func changeImage_Corn(index: Int)  {
        if index == 5 {
            self.cornImage.image = UIImage.init(named: "Corn_Image-\(index)")
        } else if index == 4 {
            self.cornImage.image = UIImage.init(named: "Corn_Image-\(index)")

        } else if index == 3 {
            self.cornImage.image = UIImage.init(named: "Corn_Image-\(index)")

        } else if index == 2 {
            self.cornImage.image = UIImage.init(named: "Corn_Image-\(index)")

        } else if index == 1 {
            self.cornImage.image = UIImage.init(named: "Corn_Image-\(index)")

        } else if index == 0{
            self.cornImage.image = UIImage.init(named: "Corn_Image-\(index)")
        }
    }
    
    func stopBakeryTimer() {
        self.BakeryTimer?.cancel()
        self.BakeryTimer = nil
    }
    
// MARK: - COFFEE
    
    func coffeeTimer() {
        if self.CoffeeTimer == nil{
            var makeTime: Int = 5
            var duration: Int = 5
            self.CoffeeTimer = DispatchSource.makeTimerSource(flags: [], queue: .main)
            self.CoffeeTimer?.schedule(deadline: .now(), repeating: 1) // 타이머의 주기 설정 메소드
            self.CoffeeTimer?.setEventHandler(handler: { [weak self] in
                guard let self = self else { return }
                makeTime -= 1
//                self.coffeeTime.text = String(makeTime)
                self.changeImage_Starberry(index: makeTime)
                self.starberryPrograssView.progress = Float(makeTime) / Float(duration)
                self.tapCoffee.setTitle("재배 중", for: .normal)
                if makeTime == 0 {
                    self.tapCoffee.setTitle("재배 하기", for: .normal)
                    self.tapCoffee.isEnabled = true
                    self.stopCoffeeTimer()
                    self.numC += 1
                    self.numOfCoffee.text = String(self.numC)
                    self.sumOfCoffee = 4000 * self.numC
                    self.prcieOfCoffee.text = String(self.sumOfCoffee)
                    if self.numC == self.guestDataModel.arrayGuestStruct[0].Coffee! {
                        self.starberryImage.image = UIImage.init(named: "스크린샷_2022-08-01_17.49.27-removebg-preview.png")
                        self.tapCoffee.setTitle("재배 완료", for: .normal)
                        self.tapCoffee.isEnabled = false
                        self.numOfCoffee.textColor = .red
                        self.completeOrder.append(1)
                    }
                }
            })
        }
        self.CoffeeTimer?.resume()
    }
    
    func changeImage_Starberry(index: Int)  {
        if index == 5 {
            self.starberryImage.image = UIImage.init(named: "Starberry_Image-\(index)")
        } else if index == 4 {
            self.starberryImage.image = UIImage.init(named: "Starberry_Image-\(index)")

        } else if index == 3 {
            self.starberryImage.image = UIImage.init(named: "Starberry_Image-\(index)")

        } else if index == 2 {
            self.starberryImage.image = UIImage.init(named: "Starberry_Image-\(index)")

        } else if index == 1 {
            self.starberryImage.image = UIImage.init(named: "Starberry_Image-\(index)")

        } else if index == 0{
            self.starberryImage.image = UIImage.init(named: "Starberry_Image-\(index)")
        }
    }

    func stopCoffeeTimer() {
        self.CoffeeTimer?.cancel()
        self.CoffeeTimer = nil
    }
    
//MARK: - SMOOTHIE
    
    func smoothieTimer() {
        if self.SmoothieTimer == nil{
            var makeTime: Int = 5
            var duration: Int = 5
            self.SmoothieTimer = DispatchSource.makeTimerSource(flags: [], queue: .main)
            self.SmoothieTimer?.schedule(deadline: .now(), repeating: 1) // 타이머의 주기 설정 메소드
            self.SmoothieTimer?.setEventHandler(handler: { [weak self] in
                guard let self = self else { return }
                makeTime -= 1
//                self.smoothieTime.text = String(makeTime)
                self.changeImage_Potato(index: makeTime)
                self.potatoPrograssView.progress = Float(makeTime) / Float(duration)
                self.tapSmoothie.setTitle("재배 중", for: .normal)
                if makeTime == 0 {
                    self.tapSmoothie.setTitle("재배 하기", for: .normal)
                    self.tapSmoothie.isEnabled = true
                    self.stopSmoothieTimer()
                    self.numS += 1
                    self.numOfSmoothie.text = String(self.numS)
                    self.sumOfSmoothie = 3000 * self.numS
                    self.priceOfSmoothie.text = String(self.sumOfSmoothie)
                    if self.numS == self.guestDataModel.arrayGuestStruct[0].Smoothie! {
                        self.tapSmoothie.setTitle("재배 완료", for: .normal)
                        self.potatoImage.image = UIImage.init(named: "스크린샷_2022-08-01_17.49.27-removebg-preview.png")
                        self.tapSmoothie.isEnabled = false
                        self.numOfSmoothie.textColor = .red
                        self.completeOrder.append(1)
                    }
                }
            })
        }
        self.SmoothieTimer?.resume()
    }
    
    func changeImage_Potato(index: Int)  {
        if index == 5 {
            self.potatoImage.image = UIImage.init(named: "Potato_Image-\(index)")
        } else if index == 4 {
            self.potatoImage.image = UIImage.init(named: "Potato_Image-\(index)")

        } else if index == 3 {
            self.potatoImage.image = UIImage.init(named: "Potato_Image-\(index)")

        } else if index == 2 {
            self.potatoImage.image = UIImage.init(named: "Potato_Image-\(index)")

        } else if index == 1 {
            self.potatoImage.image = UIImage.init(named: "Potato_Image-\(index)")

        } else if index == 0{
            self.potatoImage.image = UIImage.init(named: "Potato_Image-\(index)")
        }
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


