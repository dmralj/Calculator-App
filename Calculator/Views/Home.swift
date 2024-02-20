//
//  Home.swift
//  Calculator
//
//  Created by dvp on 18/02/2024.
//

import SwiftUI
struct Home: View {
    
    @State var displayValue = 0
    @State var computeValue_1 = 0
    @State var computeValue_2 = 0
    @State var currentFunc: FunctionCalculatorButtons? = nil
    @State var currentOperator: OperationCalculatorButtons? = nil
    @State var isDecimal = false
    
    //Buttons
    let buttons: [[any CalculatorButtons]] = [
        [FunctionCalculatorButtons.clear, FunctionCalculatorButtons.negative, FunctionCalculatorButtons.percent, OperationCalculatorButtons.divide],
        [DigitsCalculatorButtons.seven, DigitsCalculatorButtons.eight, DigitsCalculatorButtons.nine, OperationCalculatorButtons.multiply],
        [DigitsCalculatorButtons.four, DigitsCalculatorButtons.five, DigitsCalculatorButtons.six, OperationCalculatorButtons.subtract],
        [DigitsCalculatorButtons.one, DigitsCalculatorButtons.two, DigitsCalculatorButtons.three, OperationCalculatorButtons.add],
        [DigitsCalculatorButtons.zero, FunctionCalculatorButtons.decimal, FunctionCalculatorButtons.equal]
    ]
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack{
                // MARK: Display
                Spacer()
                HStack {
                    Spacer()
                    Text("\(displayValue)")
                        .bold()
                        .font(.system(size: 100))
                        .foregroundColor(.white)
                }
                .padding()
                
                // MARK: Buttons
                ForEach(Array(buttons.enumerated()), id: \.offset) { (index, row) in
                    HStack(spacing:12){
                        ForEach(Array(row.enumerated()), id: \.offset) { (index,item) in
                            Button {
                                didTap(button: item)
                            } label: {
                                Text(item.buttonTitle)
                                    .font(.system(size: 32))
                                    .frame(width: buttonWidth(item: item), height: buttonHeight())
                                    .background(item.buttonColor)
                                    .clipShape(.rect(cornerRadius: buttonWidth(item: item) / 2))
                                    .foregroundColor(.white)
                                    .fontWeight(.bold)
                            }
                        }
                    }
                    .padding(.bottom, 3)
                }
            }
        }
    }
    
    // Button Width
    func buttonWidth(item:any CalculatorButtons) -> CGFloat {
        if item.buttonTitle == "0" {
            return ((UIScreen.main.bounds.width - (4 * 12)) / 4) * 2
        }
        return (UIScreen.main.bounds.width - (5 * 12)) / 4
    }
    
    // Button Height
    func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - (5 * 12)) / 4
    }
    
    //MARK: DidTap function
    func didTap(button:CalculatorButtons) {
        switch button.buttonType {
        case .digit:
            if displayValue == 0 {
                displayValue = Int(button.buttonTitle)!
                computeValue_1 = displayValue
            }
            else if (currentOperator == nil){
                displayValue = Int("\(displayValue)\(Int(button.buttonTitle)!)") ?? 0
                computeValue_1 = displayValue
            }
            else if (currentOperator != nil && computeValue_2 == 0){
                displayValue = Int(button.buttonTitle)!
                computeValue_2 = displayValue
            }
            else if (currentOperator != nil && computeValue_2 != 0){
                displayValue = Int("\(displayValue)\(Int(button.buttonTitle)!)") ?? 0
                computeValue_2 = displayValue
            }
        case .operation:
            if let operationCalculatorButtons = button as? OperationCalculatorButtons {
                currentOperator = operationCalculatorButtons}
        case .function:
            if let functionCalculatorButtons = button as? FunctionCalculatorButtons {
                switch functionCalculatorButtons {
                case .equal:
                    switch currentOperator! {
                    case .add:
                        displayValue = computeValue_1 + computeValue_2
                    case .subtract:
                        displayValue = computeValue_1 - computeValue_2
                    case .multiply:
                        displayValue = computeValue_1 * computeValue_2
                    case .divide:
                        displayValue = computeValue_1 / computeValue_2
                    }
                    computeValue_1 = displayValue
                    computeValue_2 = 0
                    currentOperator = nil
                    currentFunc = nil
                case .clear:
                    displayValue = 0
                    computeValue_1 = 0
                    computeValue_2 = 0
                    currentOperator = nil
                    currentFunc = nil
                    isDecimal = false
                case .negative, .percent, .decimal:
                    break
                }
            }
        }
        
        #Preview {
            Home()
        }
    }
}

