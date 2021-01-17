import Cocoa
import XCTest


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

    init(passwordLog: [String]) {
        let range = passwordLog[0]
        let rule = passwordLog[1]
        let password = passwordLog[2]

        // range is in format `min-max`
        let ranges = range.split(separator: "-")
        min = Int(ranges.first!)!
        max = Int(ranges.last!)!

        letter = rule.dropLast().first!

        self.password = password
    }
}

let partOne = input
    .map { PasswordPolicy(passwordLog: $0).isValidPasswordPartOne }
    .filter { $0 }
    .count

//print("Part One: \(partOne)")


let partTwo = input
    .map { PasswordPolicy(passwordLog: $0).isValidPasswordPartTwo }
    .filter { $0 }
    .count

//print("Part Two: \(partTwo)")


// MARK:- Tests
class Day02Tests: XCTestCase {
    func testPartOne() {
        let answer = 469
        XCTAssertEqual(answer, partOne)
    }

    func testPartTwo() {
        let answer = 267
        XCTAssertEqual(answer, partTwo)
    }
}

Day02Tests.defaultTestSuite.run()
