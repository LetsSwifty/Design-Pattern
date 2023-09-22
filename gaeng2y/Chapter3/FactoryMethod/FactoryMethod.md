# Factory Method Pattern 이란?

[위키피디아](https://ko.wikipedia.org/wiki/%ED%8C%A9%ED%86%A0%EB%A6%AC_%EB%A9%94%EC%84%9C%EB%93%9C_%ED%8C%A8%ED%84%B4)에 따르면...

> 부모 클래스에 알려지지 않은 구체 클래스를 생성하는 패턴이며, 자식 클래스가 어떤 객체를 생성할 지를 결정하도록 하는 패턴이기도 하다
> 
> 부모 클래스 코드에 구체 클래스 이름을 감추기 위한 방법으로도 사용한다

Factory Method Pattern은 제품에 따라서 공장의 생성라인을 바꾸는 것이 아니라 기본이 되는 생산라인은 설치해놓고 요청이 들어오면 `요청에 맞는 제품을 생산해주는 패턴`이라고 생각하면 된다

여기서 포인트는 **어떠한 요청이 들어올 지 모른다는 점이다**

그저 요청에 맞는 제품만 찍어내면 된다는 것이다

## 주요 객체 살펴보기

![위키 UML](https://upload.wikimedia.org/wikipedia/commons/thumb/a/a3/FactoryMethod.svg/600px-FactoryMethod.svg.png)

위키 UML

![야곰 UML](https://user-images.githubusercontent.com/73867548/158944702-a7c174c8-82d5-4726-8d22-c34ebc6c436e.jpg)

야곰 UML

1. **Creator**: Factory에 기본 역할을 정의하는 객체
2. **Concrete Creator**: Creatro를 채택하고 있으며 product에 맞는 구체적 기능을 구현
3. **Product**: Concrete Product가 해야할 동작들을 선언하는 객체
4. **Concrete Product**: Product를 채택하며 그에 맞게 만든 실제 객체

## Swift로 Factory Method Pattern 구현하기

```swift
// Creator
protocol AppleFactory {
    func createElectronics() -> Product
}

// Concrete Creator
class IPhoneFactory: AppleFactory {
    func createElectronics() -> Product {
        return IPhone()
    }
}

class IPadFactory: AppleFactory {
    func createElectronics() -> Product {
        return IPad()
    }
}

// Product
protocol Product {
    func produceProduct()
}

// Concrete Product
class IPhone: Product {
    func produceProduct() {
        print("Hello, iPhone was made")
    }
}

class IPad: Product {
    func produceProduct() {
        print("Hello, iPad wad made")
    }
}

class Client {
    func order(factory: AppleFactory) {
        let elctronicsProduct = factory.createElectronics()
        elctronicsProduct.produceProduct()
    }
}

var client = Client()

client.order(factory: IPadFactory())
client.order(factory: IPhoneFactory())

/*
Hello, iPad was made
Hello, iPhone was made
*/
```

코드에서 `order` 메소드는 매개변수로 AppleFactory라는 프로토콜을 받았다

프로토콜을 매개변수로 받음으로써 공장은 어떤 주문이 들어올지 모르는 상태이고 주문이 들어왔을 때 비로소 어떤 제품을 생산해야 하는지 알 수 있다

## Factory Method 패턴의 장단점

### 장점

* 프로토콜로 기본 기능을 정의해주었기 때문에 기존 코드를 변경하지 않고 새로운 하위클래스를 추가가 가능하기 때문에 유연하고 확장성이 높다
* 코드에 수정 사항이 생기더라도 팩토리 메소드만 수정하면 되기 때문에 수정에 용이하다

### 단점

* product가 추가될 때마다 새롭게 하위 클래스를 정의해주어야 하기 때문에 불필요하게 많은 클래스가 정의되어질 수 있고 그러다보면 복잡해지는 문제가 발생할 수 있다
* 중첩되어 사용되면 매우 복잡해질 우려가 있다

