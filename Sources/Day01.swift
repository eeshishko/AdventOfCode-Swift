import Algorithms

struct Day01: AdventDay {
  var data: String

  var entities: [String] {
      data.split(separator: "\n").map { String($0) }
  }

  func part1() -> Any {
      var numbers = [Int]()
      for entity in entities {
          let digits = entity.compactMap { $0.wholeNumberValue }
          if digits.count == 1 {
              numbers.append(digits[0] * 10 + digits[0])
          } else {
              numbers.append(digits[0] * 10 + digits[digits.count - 1])
          }
      }
      return numbers.reduce(0, +)
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
    // if it's a digit (single character) - take it and proceed
// Taking substrings by 3,4,5 , check them for digit, otherwise +1 for iteration
  func part2() -> Any {
      let textDigits = [
        "one",
        "two",
        "three",
        "four",
        "five",
        "six",
        "seven",
        "eight",
        "nine",
      ]
      var numbers = [Int]()
      for entity in entities {
          var digits = [Int]()
          
          var index = entity.startIndex
          while index < entity.endIndex {
              if let digit = entity[index].wholeNumberValue {
                  digits.append(digit)
                  index = entity.index(after: index)
                  continue
              }
              
              // check 3 letters
              if let indexBy3 = entity.index(index, offsetBy: 3, limitedBy: entity.endIndex) {
                  let str3 = entity[index..<indexBy3]
                  if let textDigitIndex = textDigits.firstIndex(of: String(str3)) {
                      digits.append(textDigitIndex + 1)
                      index = entity.index(index, offsetBy: 3)
                      continue
                  }
              }
              
              // check 4 letters
              if let indexBy4 = entity.index(index, offsetBy: 4, limitedBy: entity.endIndex) {
                  let str4 = entity[index..<indexBy4]
                  if let textDigitIndex = textDigits.firstIndex(of: String(str4)) {
                      digits.append(textDigitIndex + 1)
                      index = entity.index(index, offsetBy: 4)
                      continue
                  }
              }
              
              // check 5 letters
              if let indexBy5 = entity.index(index, offsetBy: 5, limitedBy: entity.endIndex) {
                  let str5 = entity[index..<indexBy5]
                  if let textDigitIndex = textDigits.firstIndex(of: String(str5)) {
                      digits.append(textDigitIndex + 1)
                      index = entity.index(index, offsetBy: 5)
                      continue
                  }
              }
              
              // just iterate
              index = entity.index(after: index)
          }

          if digits.count == 1 {
              numbers.append(digits[0])
          } else {
              numbers.append(digits[0] * 10 + digits[digits.count - 1])
          }
      }
      return numbers.reduce(0, +)
  }
}
