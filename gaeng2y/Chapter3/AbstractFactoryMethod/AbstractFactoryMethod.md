# Abstract Factory Method 패턴이란?

추상 팩토리 패턴은 생성 패턴의 한 종류로 객체의 집합을 생성할 때 유리한 패턴이다

추상 팩토리 패턴은 앞에서 다룬 팩토리 메소드 패턴과 혼동할 수 있지만 다른 패턴이다

추상 팩토리 패턴은 기존에 팩토리를 한번 더 추상화하여 서로 관련이 있는 제품군을 생성하게 해준다

[위키백과](https://ko.wikipedia.org/wiki/%EC%B6%94%EC%83%81_%ED%8C%A9%ED%86%A0%EB%A6%AC_%ED%8C%A8%ED%84%B4)에서 또 한번 찾아보자

> 다양한 구성 요소 별로 **객체의 집합**을 생성해야 할 때 유용하다

근데 팩토리를 한번 더 추상화한다는 의미가 이해가 잘 안된다.

1. 기존에 각각 Button, Label을 만들어주는 팩토리가 있다고 가정
2. 아이패드, 아이폰 전용 UI가 필요, 기기에 맞는 Button, Label이 필요
3. 이때 Button, Label Factory를 한번 더 추상화하여 iPad, iPhone Factory를 만들면 각각의 부품에 대한 Factory를 가지는 것이 아니라 iPad, iPhone Factory를 가지면 한번에 해결

## 언제 사용할까?

* 생성을 책임지는 구체적인 클래스를 분리시키고 싶을 때
	* 추상 팩토리 패턴은 인스턴스를 생성하는 과정을 캡슐화한 것이다. 따라서 생성에 관한 구체적인 내용이 사용자와 분리된다
* 여러 제품군 중 선택을 통하여 시스템을 구성하고 제품군을 대체하고 싶을 때
	* 구체 팩토리를 추가하거나 변경을 통해 서로 다른 제품을 사용할 수 있게 할 수 있다. 추상 팩토리는 필요한 모든 것을 생성하기 때문에 전체 제품군은 한 번에 변경이 가능하다

# Factory Method Vs Abstract Factory Method

## 언제 Factory Method 대신 Abstract Factory Method을 사용할까?

* 제품군 중 하나를 선택하여 시스템에 설정해야 하고 구성한 제품군을 다른 것으로 대체할 수 있을 때
* 연관되어 잇는 다수의 인스턴스가 함께 사용하도록 설계하고, 이 부분에 대한 제약이 외부에서도 지켜지도록 하고 싶을 때

## 제품군이 필요할 때 Factory Method를 사용했을 때 문제점

아래는 Factory Method 패턴으로 구현한 UML이다

![factoryMethod](https://user-images.githubusercontent.com/73867548/154947932-014a28b2-3ca8-4138-a3ef-db36b527daee.png)

* iPhone, iPad 각 기기 별로 UI를 구성하려는 상황을 가졍해보자
* 사용자(Factory를 사용하는 타입인 ContentUI) 입장에서는 분기 처리를 위한 ContentType을 이용하여 처리한다
* 사용자는 모든 UI 요소들의 Factory를 가지고 있어야 한다
* 결국 부품이 많아지면 사용자 입장에서 관리하기 까다로워 진다

여기서 만약 새로운 기기 Apple Watch가 추가된다면?

모든 Factory에 애플 워치에 관한 분기 처리를 추가해줘야 하며 Factory 쪽 코드 뿐만 아니라 사용자도 애플 워치를 생성하는 경우 내부 코드 변경이 필요하다

따라서 연관이 있는 여러 객체를 묶어서 생성하는 경우에 Abstract Factory 패턴이 Factory Method 패턴에 비해 유리할 수 있다

# Swift로 Abstract Factory Method 패턴 구현하기

![AFM](https://user-images.githubusercontent.com/73867548/154948535-c51711a5-112d-4a62-ae8a-a2256676db41.png)

**Abstract Factory**

* UIFactoryable: Factory 추상화 타입

**Concrete Factory**

* IPhoneFactory, IPadFactory: 각 연관이 있는 인스턴스 집합을 생성할 구체 팩토리 타입

**Abstract Product**

* Buttonable, Labelable: 생성되는 인스턴스를 추상화하는 타입

**Concrete Product**

* IPhoneButton, IPadLabel, ...: 최종적으로 생성되는 구체적인 타입

그렇다면 위의 예시를 가지고 Abstract Factory Method로 구성해 보면 어떻게 될까?

* iPhone, iPad UI를 생성하기 위해 사용자(Factory를 이용하는 타입)은 필요한 Factory를 통해 연관된 UI 요소들을 받아오면 된다

* 만약 새로운 기기가 추가된다면 추상화 되어있는 Factory를 준수하는 AppleWatchFactory를 생성하여 관련 제품군을 넣어 해결이 가능하다

## 생성을 담당하는 Factory 구현

```swift
import Foundation

// 추상화된 Factory
protocol UIFactoryalbe {
    func createButton() -> Buttonalbe
    func createLabel() -> Labelable
}

// 연관된 제품군을 실제로 생성하는 구체 Factory
final class iPadUIFactoy: UIFactoryalbe {
    func createButton() -> Buttonalbe {
        return IPadButton()
    }

    func createLabel() -> Labelable {
        return IPadLabel()
    }
}

final class iPhoneUIFactory: UIFactoryalbe {
    func createButton() -> Buttonalbe {
        return IPhoneButton()
    }

    func createLabel() -> Labelable {
        return IPhoneLabel()
    }
}
```

## 생성될 Product 구현

```swift
import Foundation

// 추상화된 Product 
protocol Buttonalbe {
    func touchUP()
}

protocol Labelable {
    var title: String { get }
}

// 실제로 생성될 구체 Product, 객체가 가질 기능과 상태를 구현
final class IPhoneButton: Buttonalbe {
    func touchUP() {
        print("iPhoneButton")
    }
}

final class IPadButton: Buttonalbe {
    func touchUP() {
        print("iPadButton")
    }
}

final class IPhoneLabel: Labelable {
    var title: String = "iPhoneLabel"
}

final class IPadLabel: Labelable {
    var title: String = "iPadLabel"
}
```

## 사용 부분 VC, UIContent

```swift
import UIKit

class ViewController: UIViewController {

        //UI를 가지고 있는 인스턴스 기기별로 설정
    var iPadUIContent = UIContent(uiFactory: iPadUIFactoy())
    var iPhoneUIContent = UIContent()

    override func viewDidLoad() {
        super.viewDidLoad()
        touchUpButton()
        printLabelTitle()
    }

    func touchUpButton() {
        iPadUIContent.button?.touchUP()
        iPhoneUIContent.button?.touchUP()
    }

    func printLabelTitle() {
        print(iPadUIContent.label?.title ?? "")
        print(iPhoneUIContent.label?.title ?? "")
    }
}

//Factory를 통해 UI를 만들고 가지고 있는 Class
class UIContent {
    var uiFactory: UIFactoryalbe
    var label: Labelable?
    var button: Buttonalbe?

    //사용할 UI의 Default 값은 iPhone
    init(uiFactory: UIFactoryalbe = iPhoneUIFactory()) {
        self.uiFactory = uiFactory
        setUpUI()
    }

        //기기에 맞는 UI들 설정
    func setUpUI() {
        label = uiFactory.createLabel()
        button = uiFactory.createButton()
    }
}
```

# Abstract Factory Method 패턴의 한계?

* Abstract Factory Method 패턴은 Factory가 추가되고 기존에 존재하는 Product로 Factory를 구성할 때는 매우 효과적인 패턴이 될 수 있다
* **하지만** 새로운 종류의 Product가 추가되면 각각의 Factory에도 추각해줘야 하는 경우가 생긴다. Product의 추가나 변동이 잦아진다면 모든 Factory에 변동이 생길 위험이 있다