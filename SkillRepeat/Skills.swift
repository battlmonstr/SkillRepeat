import Foundation

struct Skill: CustomDebugStringConvertible, Codable {
    let name: String
    var debugDescription: String { name }
}

class Skills {
    let items: [Skill]

    init(_ items: [Skill]) {
        self.items = items
    }

    convenience init(resourceName: String) {
        let url = Bundle.main.url(forResource: resourceName, withExtension: nil)!
        let text = try! String(contentsOf: url)
        let lines = text.components(separatedBy: CharacterSet.newlines)
            .filter({ !$0.isEmpty })
        self.init(lines.map { Skill(name: $0) })
    }

    static var testInstance: Skills {
        return Skills([
            Skill(name: "reading"),
            Skill(name: "running"),
            Skill(name: "programming"),
        ])
    }
}
