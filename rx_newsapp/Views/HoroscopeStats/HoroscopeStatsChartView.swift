
import UIKit
import Charts

class HoroscopeStatsChartView: UIView {
    var chartPrimaryColor: UIColor! {
        didSet {
            renderView()
        }
    }
    var chartValue: Double! {
        didSet {
            let myAttribute = [ NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18.0), NSAttributedString.Key.foregroundColor: Colors.COLOR_WHITE ]
            let myAttrString = NSAttributedString(string: "\(Int(chartValue!))", attributes: myAttribute)

            pieView.centerAttributedText = myAttrString
            renderView()
        }
    }
    var chartName: String! {
        didSet {
            titleLabel.text = chartName
            renderView()
        }
    }
    
    var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = Colors.COLOR_WHITE
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        return titleLabel
    }()
    
    var pieView: PieChartView = {
        let pieView = PieChartView()
        pieView.chartDescription?.enabled = false
        pieView.drawHoleEnabled = true
        pieView.drawCenterTextEnabled = true


        pieView.rotationEnabled = false
        pieView.isUserInteractionEnabled = false
        pieView.legend.enabled = false
        pieView.drawEntryLabelsEnabled = false
        pieView.holeColor = Colors.COLOR_DARK_BLUE
        pieView.holeRadiusPercent = 0.8


        return pieView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        renderView()
    }
    
    private func renderView() {
        var entries: [PieChartDataEntry] = [PieChartDataEntry]()
        guard let chartValue = self.chartValue else { return }
        entries.append(PieChartDataEntry(value: chartValue))
        entries.append(PieChartDataEntry(value: 100 - chartValue))

        let dataset = PieChartDataSet(entries: entries, label: "")
        let colorSecondary: UIColor = Colors.COLOR_BACKGROUND_LIGHT_BLUE

        guard let chartPrimaryColor = self.chartPrimaryColor else { return }
        dataset.colors = [chartPrimaryColor, colorSecondary]
        dataset.drawIconsEnabled = false
        dataset.drawValuesEnabled = false
        pieView.data = PieChartData(dataSet: dataset)
                
                
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 16)
        titleLabel.centerXAnchor.constraint(equalToSystemSpacingAfter: centerXAnchor, multiplier: 0).isActive = true
        
        addSubview(pieView)
        pieView.translatesAutoresizingMaskIntoConstraints = false
        pieView.anchor(top: titleLabel.bottomAnchor, width: 124 ,height: 124)
        pieView.centerXAnchor.constraint(equalToSystemSpacingAfter: centerXAnchor, multiplier: 0).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
