import Foundation

fileprivate struct LogEntryList: Codable {
    let entries: [LogEntry]
}

class LogStore {
    let jsonFileName: String

    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()

    init(jsonFileName: String) {
        self.jsonFileName = jsonFileName
        self.encoder.outputFormatting = .prettyPrinted
    }

    private var logFileURL: URL {
        let docsDirOpt = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        guard let docsDir = docsDirOpt.first else { fatalError("documentDirectory not found") }
        return docsDir.appendingPathComponent(jsonFileName)
    }

    func load() throws -> [LogEntry] {
        let logData = try Data(contentsOf: logFileURL)
        let logEntryList = try decoder.decode(LogEntryList.self, from: logData)
        return logEntryList.entries
    }

    func save(entries: [LogEntry]) throws {
        let logEntryList = LogEntryList(entries: entries)
        let logData = try encoder.encode(logEntryList)
        try logData.write(to: logFileURL)
    }

}

