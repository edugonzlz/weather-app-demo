import UIKit

class AirComponentTableViewCell: UITableViewCell {
    
    static let cellId = String(describing: AirComponentTableViewCell.self)

    // MARK: - Private
    private let nameLabel = UILabel()
    private let valueLabel = UILabel()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure(component: AirComponent) {
        nameLabel.text = component.name.name
        valueLabel.text = "\(component.value) \(component.unit)"
    }
}

private extension AirComponentTableViewCell {
    func configureView() {
        addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
     
        addSubview(valueLabel)
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        valueLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
    }
}
