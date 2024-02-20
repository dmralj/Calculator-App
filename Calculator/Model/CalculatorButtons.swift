//
//  CalculatorButtons.swift
//  Calculator
//
//  Created by dvp on 18/02/2024.
//

import SwiftUI


enum CalculatorButtonType {
    case digit
    case operation
    case function
}
// TODO: change buttons to return int instead of string
protocol CalculatorButtons {
    var buttonColor: Color {
        get
    }
    
    var buttonTitle: String {
        get
    }

    var buttonType: CalculatorButtonType {
        get
    }

}

enum DigitsCalculatorButtons: String, CalculatorButtons {
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
    
    var buttonColor: Color {
            return Color(UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha:1))
    }
    
    var buttonTitle: String {
        rawValue
    }

    var buttonType: CalculatorButtonType {
        .digit
    }
}



enum OperationCalculatorButtons: String, CalculatorButtons {
    case subtract = "-"
    case add = "+"
    case divide = "/"
    case multiply = "x"
    
    var buttonColor: Color {
        return .orange
    }
    
    var buttonTitle: String {
        rawValue
    }
    
    var buttonType: CalculatorButtonType {
        .operation
    }
}

enum FunctionCalculatorButtons: String, CalculatorButtons {
    case equal = "="
    case clear = "C"
    case decimal = "."
    case percent = "%"
    case negative = "+/-"
    
    var buttonColor: Color {
        switch self {
        case .equal :
            return .orange

        default:
            return Color(.lightGray)
        }
    }
    
    var buttonTitle: String {
        rawValue
    }
    
    var buttonType: CalculatorButtonType {
        .function
    }
}
