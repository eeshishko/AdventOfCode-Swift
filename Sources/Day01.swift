import Algorithms
import Foundation

struct Day01: AdventDay {
    var data: String
    
    var entities: [String] {
        data.split(separator: "\n").map { String($0) }
    }
    
    func part1() -> Any {
        var numbers = [Int]()
        for entity in entities {
            numbers.append(numberForString(entity))
        }
        return numbers.reduce(0, +)
    }
    
    private func numberForString(_ str: String) -> Int {
        let digits = str.compactMap { $0.wholeNumberValue }
        if digits.count == 1 {
            return digits[0] * 10 + digits[0]
        } else {
            return digits[0] * 10 + digits[digits.count - 1]
        }
    }
    
    // one
    // two
    // three
    // four
    // five
    // six
    // seven
    // eight
    // nine
    // 3...5
    // NB
    // eighthree sevenine - considered to be 83 79 :facepalm...
    // oneight
    // nineight
    
    func part2() -> Any {
        let digits = Digits()
        return entities.map { line in
            Digits.formDigit(for: digits.getDigits(in: line))
        }.reduce(0, +)
    }
    
    class NumberTree: CustomStringConvertible {
        let id = UUID()
        var value: Int?
        var next: [Character: NumberTree]
        
        init() {
            self.next = [:]
        }
        
        func add(wholeNumber: String, value: Int) {
            if wholeNumber.count == 0 {
                self.value = value
                return
            }
            let c = wholeNumber.first!
            if self.next[c] == nil {
                self.next[c] = NumberTree()
            }
            self.next[c]!.add(
                wholeNumber: String(wholeNumber[wholeNumber.index(wholeNumber.startIndex, offsetBy: 1)...]),
                value: value)
        }
        
        var description: String {
            return "NumberTree { value: \(String(describing: self.value)), next: \(self.next) }"
        }
    }
    
    struct Digits {
        let digits: NumberTree
        
        init() {
            self.digits = NumberTree()
            ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
                .enumerated()
                .forEach { (numI, numS) in
                    self.digits.add(wholeNumber: numS, value: numI + 1)
                }
        }
        
        func getDigits(in line: String) -> [Int] {
            var result: [Int] = []
            var trees: [NumberTree] = []
            
            print("Digits trees: \(digits)")
            for c in line {
                if let i = c.wholeNumberValue {
                    result.append(i)
                } else {
                    for tree in trees {
                        if let ntree = tree.next[c] {
                            if let val = ntree.value {
                                result.append(val)
                            } else {
                                trees.append(ntree)
                            }
                        }
                        trees.remove(at: trees.firstIndex(of: tree)!)
                    }
                    if let tree = self.digits.next[c] {
                        print("Appending tree: \(tree)")
                        trees.append(tree)
                    }
                }
            }
            return result
        }
        
        static func formDigit(for digits: [Int]) -> Int {
            digits.first! * 10 + digits.last!
        }
    }
}

extension Day01.NumberTree: Equatable {
    static func ==(lhs: Day01.NumberTree, rhs: Day01.NumberTree) -> Bool {
        lhs.id == rhs.id
    }
}
