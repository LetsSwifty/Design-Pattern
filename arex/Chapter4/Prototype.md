
기존 객체의 디자인이 반복적으로 사용되고 변경을해야할 때
기존 객체를 `깊은 복사(deep copy)`해서 사용

`class`는 참조 타입이기 때문에 얕은 복사가 일어나면 메모리 주소가 동일하기 때문에
복사한 `class`에서 값을 바꿔도 기존 `class`에서도 값이 변경이 됨

`Swift`에서는 값 타입인 `struct`가 있어서 활용법은 잘 모르겠음

`protocol NSCopying`을 사용해서 `copy()`` 메소드를 사용하면 깊은 복사를 할 수 있음

```swift
class Address : NSCopying, CustomStringConvertible {
	var address : String

    init(_ string : String){
        self.address = string
    }

    func copy(with zone: NSZone? = nil) -> Any {
        return Address(self.address)
    }
    
    var description: String {
        return "I live at \(address)"
    }

}

// 메모리 주소를 알아 보기 위한 메소드
func address(_ o: UnsafeRawPointer) -> String {
    let bit = Int(bitPattern: o)

    return String(format: "%p", bit)

}
```


```swift
func main() {
    var addr = Address("anyang")
    print("addr: \(addr)") // addr: I live at anyang

    print("addr memory address: \(address(&addr))")
    // addr memory address: 0x16da2ed90

    var addr2 = addr.copy() as! Address
    addr2.address = "Gangnam"
    print("addr: \(addr)")
    print("addr2 copy: \(addr2)")
    // addr: I live at anyang
    // addr2 copy: I live at Gangnam
    
    print("addr memory address: \(address(&addr))")
    print("addr2 copy memory address: \(address(&addr2))")
    // addr       memory address: 0x16da2ed90
    // addr2 copy memory address: 0x16da2ed70
}

main()
```