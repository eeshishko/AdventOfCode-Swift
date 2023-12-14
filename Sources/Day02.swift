import Algorithms
import Foundation

struct Day02: AdventDay {
    struct GameInfo {
        struct Grab {
            let numberOfBlues: Int
            let numberOfReds: Int
            let numberOfGreens: Int
            
            //  3 blue, 4 red
            // --> 3 blue
            // --> 4 red
            init(from str: String) {
                var numberOfBlues: Int = 0
                var numberOfReds: Int = 0
                var numberOfGreens: Int = 0
                str.split(separator: ",").forEach { colorStr in
                    let number = Int(colorStr.split(separator: " ").first!)!
                    let color = String(colorStr.split(separator: " ")[1])
                    switch color {
                    case "blue":
                        numberOfBlues = number
                    case "red":
                        numberOfReds = number
                    case "green":
                        numberOfGreens = number
                    default:
                        break
                    }
                }
                
                self.numberOfBlues = numberOfBlues
                self.numberOfGreens = numberOfGreens
                self.numberOfReds = numberOfReds
            }
        }
        let grabs: [Grab]
        let gameID: Int
        
        init(from str: String) {
            self.gameID = Int(String(str.split(separator: ":").first!.split(separator: " ")[1]))!
            grabs = str.split(separator: ":")[1].split(separator: ";").map {
                .init(from: String($0))
            }
        }
    }
    var data: String
    
    var entities: [String] {
        data.split(separator: "\n").map { String($0) }
    }
    
    let maxNumberOfGreen = 13
    let maxNumberOfRed = 12
    let maxNumberOfBlue = 14
    
    // format:
    // Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
    func part1() -> Any {
        return entities.map { entity in
            let gameInfo = GameInfo(from: entity)
            for grab in gameInfo.grabs {
                if grab.numberOfBlues > maxNumberOfBlue ||
                   grab.numberOfGreens > maxNumberOfGreen ||
                   grab.numberOfReds > maxNumberOfRed {
                    return 0
                }
            }
            return gameInfo.gameID
        }.reduce(0, +)
    }
    
    func part2() -> Any {
        return entities.map { entity in
            let gameInfo = GameInfo(from: entity)
            var minNumberOfBlues = 0
            var minNumberOfReds = 0
            var minNumberOfGreens = 0
            for grab in gameInfo.grabs {
                if grab.numberOfBlues > minNumberOfBlues {
                    minNumberOfBlues = grab.numberOfBlues
                }
                if grab.numberOfReds > minNumberOfReds {
                    minNumberOfReds = grab.numberOfReds
                }
                if grab.numberOfGreens > minNumberOfGreens {
                    minNumberOfGreens = grab.numberOfGreens
                }
            }
            return minNumberOfReds * minNumberOfBlues * minNumberOfGreens
        }.reduce(0, +)
    }
}
