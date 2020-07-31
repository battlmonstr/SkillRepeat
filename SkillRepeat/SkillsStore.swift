import Foundation

class SkillsStore {
    let fileName: String
    let resourceName: String

    init(_ fileName: String, resourceName: String) {
        self.fileName = fileName
        self.resourceName = resourceName
    }

    private var fileURL: URL {
        let docsDirOpt = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        guard let docsDir = docsDirOpt.first else { fatalError("documentDirectory not found") }
        return docsDir.appendingPathComponent(fileName)
    }

    func load() throws -> String {
        do {
            return try String(contentsOf: fileURL)
        } catch {
            return try loadResource()
        }
    }

    private func loadResource() throws -> String {
        guard let url = Bundle.main.url(forResource: resourceName, withExtension: nil) else {
            fatalError("\(resourceName) not found")
        }
        return try String(contentsOf: url)
    }

    func loadAndParse() throws -> [Skill] {
        let text = try load()
        return SkillsStore.parseSkillsText(text)
    }

    func save(text: String) throws {
        let data = text.data(using: .utf8)
        try data?.write(to: fileURL)
    }

    private static func parseSkillsText(_ text: String) -> [Skill] {
        let lines = text.components(separatedBy: CharacterSet.newlines)
            .map({ $0.trimmingCharacters(in: .whitespaces )})
            .filter({ !$0.isEmpty })
        return lines.map { parseSkillLine($0) }
    }

    private static func parseSkillLine(_ line: String) -> Skill {
        let parts: [String] = line.components(separatedBy: "@")
            .map({ $0.trimmingCharacters(in: .whitespaces )})
            .filter({ !$0.isEmpty })
        let name = parts[0]
        let period: TimeInterval? = (parts.count > 1) ? parsePeriod(parts.last!) : nil
        return Skill(name: name, period: period ?? Skill.defaultPeriod)
    }

    private static func parsePeriod(_ periodStr: String) -> TimeInterval? {
        let parts: [String] = periodStr.components(separatedBy: " ")
        guard let num = Int(parts[0]) else { return nil }
        let unit = parts.last!
        switch unit {
            case "d": fallthrough
            case "day": fallthrough
            case "days":
                return num.days.timeInterval
            case "w": fallthrough
            case "week": fallthrough
            case "weeks":
                return num.weeks.timeInterval
            default:
                return nil
        }
    }
}
