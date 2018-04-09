//
//  GraphViewController.swift
//  hci-fitnote-ios
//
//  Created by Michael Chang on 4/7/18.
//  Copyright © 2018 Michael Chang. All rights reserved.
//

import UIKit
import Charts

class GraphViewController: UIViewController {
    var weights = [Double]()
    var lineChartEntry = [ChartDataEntry]()
    @IBOutlet weak var lnchrt: LineChartView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weights.append(135)
        weights.append(150)
        weights.append(170)
        weights.append(165)
        weights.append(185)
        weights.append(210)
        weights.append(225)
        for i in 0..<weights.count {
            let value = ChartDataEntry(x: Double(i), y: weights[i])
            lineChartEntry.append(value)
        }
        let line1 = LineChartDataSet(values: lineChartEntry, label: "Weights")
        line1.colors = [NSUIColor(red: 255.0/255.0, green: 20.0/255.0, blue: 147.0/255.0, alpha: 1.0)]
        line1.circleColors = [NSUIColor(red: 255.0/255.0, green: 10.0/255.0, blue: 117.0/255.0, alpha: 1.0)]
        let data = LineChartData()
        data.addDataSet(line1)
        lnchrt.data = data
        lnchrt.chartDescription?.text = "Squats"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
