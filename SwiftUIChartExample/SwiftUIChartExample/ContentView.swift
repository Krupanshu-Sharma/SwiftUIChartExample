//
//  ContentView.swift
//  SwiftUIChartExample
//
//  Created by Krupanshu Sharma on 05/01/23.
//

import SwiftUI
import Charts
// Charts

struct Expense: Identifiable {
    var date: Date
    var type: String
    var amount: Double
    var id = UUID()
}

class ExpenseVM {
    
    // 1
    static func getDummyExpenses() -> [Expense] {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M/d/yyyy"

        let data: [Expense] = [
            .init(date: dateFormatter.date(from: "12/1/2022") ?? Date(), type: "Food", amount: 55.0),
            .init(date: dateFormatter.date(from: "12/1/2022") ?? Date(), type: "Shopping", amount: 44.0),
            .init(date: dateFormatter.date(from: "12/1/2022") ?? Date(), type: "Movie", amount: 24.0),
            .init(date: dateFormatter.date(from: "11/1/2023") ?? Date(), type: "Food", amount: 103.0),
            .init(date: dateFormatter.date(from: "11/4/2023") ?? Date(), type: "Movie", amount: 76.0),
            .init(date: dateFormatter.date(from: "10/1/2023") ?? Date(), type: "Food", amount: 103.0),
            .init(date: dateFormatter.date(from: "10/2/2023") ?? Date(), type: "Food", amount: 10.0),
            .init(date: dateFormatter.date(from: "10/3/2023") ?? Date(), type: "Food", amount: 30.0),
            .init(date: dateFormatter.date(from: "9/4/2023") ?? Date(), type: "Movie", amount: 85.0),
            .init(date: dateFormatter.date(from: "9/6/2023") ?? Date(), type: "Movie", amount: 12.0),
            .init(date: dateFormatter.date(from: "9/17/2023") ?? Date(), type: "Movie", amount: 50.0),
            .init(date: dateFormatter.date(from: "8/1/2023") ?? Date(), type: "Food", amount: 10.0),
            .init(date: dateFormatter.date(from: "8/6/2023") ?? Date(), type: "Food", amount: 40.0),
            .init(date: dateFormatter.date(from: "8/9/2023") ?? Date(), type: "Food", amount: 80.0),
            .init(date: dateFormatter.date(from: "7/4/2023") ?? Date(), type: "Movie", amount: 20.0),
            .init(date: dateFormatter.date(from: "7/24/2023") ?? Date(), type: "Movie", amount: 60.0),
            .init(date: dateFormatter.date(from: "7/14/2023") ?? Date(), type: "Movie", amount: 20.0),
            .init(date: dateFormatter.date(from: "6/1/2023") ?? Date(), type: "Food", amount: 103.0),
            .init(date: dateFormatter.date(from: "6/12/2023") ?? Date(), type: "Food", amount: 10.0),
            .init(date: dateFormatter.date(from: "6/15/2023") ?? Date(), type: "Food", amount: 56.0),
            .init(date: dateFormatter.date(from: "5/4/2023") ?? Date(), type: "Movie", amount: 30.0),
            .init(date: dateFormatter.date(from: "5/6/2023") ?? Date(), type: "Movie", amount: 50.0),
            .init(date: dateFormatter.date(from: "5/9/2023") ?? Date(), type: "Movie", amount: 10.0),
            .init(date: dateFormatter.date(from: "5/14/2023") ?? Date(), type: "Movie", amount: 80.0),
            .init(date: dateFormatter.date(from: "5/3/2023") ?? Date(), type: "Movie", amount: 70.0),
            .init(date: dateFormatter.date(from: "4/1/2023") ?? Date(), type: "Food", amount: 103.0),
            .init(date: dateFormatter.date(from: "4/4/2023") ?? Date(), type: "Food", amount: 10.0),
            .init(date: dateFormatter.date(from: "4/7/2023") ?? Date(), type: "Food", amount: 50.0),
            .init(date: dateFormatter.date(from: "3/4/2023") ?? Date(), type: "Movie", amount: 40.0),
            .init(date: dateFormatter.date(from: "3/5/2023") ?? Date(), type: "Movie", amount: 12.0),
            .init(date: dateFormatter.date(from: "3/6/2023") ?? Date(), type: "Movie", amount: 87.0),
            .init(date: dateFormatter.date(from: "2/4/2023") ?? Date(), type: "Movie", amount: 95.0),
            .init(date: dateFormatter.date(from: "2/5/2023") ?? Date(), type: "Movie", amount: 15.0),
            .init(date: dateFormatter.date(from: "2/6/2023") ?? Date(), type: "Movie", amount: 15.0),
            .init(date: dateFormatter.date(from: "1/4/2023") ?? Date(), type: "Movie", amount: 44.0),
            .init(date: dateFormatter.date(from: "1/5/2023") ?? Date(), type: "Movie", amount: 84.0),
            .init(date: dateFormatter.date(from: "1/6/2023") ?? Date(), type: "Movie", amount: 44.0)
        ]

        return data
    }
    
