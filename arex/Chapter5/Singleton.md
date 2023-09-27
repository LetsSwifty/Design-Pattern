
- DB, 스레드 풀, 캐시, 대화상자, 사용자 설정, 레지스트리 설정을 처리하는 객체 등
- 인스턴스를 두 개 이상 만들게 되면 프로그램이 의도치않은 결과를 나타내거나 자원을 불필요하게 잡아먹는다든가 결과의 일관성이 없어지는 문제가 생길 수 있음

유일한 프로세스가 필요할 때 사용한다.
클래스 인스턴스를 유일한 하나를 만들고, 전역변수를 통해 접근을 제공한다.

## 장점
- 클래스가 하나의 인스턴트만 갖는다는 것을 확신할 수 있습니다.
-  이 인스턴스에 대한 전역 접근 지점을 얻습니다.
-  싱글턴 객체는 필요할 때만 생성하기에 전역 변수의 단점을 보완할 수 있다.

## 단점
- _단일 책임 원칙(SRP)_을 위반합니다. 이 패턴은 한 번에 두 가지의 문제를 동시에 해결합니다.
-  그리고 이 패턴은 다중 스레드 환경에서 여러 스레드가 `Singleton` 객체를 여러 번 생성하지 않도록 특별한 처리가 필요합니다. (- Swift에서는 별다른 처리없이 언어의 특성을 이용)
-  `Singleton`의 클라이언트 코드를 유닛 테스트하기 어려울 수 있습니다.


## 구현

Java, C, C++와 같은 언어에서는 고전적으로 아래와 같이 구현하였다고한다.
1. private init
2. 전역 인스턴스
3. getInstance() 메소드로 지연 초기화

멀티프로세스 환경에서는 동시성 문제가 있는데
자바에서는 `synchronized` 키워드로, `DCL(Double - Checking Locking)`기법을 `volatile` 키워드를 이용해서 동시성 문제를  해결하고 Thread-Safe 하게하려고한다.

Objective-C에서도  `dispatch_once_t` 를 통해서 자바의 `synchronized` 와 같이 동시성 문제를 해결한다.
```objc
+ (id)sharedInstance {  
	static MyObject *sharedInstance = nil;  
	static dispatch_once_t onceToken;  
	
	dispatch_once(&onceToken, ^{  
		sharedInstance = [[self alloc] init];  
	});  
	return sharedInstance;  
}

- (id)init {  
	if (self = [super init]) {  
	// write your code here  
	}  
	return self;  
}
```


그러나 Swift에서는 매우 간단하게 구현되었는데, Swift 3.0에서부터 타입프로퍼티는 원자성을 확인하며 lazy 한 특성을 가지게 되었기 때문이다.
동시성 문제 또한 Swift 언어 자체에서 보장해준다고 한다. 

```swift
class Singleton {
    // 전역 변수를 통해 제공하며, 유일한 인스턴스 제공
    static let shared = Singleton()
    // private 키워드를 통해 외부에서 초기화 차단
    private init() {} 
}
```

`Unit Test`가 힘들다는 단점을 `protocol`를 통해 TC를 인터페이스로서 사용하는 아이디어가 있습니다.
protocol 를 활용해 외부에서 의존성을 주입을 사용해 의존적이지않은 독립적인 환경을 만들 수 있습니다.

직렬화, 역직렬화, 리플렉션으로 싱글턴이 깨지는 문제가 있을 때는
enum을 활용한 회사 API가 이렇게 되어있긴했는데 .. 아직 잘 몰게따

```swift
enum API {
    // 전역 변수를 통해 제공하며, 유일한 인스턴스 제공
    case load
    case save
    // private 키워드를 통해 외부에서 초기화 차단
    func request() {
    ...
    }
}
```

[The free function `dispatch_once` is no longer available in Swift 3.0](https://www.swift.org/migration-guide-swift3/?source=post_page-----75c43e567acf--------------------------------)
[dispatch_once to make sure that the initialization is atomic](https://developer.apple.com/swift/blog/?id=7&source=post_page-----75c43e567acf--------------------------------)
[They’re guaranteed to be initialized only once](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/properties#Type-Properties)