//
//  DonutChartView.swift
//  balance-tracker-ios
//
//  Created by Bahadir Sonmez on 21.02.2021.
//

import UIKit
import Charts

class DonutChartView: BaseView, SetupCodeView, ChartViewDelegate {
    var viewModel: BalanceViewModel!

    lazy var chart: PieChartView = {
        let view = PieChartView()
        view.rotationEnabled = false
        return view
    }()

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        self.backgroundColor = .white
        chart.delegate = self
        setupView()
    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented")

    }

    func loadView(with vm: BalanceViewModel) {
        self.viewModel = vm
        setDataCount(self.viewModel.numberOfItems)
    }

    func setDataCount(_ count: Int) {
        let entries = (0..<count).map { (i) -> PieChartDataEntry in
            let vm = self.viewModel.binanceBalances[i % self.viewModel.numberOfItems]
            return PieChartDataEntry(value: vm.totalAmount,
                                     label: vm.asset,
                                     icon: UIImage(named: "\(vm.asset.lowercased())"))
        }

        let set = PieChartDataSet(entries: entries, label: "")
        set.drawIconsEnabled = false
        set.sliceSpace = 0

        set.colors = ChartColorTemplates.vordiplom()
            + ChartColorTemplates.joyful()
            + ChartColorTemplates.colorful()
            + ChartColorTemplates.liberty()
            + ChartColorTemplates.pastel()
            + [UIColor(red: 51/255, green: 181/255, blue: 229/255, alpha: 1)]

        let data = PieChartData(dataSet: set)

        let pFormatter = NumberFormatter()
        pFormatter.numberStyle = .percent
        pFormatter.maximumFractionDigits = 1
        pFormatter.multiplier = 1
        pFormatter.percentSymbol = " %"
        data.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))
        data.setValueFont(.systemFont(ofSize: 11, weight: .light))
        data.setValueTextColor(.clear)

        chart.data = data
        chart.highlightValues(nil)
    }

    func buildViewHierarchy() {
        addSubview(chart)
    }

    func setupConstraints() {
        chart.fillSuperview()
    }

    func setupAdditionalConfiguration() {
    }

}

extension DonutChartView {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
//        self.chart.centerText = "\(highlight.dataSetIndex)"
//        print(highlight.dataIndex)
//        self.chart.centerText = entry
    }

    func chartValueNothingSelected(_ chartView: ChartViewBase) {
//        self.chart.centerText = ""
    }
}