    // 2.
    static func expensesByMonth(_ month: Int) -> [Expense] {
        return ExpenseVM.getDummyExpenses().filter {
        Calendar.current.component(.month, from: $0.date) == month + 1
      }
    }
}

// 1
struct ExpenseBarChart: View {
    // 2
    var expencesList : [Expense]
    // 3
    var body: some View {
        // 4
        Chart(0..<12, id: \.self) { month in
            
            // 5
            let expenseValue = sumOfExpensesIn(month)
            let monthName = DateUtils.monthAbbreviationFromInt(month)
            
            BarMark(
                x: .value("Expenses", expenseValue),
                y: .value("Month", monthName)
            )
            // 7
            .foregroundStyle(.mint)
            // 8
            .annotation(position: .trailing) {
              Text(String(format: "%.2f $", expenseValue))
                .font(.caption)
            }
            .accessibilityLabel(DateUtils.monthFromInt(month))
            .accessibilityValue("Expense \(expenseValue) $")
        }
        // 9
        .chartXAxisLabel("Months", position: .leading)
    }
    
    // 10
    func sumOfExpensesIn(_ month: Int) -> Double {
      self.expencesList.filter {
        Calendar.current.component(.month, from: $0.date) == month + 1
      }
      .reduce(0) { $0 + $1.amount }
    }
}

// 1
var monthlyAvgExpenseView: some View {
  // 2
  List(0..<12) { month in
    // 3
    VStack {
      // 4
        Chart( ExpenseVM.expensesByMonth(month)) { dayInfo in
        // 5
        LineMark(
            x: .value("Day", dayInfo.date),
          y: .value("Expenses", dayInfo.amount)
        )
        // 6
        .foregroundStyle(.orange)
        // 7
        .interpolationMethod(.catmullRom)
      }

      Text(Calendar.current.monthSymbols[month])
    }
    .frame(height: 150)
  }
  .listStyle(.plain)
}

// 1
var monthlyAvgExpenseViewInRectangleMark: some View {
  // 2
  List(0..<12) { month in
    // 3
    VStack {
      // 4
        Chart( ExpenseVM.expensesByMonth(month)) { dayInfo in
        // 5
            RectangleMark(
            x: .value("Day", dayInfo.date),
            y: .value("Expenses", dayInfo.amount),
            width: 5,
            height: 25
        )
        // 6
        .foregroundStyle(.purple)
        // 7
        .interpolationMethod(.catmullRom)
      }

      Text(Calendar.current.monthSymbols[month])
    }
    .frame(height: 150)
  }
  .listStyle(.plain)
}

// 1
var monthlyAvgExpenseViewInAreaMark: some View {
  // 2
  List(0..<12) { month in
    // 3
    VStack {
      // 4
        Chart( ExpenseVM.expensesByMonth(month)) { dayInfo in
        // 5
            AreaMark(
            x: .value("Day", dayInfo.date),
            y: .value("Expenses", dayInfo.amount)
        )
        // 6
        .foregroundStyle(.red)
        // 7
        .interpolationMethod(.catmullRom)
      }

      Text(Calendar.current.monthSymbols[month])
    }
    .frame(height: 150)
  }
  .listStyle(.plain)
}


struct ContentView: View {
    private var chartTypes: [String] = [ "Bar Chart", "Line Chart", "Rectangle Chart", "Area Chart" ]
    
    var body: some View {
        
        NavigationStack {
            List(chartTypes, id: \.self) { chartType in
                NavigationLink(value: chartType) {
                    Text(chartType)
                }
            }
            .listStyle(.plain)
            .navigationDestination(for: String.self) { chartType in
                if chartType == "Bar Chart" {
                    ExpenseBarChart(expencesList: ExpenseVM.getDummyExpenses())
                } else if chartType == "Line Chart" {
                    monthlyAvgExpenseView
                } else if chartType == "Rectangle Chart" {
                    monthlyAvgExpenseViewInRectangleMark
                } else {
                    monthlyAvgExpenseViewInAreaMark
                }
            }
            .navigationTitle("Charts")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


enum DateUtils {
  static func monthFromInt(_ month: Int) -> String {
    let monthSymbols = Calendar.current.monthSymbols
    return monthSymbols[month]
  }

  static func monthAbbreviationFromInt(_ month: Int) -> String {
    let monthSymbols = Calendar.current.shortMonthSymbols
    return monthSymbols[month]
  }
}
