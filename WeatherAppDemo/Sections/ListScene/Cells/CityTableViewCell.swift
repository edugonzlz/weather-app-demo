import UIKit

class CityTableViewCell: UITableViewCell {

    static let cellId = String(describing: CityTableViewCell.self)

    @IBOutlet weak var airQualityLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    func configure(with data: (date: Date, data: AirQuality)) {
        airQualityLabel.text = data.data.name
        dateLabel.text = data.date.getDayMonthYear()
        backgroundColor = data.data.color
    }
}
