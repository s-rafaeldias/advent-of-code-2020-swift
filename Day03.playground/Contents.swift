import Cocoa

// Read input from file
var filePath = Bundle.main.path(forResource: "input", ofType: "txt")!
var contentData = FileManager.default.contents(atPath: filePath)!
var map = String(data: contentData, encoding: String.Encoding.utf8)!

var route = map.components(separatedBy: "\n")
var routeWidth = route.first!.count

struct Player {
    var x: Int
    var y: Int

    var maxX: Int
    var treesInTheWay = 0
    
    var rightMoves: Int
    var downMoves: Int

    mutating func move() {
        if x + rightMoves >= maxX {
            x += rightMoves
            x -= maxX
        } else {
            x += rightMoves
        }

        y += downMoves
    }

    mutating func checkPositionForTree(currentRoute: String) {
        var arr = Array(currentRoute)
        if arr.isEmpty { return }
        if arr[x] == "#" { treesInTheWay += 1 }
    }
}

// MARK:- Part One
var playerOne = Player(x: 0, y: 0, maxX: routeWidth, rightMoves: 3, downMoves: 1)

route.map {
    playerOne.checkPositionForTree(currentRoute: $0)
    playerOne.move()
}

// MARK:- Part Two
var counter = 1
for (rm, dm) in [(1, 1), (3, 1), (5, 1), (7, 1), (1, 2)] {
    var player = Player(x: 0, y: 0, maxX: routeWidth, rightMoves: rm, downMoves: dm)
    
    for y in 0..<route.count {
        if player.y != y { continue }
        player.checkPositionForTree(currentRoute: route[y])
        player.move()
    }
    print("For (\(rm), \(dm)): \(player.treesInTheWay)")
    counter *= player.treesInTheWay
}

print(counter)
