//
//  CalculatorButtons.swift
//  Calculator
//
//  Created by dvp on 18/02/2024.
//

import SwiftUI

// TODO: change buttons to return int instead of string
enum CalculatorButtons: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case subtract = "-"
    case add = "+"
    case divide = "/"
    case multiply = "x"
    case equal = "="
    case clear = "C"
    case decimal = "."
    case percent = "%"
    case negative = "+/-"
    
    var buttonColor: Color {
        switch self {
        case .add, .subtract, .divide, .multiply, .equal :
            return .orange
            
        case .clear, .negative, .percent:
            return Color(.lightGray)
            
        default:
            return Color(UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha:1))
        }
    }
}

enum Operation {
    case add, subtract, divide, multiply, none
}
