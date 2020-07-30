import Foundation
import SwiftDate

struct Skill: CustomDebugStringConvertible, Codable, Equatable {
    let name: String
    let period: TimeInterval = 2.weeks.timeInterval

    var debugDescription: String { name }

    static func == (lhs: Skill, rhs: Skill) -> Bool {
        return lhs.name == rhs.name
    }
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
            Skill(name: "music"),
        ])
    }
}
