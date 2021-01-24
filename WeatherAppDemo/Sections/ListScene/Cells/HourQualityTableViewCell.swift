import UIKit

class HourQualityTableViewCell: UITableViewCell {

    static let cellId = String(describing: HourQualityTableViewCell.self)

    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var airQualityLabel: UILabel!
    
    func configure(with data: AirPollutionInfo) {
        hourLabel.text = data.date.getHourString()
        airQualityLabel.text = data.airQuality.name
        backgroundColor = data.airQuality.color
    }
}
