# Builder Pattern 이란?

[위키피디아](https://ko.wikipedia.org/wiki/%EB%B9%8C%EB%8D%94_%ED%8C%A8%ED%84%B4)에 따르면...

> 빌더 패턴이란 복합 객체의 생성 과정과 표현 방법을 분리하여 동일한 생성 절차에서 서로 다른 표현 결과를 만들 수 있게 하는 패턴이다
> 
> 2 단어 요약: **생성자**, **오버로딩**

빌더 패턴은 복잡한 객체를 생성할 때 유용한 패턴이다

'객체는 그냥 정의하고 초기화해주면 되는거 아니야?' 라고 생각할 수도 있지만

빌더 패턴은 같은 문제를 해결하는 또 다른 방법론일 뿐이다

빌더 패턴은 고장 시스템을 떠올리면 쉽게 이해할 수 있다

공장에서는 컨베이어 벨트를 타고 돌면서 작업이 순차적으로 이루어진다

예를 들어 맥북을 컨베이어 벨트 시스템으로 만든다고 가정하면

어떤 맥북은 기본형, 또 어떤 맥북은 고급형인데 이러한 작업이 하나의 컨베이어 벨트에서 진행된다면 어떨것인가?

순차적으로 주문에 맞는 부품을 커스텀하게 될 것이다

## Builder Pattern 구조 이해하기

아래의 이미지는 [위키피디아](https://upload.wikimedia.org/wikipedia/commons/thumb/f/f3/Builder_UML_class_diagram.svg/2880px-Builder_UML_class_diagram.svg.png)에서 가져왔슴다

![builder-patter](https://upload.wikimedia.org/wikipedia/commons/thumb/f/f3/Builder_UML_class_diagram.svg/2880px-Builder_UML_class_diagram.svg.png)

제가 보고 있는 [야곰 닷넷](https://yagom.net/)의 이미지를 보면

![builder](https://user-images.githubusercontent.com/73867548/159396454-10299cea-3cf0-4a9c-adf0-d1e232b0044e.jpg)

빌더 패턴의 구조는 단순하다

어떤 Product와 이를 만드는 Builder로 구성되어 있다

기본적인 구성이라 필요에 따라 추가 및 변형이 될 수 있다

Builder는 어떤 값들을 세팅하는 메소드와 최종적으로 Product를 만드는 build() 메소드를 가지게 된다

이때 Product를 만드는 모든 과정은 Builder가 담당하게 된다

코드로 살펴보면서 이해해보자

## Swift로 Builder Pattern 구현하기

```swift
import Foundation

struct MacBook {
    let color: String
    let memory: Int
    let storage: String
    let hasTouchBar: Bool
}

class MacBookBuilder {
    private var color = "Space Gray"
    private var memory = 16
    private var storage = "256GB"
    private var hasTouchBar = false
    
    func setColor(_ color: String) -> MacBookBuilder {
        self.color = color
        return self
    }
    
    func setMemory(_ memory: Int) -> MacBookBuilder {
        self.memory = memory
        return self
    }
    
    func setStorage(_ storage: String) -> MacBookBuilder {
        self.storage = storage
        return self
    }
    
    func setHasTouchBar(_ has: Bool) -> MacBookBuilder {
        self.hasTouchBar = has
        return self
    }
    
    func build() -> MacBook {
        return MacBook(color: color, memory: memory, storage: storage, hasTouchBar: hasTouchBar)
    }
}

let builder = MacBookBuilder()
let macbook1 = builder
    .setColor("Silver")
    .setMemory(32)
    .setStorage("1TB")
    .setHasTouchBar(false)
    .build()

let macbook2 = builder
    .setMemory(64)
    .setStorage("2TB")
    .build()

let macbook3 = builder
    .build()

```

## Builder Pattern은 언제 사용하는게 좋아요?

코드를 보면 그냥 이니셜라이저를 사용하는 거랑 크게 다르지 않아보인다...

그래서 Swift에서의 빌더 패턴은 그렇게까지 유용한 패턴은 아니다

굳이 빌더 패턴의 사용처를 생각해본다면, 프로퍼티의 갯수가 엄청나게 많아지고 복잡해지는 경우를 생각해볼 수 있을 것 같다