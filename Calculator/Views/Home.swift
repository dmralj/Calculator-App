import SwiftUI

struct Home: View {
    @State var displayValue = 0.0
    @State var computeValue_1 = 0.0
    @State var computeValue_2 = 0.0
    @State var currentFunc: FunctionCalculatorButtons? = nil
    @State var currentOperator: OperationCalculatorButtons? = nil
    @State var isDecimal = false
    
    // MARK: Buttons
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
                        Text("\(String(format: "%g", displayValue))")
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
        
        //  MARK: Button Width
        func buttonWidth(item:any CalculatorButtons) -> CGFloat {
            if item.buttonTitle == "0" {
                return ((UIScreen.main.bounds.width - (4 * 12)) / 4) * 2
            }
            return (UIScreen.main.bounds.width - (5 * 12)) / 4
        }
        
        // MARK: Button Height
        func buttonHeight() -> CGFloat {
            return (UIScreen.main.bounds.width - (5 * 12)) / 4
        }
        
        // MARK: didTap function
        func didTap(button:CalculatorButtons) {
            switch button.buttonType {
            case .digit:
                tappedDigit(button: button)
            case .operation:
                tappedOperation(button: button)
            case .function:
                tappedFunction(button: button)
        }
        
        // MARK: tappedDigit function
        func tappedDigit(button: CalculatorButtons) {
            if (currentOperator == nil && computeValue_1 == 0.0) {
                if (isDecimal && displayValue == floor(displayValue)){
                    displayValue = Double("\(Int(displayValue)).\(Int(button.buttonTitle)!)") ?? 0.0
                }
                else if (isDecimal && displayValue != floor(displayValue)){
                    displayValue = Double("\(displayValue)\(Int(button.buttonTitle)!)") ?? 0.0
                }
                else {
                    displayValue = Double(button.buttonTitle)!
                }
                computeValue_1 = displayValue
            }
            else if (currentOperator == nil && computeValue_1 != 0.0){
                if (isDecimal && displayValue == floor(displayValue)){
                    displayValue = Double("\(Int(displayValue)).\(Int(button.buttonTitle)!)") ?? 0.0
                }
                else if (isDecimal && displayValue != floor(displayValue)){
                    displayValue = Double("\(displayValue)\(Int(button.buttonTitle)!)") ?? 0.0
                }
                else {
                    displayValue = Double("\(Int(displayValue))\(Int(button.buttonTitle)!)") ?? 0.0
                }
                computeValue_1 = displayValue
            }
            else if (currentOperator != nil && computeValue_2 == 0.0){
                displayValue = 0.0
                if (isDecimal && displayValue == floor(displayValue)){
                    displayValue = Double("\(Int(displayValue)).\(Int(button.buttonTitle)!)") ?? 0.0
                }
                else if (isDecimal && displayValue != floor(displayValue)){
                    displayValue = Double("\(displayValue)\(Int(button.buttonTitle)!)") ?? 0.0
                }
                else    {
                    displayValue = Double(button.buttonTitle)!
                }
                computeValue_2 = displayValue
            }
            else if (currentOperator != nil && computeValue_2 != 0.0){
                if (isDecimal && displayValue == floor(displayValue)){
                    displayValue = Double("\(Int(displayValue)).\(Int(button.buttonTitle)!)") ?? 0.0
                }
                else if (isDecimal && displayValue != floor(displayValue)){
                    displayValue = Double("\(displayValue)\(Int(button.buttonTitle)!)") ?? 0.0
                }
                else {
                    displayValue = Double("\(Int(displayValue))\(Int(button.buttonTitle)!)") ?? 0.0
                }
                computeValue_2 = displayValue
            }
        }
        
        // MARK: tappedOperation function
        func tappedOperation(button: CalculatorButtons) {
                if let operationCalculatorButtons = button as? OperationCalculatorButtons {
                    currentOperator = operationCalculatorButtons
                    isDecimal = false
                }
        }
        
        // MARK: tappedFunction function
        func tappedFunction(button: CalculatorButtons) {
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
                    computeValue_2 = 0.0
                    currentOperator = nil
                    currentFunc = nil
                case .clear:
                    displayValue = 0.0
                    computeValue_1 = 0.0
                    computeValue_2 = 0.0
                    currentOperator = nil
                    currentFunc = nil
                    isDecimal = false
                case .negative:
                    displayValue *= -1
                case .percent:
                    isDecimal = true
                    displayValue *= 0.01
                case .decimal:
                    isDecimal = true
                }
            }
        }
        
        #Preview {
            Home()
        }
        
    }
}
