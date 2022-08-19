## 🌾 마법의 텃밭 with Multi Thread

### ✏️ New Knowledge

1. 동기, 비동기, Serial, Concurensy
2. escaping closure
3. DispacthQueue
4. GCD
5. weak self
6. 🔥 async - await
7. Dispatch Queue
    * 버그나는 부분만 비동기로 감싸기
8. 생성패턴
    * 팩토리패턴, 다음 스테이지로 넘어각
9. 진략패턴
    * enum으로 나눠서 여러게임으로 나누기
10. Caseiterable 
    * enum의 case를 배열처럼 하나씩 접근가능하게 함
11. Capture Lisk(메모리 누수)
    * return: 원하는 값을 던져주고 메모리에서 해지하는 것
  

---

### 📱 Final Result

https://user-images.githubusercontent.com/74387813/185563232-731294c1-a3f0-4c03-8023-7df5964aa0f0.mp4

https://user-images.githubusercontent.com/74387813/185563240-e3a60d08-dd03-4465-aecb-a91910127b22.mp4

---

### 🧠 Gotten & Used Component

1. 순환참조 방지 [weak self]
2. escaping closure
  * 함수가 반환 되어 종료되어도, 외부에 선언한 클로저를 통해 반환된 함수를 빠져나와 클로저를 실행
  * 네트워킹과 UI작업이 동시에 이루어져야하는 통신 작업에서 주로 쓰임
3. 로그인 기능
  * Google OAuth
4. UIAnimate

---

### 🗣 Grammar 

- 클로저를 사용하게 될 때, 알아야하는 개념
    
    [박교수의 Swift강좌21 - 클로저강한참조순환 (널널한 교수의 Swift 2) ft. Swift 코딩](https://youtu.be/ofiLLBeJJSc)
    
    [Strong vs. Weak Swift 5: What is Weak Self (Xcode 11, 2020)](https://youtu.be/chI-B8u4MBs)
    
    [Swift - 클로저 기본](https://www.youtube.com/watch?v=Ix9gGuupjBU&t=14s&ab_channel=yagom)
    
    [Swift - 클로저 고급](https://www.youtube.com/watch?v=WvqYKP6VgNQ&ab_channel=yagom)
    

- 탈출 클로저
    
    [[SWIFT] Escaping Closure(탈출 클로저)](https://dongminyoon.tistory.com/14)
    

- ✅이번 수업 개념
    
    [Concurrency and Grand Central Dispatch in Swift (GCD)](https://medium.com/swift-coding/concurrency-and-grand-central-dispatch-in-swift-gcd-f0ae063973c2)

---

### 🧑‍💻 Ref. link

- 센치한 개발자님 강의 : [https://youtu.be/5ejngRFNy_k](https://youtu.be/5ejngRFNy_k)
- 공식문서(UITableView) : [https://developer.apple.com/documentation/uikit/uitableview](https://developer.apple.com/documentation/uikit/uitableview)
- 공식문서(UITableViewCell) : [https://developer.apple.com/documentation/uikit/uitableviewcell](https://developer.apple.com/documentation/uikit/uitableviewcell)
- 예쁜 테이블뷰 : [https://zeddios.tistory.com/766](https://zeddios.tistory.com/766) (Zedd님의 자료는 언제나 훌륭합니다^^)
- Cell Lify Cycle : [https://jinnify.tistory.com/58](https://jinnify.tistory.com/58) (생명주기 배운 이후니까, 한번 보시면 좋습니다. 스위치 문제 해결에 답이 될 수도...)
- ✅테이블뷰를 사용하기 전 고민해보자 : [https://soojin.ro/blog/uitableview-hype](https://soojin.ro/blog/uitableview-hype) (테이블뷰를 사용하다보면, 모든 걸로 가능하기도 하지만 꼭 써야하는지는 고민해봅시다.)
- [https://pilgwon.github.io/blog/2017/08/30/Dealing-with-Complex-Table-Views-in-iOS.html](https://pilgwon.github.io/blog/2017/08/30/Dealing-with-Complex-Table-Views-in-iOS.html)
- [https://velog.io/@dlskawns96/Swift-MVC-패턴으로-UITableView-구현하기](https://velog.io/@dlskawns96/Swift-MVC-%ED%8C%A8%ED%84%B4%EC%9C%BC%EB%A1%9C-UITableView-%EA%B5%AC%ED%98%84%ED%95%98%EA%B8%B0)

