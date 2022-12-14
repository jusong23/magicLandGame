## ๐พ ๋ง๋ฒ์ ํ๋ฐญ with Multi Thread

### โ๏ธ New Knowledge

1. ๋๊ธฐ, ๋น๋๊ธฐ, Serial, Concurensy
2. escaping closure
3. DispacthQueue
4. GCD
5. weak self
6. ๐ฅ async - await
7. Dispatch Queue
    * ๋ฒ๊ทธ๋๋ ๋ถ๋ถ๋ง ๋น๋๊ธฐ๋ก ๊ฐ์ธ๊ธฐ
8. ์์ฑํจํด
    * ํฉํ ๋ฆฌํจํด, ๋ค์ ์คํ์ด์ง๋ก ๋์ด๊ฐ
9. ์ง๋ตํจํด
    * enum์ผ๋ก ๋๋ ์ ์ฌ๋ฌ๊ฒ์์ผ๋ก ๋๋๊ธฐ
10. Caseiterable 
    * enum์ case๋ฅผ ๋ฐฐ์ด์ฒ๋ผ ํ๋์ฉ ์ ๊ทผ๊ฐ๋ฅํ๊ฒ ํจ
11. Capture Lisk(๋ฉ๋ชจ๋ฆฌ ๋์)
    * return: ์ํ๋ ๊ฐ์ ๋์ ธ์ฃผ๊ณ  ๋ฉ๋ชจ๋ฆฌ์์ ํด์งํ๋ ๊ฒ
  

---

### ๐ฑ Final Result

https://user-images.githubusercontent.com/74387813/185563232-731294c1-a3f0-4c03-8023-7df5964aa0f0.mp4

https://user-images.githubusercontent.com/74387813/185563240-e3a60d08-dd03-4465-aecb-a91910127b22.mp4

---

### ๐ง  Gotten & Used Component

1. ์ํ์ฐธ์กฐ ๋ฐฉ์ง [weak self]
2. escaping closure
  * ํจ์๊ฐ ๋ฐํ ๋์ด ์ข๋ฃ๋์ด๋, ์ธ๋ถ์ ์ ์ธํ ํด๋ก์ ๋ฅผ ํตํด ๋ฐํ๋ ํจ์๋ฅผ ๋น ์ ธ๋์ ํด๋ก์ ๋ฅผ ์คํ
  * ๋คํธ์ํน๊ณผ UI์์์ด ๋์์ ์ด๋ฃจ์ด์ ธ์ผํ๋ ํต์  ์์์์ ์ฃผ๋ก ์ฐ์
3. ๋ก๊ทธ์ธ ๊ธฐ๋ฅ
  * Google OAuth
4. UIAnimate

---

### ๐ฃ Grammar 

- ํด๋ก์ ๋ฅผ ์ฌ์ฉํ๊ฒ ๋  ๋, ์์์ผํ๋ ๊ฐ๋
    
    [๋ฐ๊ต์์ Swift๊ฐ์ข21 - ํด๋ก์ ๊ฐํ์ฐธ์กฐ์ํ (๋๋ํ ๊ต์์ Swift 2) ft. Swift ์ฝ๋ฉ](https://youtu.be/ofiLLBeJJSc)
    
    [Strong vs. Weak Swift 5: What is Weak Self (Xcode 11, 2020)](https://youtu.be/chI-B8u4MBs)
    
    [Swift - ํด๋ก์  ๊ธฐ๋ณธ](https://www.youtube.com/watch?v=Ix9gGuupjBU&t=14s&ab_channel=yagom)
    
    [Swift - ํด๋ก์  ๊ณ ๊ธ](https://www.youtube.com/watch?v=WvqYKP6VgNQ&ab_channel=yagom)
    

- ํ์ถ ํด๋ก์ 
    
    [[SWIFT] Escaping Closure(ํ์ถ ํด๋ก์ )](https://dongminyoon.tistory.com/14)
    

- โ์ด๋ฒ ์์ ๊ฐ๋
    
    [Concurrency and Grand Central Dispatch in Swift (GCD)](https://medium.com/swift-coding/concurrency-and-grand-central-dispatch-in-swift-gcd-f0ae063973c2)

---

### ๐งโ๐ป Ref. link

- ์ผ์นํ ๊ฐ๋ฐ์๋ ๊ฐ์ : [https://youtu.be/5ejngRFNy_k](https://youtu.be/5ejngRFNy_k)
- ๊ณต์๋ฌธ์(UITableView) : [https://developer.apple.com/documentation/uikit/uitableview](https://developer.apple.com/documentation/uikit/uitableview)
- ๊ณต์๋ฌธ์(UITableViewCell) : [https://developer.apple.com/documentation/uikit/uitableviewcell](https://developer.apple.com/documentation/uikit/uitableviewcell)
- ์์ ํ์ด๋ธ๋ทฐ : [https://zeddios.tistory.com/766](https://zeddios.tistory.com/766) (Zedd๋์ ์๋ฃ๋ ์ธ์ ๋ ํ๋ฅญํฉ๋๋ค^^)
- Cell Lify Cycle : [https://jinnify.tistory.com/58](https://jinnify.tistory.com/58) (์๋ช์ฃผ๊ธฐ ๋ฐฐ์ด ์ดํ๋๊น, ํ๋ฒ ๋ณด์๋ฉด ์ข์ต๋๋ค. ์ค์์น ๋ฌธ์  ํด๊ฒฐ์ ๋ต์ด ๋  ์๋...)
- โํ์ด๋ธ๋ทฐ๋ฅผ ์ฌ์ฉํ๊ธฐ ์  ๊ณ ๋ฏผํด๋ณด์ : [https://soojin.ro/blog/uitableview-hype](https://soojin.ro/blog/uitableview-hype) (ํ์ด๋ธ๋ทฐ๋ฅผ ์ฌ์ฉํ๋ค๋ณด๋ฉด, ๋ชจ๋  ๊ฑธ๋ก ๊ฐ๋ฅํ๊ธฐ๋ ํ์ง๋ง ๊ผญ ์จ์ผํ๋์ง๋ ๊ณ ๋ฏผํด๋ด์๋ค.)
- [https://pilgwon.github.io/blog/2017/08/30/Dealing-with-Complex-Table-Views-in-iOS.html](https://pilgwon.github.io/blog/2017/08/30/Dealing-with-Complex-Table-Views-in-iOS.html)
- [https://velog.io/@dlskawns96/Swift-MVC-ํจํด์ผ๋ก-UITableView-๊ตฌํํ๊ธฐ](https://velog.io/@dlskawns96/Swift-MVC-%ED%8C%A8%ED%84%B4%EC%9C%BC%EB%A1%9C-UITableView-%EA%B5%AC%ED%98%84%ED%95%98%EA%B8%B0)

