import Foundation

class HtmlElement: CustomStringConvertible {
    var name = ""
    var text = ""
    var elements = [HtmlElement]()
    private let indentSize = 2
    
    public var description: String {
        return description(0)
    }
    
    private func description(_ indent: Int) -> String {
        var result = ""
        let i = String(repeating: " ", count: indent)
        result += "\(i)<\(name)>\n"
        
        if !text.isEmpty {
            result += String(repeating: " ", count: (indent + 1))
            result += text
            result += "\n"
        }
        
        for element in elements {
            result += element.description(indent + 1)
        }
        
        result += "\(i)</\(name)>\n"
        return result
    }
    
    init() {}
    init(name: String, text: String) {
        self.name = name
        self.text = text
    }
}

class HtmlBuilder: CustomStringConvertible {
    private let rootName: String
    var root = HtmlElement()
    
    init(rootName: String) {
        self.rootName = rootName
        root.name = rootName
    }
    
    func addChild(name: String, text: String) {
        let element = HtmlElement(name: name, text: text)
        root.elements.append(element)
    }
    
    func addChildFluent(name: String, text: String) -> HtmlBuilder {
        let element = HtmlElement(name: name, text: text)
        root.elements.append(element)
        return self
    }
    
    var description: String {
        return root.description
    }
    
    func clear() {
        root = HtmlElement(name: rootName, text: "")
    }
}

let hello = "hello"
var result = "<p>\(hello)</p>"
print(result)

let words = ["hello", "world"]
result = "<ul>\n"

for word in words {
    result.append("<li>\(word)</li>\n")
}
result.append("</ul>")


let builder = HtmlBuilder(rootName: "ul")
builder.addChildFluent(name: "li", text: "hello")
builder.addChildFluent(name: "li", text: "world")
print(builder)

