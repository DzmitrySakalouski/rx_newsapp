//
//  HoroscopeStatsView.swift
//  rx_newsapp
//
//  Created by Dzmitry  Sakalouski  on 3/11/20.
//  Copyright © 2020 Dzmitry  Sakalouski . All rights reserved.
//

import UIKit
import RxSwift

class HoroscopeStatsView: UIView {
    var viewModel: HoroscopeViewModel! {
        didSet {
            self.viewModel.horoscopeSelectedPeriodData.subscribe(onNext: {
                self.configureHoroscopeStackStats(chartData: $0)
            }).disposed(by: disposeBag)
        }
    }
    
    var viewModelCompatibility: CompatibilityViewModel! {
        didSet {
            self.viewModelCompatibility.selectedSignsCompatibilityData.subscribe(onNext: { [weak self] data in
                self?.configureCompatibilityStackStats(chartData: data)
            }).disposed(by: disposeBag)
        }
    }

    let disposeBag = DisposeBag()
    
    var horoscopeChart: HoroscopeStatsChartView = {
        let horoscopeChart = HoroscopeStatsChartView()
        return horoscopeChart
    }()
    
    var redChart: HoroscopeStatsChartView = {
        let redChart = HoroscopeStatsChartView()
        redChart.chartPrimaryColor = Colors.COLOR_DARK_RED

        return redChart
    }()
    
    var yellowChart: HoroscopeStatsChartView = {
        let yellowChart = HoroscopeStatsChartView()
        yellowChart.chartPrimaryColor = Colors.COLOR_YELLOW

        return yellowChart
    }()
    
    var blueChart: HoroscopeStatsChartView = {
        let blueChart = HoroscopeStatsChartView()
        blueChart.chartPrimaryColor = Colors.COLOR_TURQUOISE

        return blueChart
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Colors.COLOR_BACKGROUND_DARK_BLUE
        layer.cornerRadius = 10
    }
    
    private func configureCompatibilityStackStats(chartData: SignForCompatibilityCompare) {
        redChart.chartName = "Love"
        redChart.chartValue = Double(chartData.counters.love)
        
        yellowChart.chartName = "Passion"
        yellowChart.chartValue = Double(chartData.counters.passion)
        
        blueChart.chartName = "Trust"
        blueChart.chartValue = Double(chartData.counters.trust)
        
        renderChart()
    }
    
    private func configureHoroscopeStackStats(chartData: HoroscopeDateRangeData) {
        redChart.chartName = "Love"
        redChart.chartValue = Double(chartData.love_rate)

        yellowChart.chartName = "Health"
        yellowChart.chartValue = Double(chartData.health_rate)

        blueChart.chartName = "Career"
        blueChart.chartValue = Double(chartData.career_rate)

        renderChart()
    }
    
    private func renderChart() {
        let stack = UIStackView(arrangedSubviews: [redChart, yellowChart, blueChart])
        stack.axis = .horizontal
        stack.distribution = .fillEqually

        addSubview(stack)
        stack.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
