import Cocoa
import XCTest

// Read input from file
var filePath = Bundle.main.path(forResource: "input", ofType: "txt")!
var contentData = FileManager.default.contents(atPath: filePath)!
var content = String(data: contentData, encoding: String.Encoding.utf8)

guard let rawInput = content?.split(separator: "\n") else { exit(-1) }
let input = rawInput.map { Int($0) ?? -1 }

// MARK:- Part 1
func partOne(input: [Int]) -> Int {
    var answer: Int = 0

    for (index, value) in input.enumerated() {
        for newIndex in index..<input.count {
            if value + input[newIndex] == 2020 {
                answer = value * input[newIndex]
                break
            }
        }
    }

    return answer
}

print(partOne(input: input))

// MARK:- Part 2
func partTwo(input: [Int]) -> Int {
    var answer = 0
    for (index, value) in input.enumerated() {
        var tmp = input
        tmp.remove(at: index)
        for (i, v) in tmp.enumerated() {
            for newI in i..<tmp.count {
                if value + v + tmp[newI] == 2020 {
                    answer = value * v * tmp[newI]
                    break
                }
            }
        }
    }

    return answer
}


print(partTwo(input: input))


class Day01Tests: XCTestCase {
    func testPartOne() {
        var answer = 494475
        XCTAssertEqual(answer, partOne(input: input))
    }

    func testPartTwo() {
        var answer = 267520550
        XCTAssertEqual(answer, partTwo(input: input))
    }
}

Day01Tests.defaultTestSuite.run()
