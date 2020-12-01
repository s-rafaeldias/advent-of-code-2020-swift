import Cocoa

// Read input from file
var filePath = Bundle.main.path(forResource: "input", ofType: "txt")!
var contentData = FileManager.default.contents(atPath: filePath)!
var content = String(data: contentData, encoding: String.Encoding.utf8)

guard let rawInput = content?.split(separator: "\n") else { exit(-1) }
let input = rawInput.map { Int($0) ?? -1 }

// MARK:- Part 1
var answer: Int = 0

for (index, value) in input.enumerated() {
    for newIndex in index..<input.count {
        if value + input[newIndex] == 2020 {
            answer = value * input[newIndex]
            break
        }
    }
}

print(answer)

// MARK:- Part 2
answer = 0
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

print(answer)
