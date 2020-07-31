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

class Skills: ObservableObject {
    private(set) var items: [Skill]
    private let store: SkillsStore?

    init(_ items: [Skill], store: SkillsStore? = nil) {
        self.items = items
        self.store = store
    }

    func loadText() -> String {
        guard let store = self.store else { return "" }
        do {
            return try store.load()
        } catch {
            print("Skills.loadText error: \(error)")
            return ""
        }
    }

    func saveText(text: String) {
        guard let store = self.store else { return }
        do {
            try store.save(text: text)
            self.items = try store.loadAndParse()
            self.objectWillChange.send()
        } catch {
            print("Skills.saveText error: \(error)")
        }
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
