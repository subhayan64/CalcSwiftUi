//
//  ContentView.swift
//  CalcSwitUI
//
//  Created by subhayan.mukhopadhay on 05/02/23.
//

import SwiftUI

enum CalcButton: String {
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
    case add = "+"
    case subtract = "-"
    case divide = "÷"
    case mutliply = "x"
    case equal = "="
    case clear = "AC"
    case decimal = "."
    case percent = "%"
    case negative = "-/+"
    
    var buttonColor: Color {
        switch self {
        case .add, .subtract, .mutliply, .divide, .equal:
            return Color(.lightGray)
        case .clear, .negative, .percent:
            return .clear
        default:
            return .white
        }
    }
}

enum Operation {
    case add, subtract, multiply, divide, none
}

struct ContentView: View {
    
    @State var value = "0"
    @State var displayValue = "0"
    @State var runningNumber: Double = -0
    @State var currentOperation: Operation = .none
    
    
    let buttons: [[CalcButton]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .mutliply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal],
    ]
    
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    Text(displayValue)
                        .bold()
                        .font(.system(size: 100))
                        .foregroundColor(.black)
                }
                .padding()
                
                
                ForEach(buttons, id: \.self) { row in
                    HStack(spacing: 12) {
                        ForEach(row, id: \.self) { item in
                            Button(action: {
                                self.keyTap(button: item)
                            }, label: {
                                Text(item.rawValue)
                                    .font(.system(size: 32))
                                    .frame(
                                        width: self.buttonWidth(item: item),
                                        height: self.buttonHeight()
                                    )
                                    .background(Color.white)
                                    .foregroundColor(.black)
                                
                            }).border(Color.black, width: 2)
                            
                        }
                    }
                    .padding(.bottom, 3)
                }
            }
        }
    }
    
    func keyTap(button: CalcButton) {
        switch button {
        case .add, .subtract, .mutliply, .divide, .percent, .equal:
            if button == .add {
                self.currentOperation = .add
                self.runningNumber = Double(self.value) ?? 0
            }
            else if button == .subtract {
                self.currentOperation = .subtract
                self.runningNumber = Double(self.value) ?? 0
            }
            else if button == .mutliply {
                self.currentOperation = .multiply
                self.runningNumber = Double(self.value) ?? 0
            }
            else if button == .divide {
                self.currentOperation = .divide
                self.runningNumber = Double(self.value) ?? 0
            }
            else if button == .percent{
                self.runningNumber = Double(self.value) ?? 0
                self.value = formatResult(val: self.runningNumber * 0.01)
                self.displayValue = self.value
            }
            else if button == .equal {
                let runValue: Double = self.runningNumber
                let currentValue = Double(self.value) ?? 0
                
                evaluateResult(op: self.currentOperation, runValue: runValue, currentValue: currentValue)
                self.displayValue = self.value
            }
            
            
            if button != .equal {
                self.value = "0"
            }
            break
        case .clear:
            self.value = "0"
            self.displayValue = self.value
        case .negative:
            self.value = formatResult(val: (-1 * (Double(self.value) ?? 0)))
            self.displayValue = self.value
            break
        case .decimal:
            if (!self.value.contains(".")){
                self.value = "\(self.value)\(button.rawValue)"
                self.displayValue = self.value
            }
            break
        default:
            let number = button.rawValue
            if self.value == "0" {
                value = number
            }
            else {
                self.value = "\(self.value)\(number)"
            }
            self.displayValue = self.value
        }
    }
    
    
    func evaluateResult(op: Operation, runValue: Double, currentValue: Double){
        switch op {
        case .add: self.value = formatResult(val: (runValue + currentValue))
        case .subtract: self.value = formatResult(val: (runValue - currentValue))
        case .multiply: self.value = formatResult(val: (runValue * currentValue))
        case .divide: self.value = formatResult(val: (runValue / currentValue))
        case .none:
            break
        }
    }
    
    func formatResult(val : Double) -> String
    {
        print(val)
        if(val.truncatingRemainder(dividingBy: 1) == 0)
        {
            return String(format: "%.0f", val)
        }
        
        return String(format: "%.2f", val)
    }
    
    func buttonWidth(item: CalcButton) -> CGFloat {
        if item == .zero {
            return ((UIScreen.main.bounds.width - (5*12)) / 4) * 2 + 12
        }
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
    
    func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro Max"))
    }
}

//TODO: add chain operation
//TODO: fix equals multipress
//TODO: handle long string
//TODO: highlight selected operation
