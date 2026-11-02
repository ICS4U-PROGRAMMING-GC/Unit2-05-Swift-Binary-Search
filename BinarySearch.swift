/**
 * BinarySearch program that generates random arrays, sorts them,
 * and allows the user to search for values using binary search
 * with crash-proof input validation.
 * 
 * @author Carel Gumuyire
 * @version 1.0
 */

import Foundation

/**
 * Populates an array with 10 random integers between 0 and 100.
 * 
 * @return an array of 10 random integers
 */
func populateArray() -> [Int] {
    var array = [Int]()
    for _ in 0..<10 {
        array.append(Int.random(in: 0...100))
    }
    return array
}

/**
 * Performs a binary search on a sorted array to find a target number.
 * 
 * @param array the sorted array of numbers to search through
 * @param number the target number to find
 * @return the index of the number if found, or -1 if not found
 */
func binarySearch(array: [Int], number: Int) -> Int {
    var low = 0
    var high = array.count - 1

    while low <= high {
        let mid = (low + high) / 2

        if array[mid] == number {
            return mid
        } else if array[mid] < number {
            low = mid + 1
        } else {
            high = mid - 1
        }
    }
    return -1
}

/**
 * Main execution running the interactive loop and handling user input.
 */
var running = true

repeat {
    var array = populateArray()
    array.sort()

    print("\nWhat number are you searching for in the list below? Enter \"q\" to quit.")
    for num in array {
        print(num, terminator: " ")
    }
    print("")

    print("Number: ", terminator: "")
    guard let rawInput = readLine() else { continue }
    let input = rawInput.trimmingCharacters(in: .whitespacesAndNewlines)

    if input.lowercased() == "q" {
        print("Thank you for playing!")
        running = false
    } else {
        var number = -1
        var valid = false
        var currentInput = input

        while !valid {
            if currentInput.lowercased() == "q" {
                print("Thank you for playing!")
                running = false
                break
            }

            if let parsedNumber = Int(currentInput) {
                number = parsedNumber
                valid = true
            } else {
                print("Invalid input. Enter a valid number or \"q\" to quit: ", terminator: "")
                guard let nextInput = readLine() else { continue }
                currentInput = nextInput.trimmingCharacters(in: .whitespacesAndNewlines)
            }
        }

        if running {
            let index = binarySearch(array: array, number: number)

            if index != -1 {
                print("The number \(number) is found at index \(index).")
            } else {
                print("The number \(number) is not found in the list of numbers.")
            }
        }
    }

} while running