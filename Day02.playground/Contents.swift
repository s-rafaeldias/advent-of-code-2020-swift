import Cocoa

// Read input from file
var filePath = Bundle.main.path(forResource: "input", ofType: "txt")!
var contentData = FileManager.default.contents(atPath: filePath)!
var content = String(data: contentData, encoding: String.Encoding.utf8)

guard let rawInput = content?.split(separator: "\n") else { exit(-1) }
var input = rawInput.map { $0.components(separatedBy: .whitespaces) }

struct PasswordPolicy {
    var min: Int
    var max: Int
    var letter: Character
    var password: String

    var isValidPasswordPartOne: Bool {
        let totalLetters = Array(password).filter({ $0 == letter }).count
        return totalLetters >= min && totalLetters <= max
    }

    var isValidPasswordPartTwo: Bool {
        var pwd = Array(password)

        let firstChar = pwd[min-1]
        let secondChar = pwd[max-1]

        return firstChar != secondChar && (firstChar == letter || secondChar == letter)
    }

    init(password: [String]) {
        let range = password[0]
        let rule = password[1]
        let password = password[2]

        // range is in format `min-max`
        let ranges = range.split(separator: "-")
        min = Int(ranges.first!)!
        max = Int(ranges.last!)!

        letter = rule.dropLast().first!

        self.password = password
    }
}

let partOne = input
    .map { PasswordPolicy(password: $0).isValidPasswordPartOne }
    .filter({ $0 })
    .count

print("Part One: \(partOne)")


let partTwo = input
    .map { PasswordPolicy(password: $0).isValidPasswordPartTwo }
    .filter({ $0 })
    .count

print("Part Two: \(partTwo)")
