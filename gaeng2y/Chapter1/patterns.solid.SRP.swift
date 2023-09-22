import Foundation

// SRP(Single Responsibility Principle): 단일 책임 원칙
// 모든 클래스는 하나의 책임만 가지며, 클래스는 그 책임을 완전히 캡슐화해야 함

// SoC(Separation of Concerns): 관심사 분리
// SoC 법칙이란 시스템 요소가 단일 목적이고 배타성을 가져야 한다는 것을 명시한다.
// 어떤 요소도 다른 요소와의 책임을 공유하면 안 되고, 그 요소와 관계가 없는 책임을 포함시킬 수 없다는 것
// SoC란 경계를 세우는 것으로서 달성된다.
// SoC의 효과
// 1. 개별 컴포넌트의 복제가 없어지고, 목적이 단일화되어 전체 시스템을 유지보수하기 쉽게 만든다.
// 2. 시스템 전체가 유지보수성이 올라감으로써 생겨난 부산물로 인해 더 안정적이게 된다.

class Journal : CustomStringConvertible
{
    var entries = [String]()
    var count = 0
    
    // index 반환
    func addEntry(_ text: String) -> Int
    {
        count += 1
        entries.append("\(count): \(text)")
        return count - 1
    }
    
    func removeEntry(_ index: Int)
    {
        entries.remove(at: index)
    }
    
    var description: String
    {
        return entries.joined(separator: "\n")
    }
    
    func save(_ filename: String, _ overwrite: Bool = false)
    {
        // save to a file
    }
    
    func load(_ filename: String) {}
    func load(_ uri: URL) {}
}

class Persistence 
{
    func saveToFile(_ journal: Journal,
                    _ filename: String, _ overwrite: Bool = false)
    {
        
    }
}

func main()
{
    let j = Journal()
    let _ = j.addEntry("I cried today")
    let bug = j.addEntry("I ate a bug")
    print(j)
    
    j.removeEntry(bug)
    print("===")
    print(j)
    
    let p = Persistence()
    let filename = "/mnt/c/sdjfhskdjhfg"
    p.saveToFile(j, filename, false)
}

main()
