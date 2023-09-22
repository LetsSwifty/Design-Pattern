import Foundation
import UIKit

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
