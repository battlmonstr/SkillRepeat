import Foundation
import SwiftDate

struct Skill: CustomDebugStringConvertible, Codable, Equatable {
    let name: String
    let period: TimeInterval

    static let defaultPeriod: TimeInterval = 2.weeks.timeInterval

    var debugDescription: String { name }

    static func == (lhs: Skill, rhs: Skill) -> Bool {
        return lhs.name == rhs.name
    }
}

class Skills {
    let items: [Skill]
    let store: SkillsStore?

    init(_ items: [Skill], store: SkillsStore? = nil) {
        self.items = items
        self.store = store
    }

    static var testInstance: Skills {
        return Skills([
            Skill(name: "reading", period: Skill.defaultPeriod),
            Skill(name: "running", period: Skill.defaultPeriod),
            Skill(name: "programming", period: Skill.defaultPeriod),
            Skill(name: "music", period: Skill.defaultPeriod),
        ])
    }
}
