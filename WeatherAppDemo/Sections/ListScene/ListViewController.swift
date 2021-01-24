import UIKit

protocol ListViewControllerType: class, Loadable, Alertable {
    func present(data: ListTableData)
}

class ListViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.register(UINib(nibName: HourQualityTableViewCell.cellId, bundle: nil), forCellReuseIdentifier: HourQualityTableViewCell.cellId)
            tableView.register(UINib(nibName: CityTableViewCell.cellId, bundle: nil), forCellReuseIdentifier: CityTableViewCell.cellId)
        }
    }

    // MARK: - Public
    var presenter: ListPresenterType!
    
    // MARK: - Private
    private var tableData: ListTableData?
    
    // MARK: - Init
    deinit {
        print("deinit ListViewController")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        presenter.getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.deselectSelectedRow(animated: true)
    }
}

extension ListViewController: ListViewControllerType {
    func present(data: ListTableData) {
        self.title = data.title
        self.tableData = data
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension ListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let tableData = tableData else { return 0 }
        return tableData.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let tableData = tableData else { return 0 }
        let dataSection = tableData.sections[section]
        return dataSection.data.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let tableData = tableData else { return nil }
        let dataSection = tableData.sections[section]
        
        switch section {
        case 0:
            return nil
        default:
            return dataSection.date.getDayMonthYear()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0.1
        default:
            return 20
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tableData = tableData else { return UITableViewCell() }
        let dataSection = tableData.sections[indexPath.section]

        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.cellId) as? CityTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: (date: dataSection.date, data: dataSection.data[indexPath.row].airQuality))
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HourQualityTableViewCell.cellId) as? HourQualityTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: dataSection.data[indexPath.row])
            return cell
        }
    }
}

// MARK: - UITableViewDelegate
extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.navigateTo(detail: indexPath)
    }
}
