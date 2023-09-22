import Foundation

// hl modules should not depend on low-level; both should depend on abstractions
// 상위 수준 모듈이 하위 수준 모듈에 직접적으로 의존해서는 안된다.
// abstractions should not depend on details; details should depend on abstractions

enum Relationship {
    case parent
    case child
    case sibling
}

class Person {
    var name = ""
    // dob, etc
    init(_ name: String) {
        self.name = name
    }
}

protocol RelationshipBrowser {
    func findAllChildrenOf(_ name: String) -> [Person]
}

// low-level
class Relationships : RelationshipBrowser {
    private var relations = [(Person, Relationship, Person)]()
    
    func addParentAndChild(_ p: Person, _ c: Person) {
        relations.append((p, Relationship.parent, c))
        relations.append((c, Relationship.child, p))
    }
    
    func findAllChildrenOf(_ name: String) -> [Person] {
        return relations
            .filter({$0.name == name && $1 == Relationship.parent && $2 != nil})
            .map({$2})
    }
}

// high-level
class Research {
//    init(_ relationships: Relationships) {
//        // Research가 low level의 releationships의 내부에도 직접적으로 의존하기 때문에 DIP 위반
//        // high-level: find all of job's children
//        let relations = relationships.relations
//        for r in relations where r.0.name == "John" && r.1 == Relationship.parent {
//            print("John has a child called \(r.2.name)")
//        }
//    }
    
    init(_ browser: RelationshipBrowser) {
        // Relationships 을 아는게 아니고 protocol을 알기 때문에(추상화)
        for p in browser.findAllChildrenOf("John") {
            print("John has a child called \(p.name)")
        }
    }
}

func main() {
    let parent = Person("John")
    let child1 = Person("Chris")
    let child2 = Person("Matt")
    
    var relationships = Relationships()
    relationships.addParentAndChild(parent, child1)
    relationships.addParentAndChild(parent, child2)
    
    let _ = Research(relationships)
}

main()
