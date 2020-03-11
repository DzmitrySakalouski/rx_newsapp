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
    let horoscopeVM = HoroscopeViewModel.shared()

    let disposeBag = DisposeBag()
    
    var horoscopeChart: HoroscopeStatsChartView = {
        let horoscopeChart = HoroscopeStatsChartView()
        return horoscopeChart
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Colors.COLOR_BACKGROUND_DARK_BLUE
        layer.cornerRadius = 10
        
        self.horoscopeVM.horoscopeSelectedPeriodData.subscribe(onNext: {
            self.configureStackStats(chartData: $0)
        }).disposed(by: disposeBag)
    }
    
    private func configureStackStats(chartData: HoroscopeDateRangeData) {
        let loveChart = HoroscopeStatsChartView()
        loveChart.chartName = "Love"
        loveChart.chartValue = Double(chartData.love_rate)
        loveChart.chartPrimaryColor = Colors.COLOR_DARK_RED

        let healthChart = HoroscopeStatsChartView()
        healthChart.chartName = "Health"
        healthChart.chartValue = Double(chartData.health_rate)
        healthChart.chartPrimaryColor = Colors.COLOR_YELLOW

        let careerChart = HoroscopeStatsChartView()
        careerChart.chartName = "Career"
        careerChart.chartValue = Double(chartData.career_rate)
        careerChart.chartPrimaryColor = Colors.COLOR_TURQUOISE

        let stack = UIStackView(arrangedSubviews: [loveChart, healthChart, careerChart])
        stack.axis = .horizontal
        stack.distribution = .fillEqually

        addSubview(stack)
        stack.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
