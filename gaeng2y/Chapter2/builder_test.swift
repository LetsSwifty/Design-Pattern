import Foundation

class Code: CustomStringConvertible {
    let name: String
    let type: String
    
    init(_ name: String, _ type: String) {
        self.name = name
        self.type = type
    }
    
    var description: String {
        return "var \(name): \(type)\n"
    }
}

class CodeBuilder : CustomStringConvertible
{
  let rootName: String
  var codes = [Code]()
  
  private let indentSize = 2
  
  init(_ rootName: String)
  {
    self.rootName = rootName
  }

  func addField(called name: String, ofType type: String) -> CodeBuilder
  {
    self.codes.append(Code(name, type))
    return self
  }

  public var description: String
  {
    var result = ""
    result += "class \(rootName)\n"
    result += "{\n"
    
    for code in codes {
        result += String(repeating: " ", count: indentSize)
        result += code.description
    }
    
    result += "}"
    
    return result
  }
}
