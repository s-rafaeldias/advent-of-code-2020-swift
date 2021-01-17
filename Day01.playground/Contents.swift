import Cocoa
import XCTest

// Read input from file
var filePath = Bundle.main.path(forResource: "input", ofType: "txt")!
var contentData = FileManager.default.contents(atPath: filePath)!
var content = String(data: contentData, encoding: String.Encoding.utf8)

guard let rawInput = content?.split(separator: "\n") else { exit(-1) }
let input = rawInput.map { Int($0) ?? -1 }


// MARK:- Part 1
func partOne(input: [Int]) -> Int? {
    let set = Array(Set(input))

    for (i, value) in set.enumerated() {
        for j in i..<set.count {
            if value + set[j] == 2020 {
                return value * set[j]
            }
        }
    }

    return nil
}


// MARK:- Part 2
func partTwo(input: [Int]) -> Int? {
    let set = Array(Set(input))

    for i in 0..<set.count-2 {
        for j in i+1..<set.count-1 {
            for k in j+1..<set.count {
                if set[i] + set[j] + set[k] == 2020 {
                    return set[i] * set[j] * set[k]
                }
            }
        }
    }

    return nil
}


// MARK:- Tests
class Day01Tests: XCTestCase {
    func testPartOne() {
        let answer = 494475
        XCTAssertEqual(answer, partOne(input: input))
    }

    func testPartTwo() {
        let answer = 267520550
        XCTAssertEqual(answer, partTwo(input: input))
    }
}

Day01Tests.defaultTestSuite.run()
