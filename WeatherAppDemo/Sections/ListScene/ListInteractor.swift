import Foundation

protocol ListInteractorType: class {
    var output: ListInteractorOutput? { get set }
    func getData()
}

protocol ListInteractorOutput: class {
    func presentCity(data: (date: Date, data: [AirPollutionInfo]))
    func presentForecast(data: [(date: Date, data: [AirPollutionInfo])])
    func presentError(title: String, message: String)
}

class ListInteractor {
   
    // MARK: - Public
    weak var output: ListInteractorOutput?
    
    // MARK: - private
    private let coordinates = Config.demoCoordinates
    private let queue = OperationQueue()

    private let forecastService: ForecastService
    
    init(forecastService: ForecastService) {
        self.forecastService = forecastService
    }
}

extension ListInteractor: ListInteractorType {
    func getData() {
        queue.addOperation {
            self.getCityData(coordinates: self.coordinates)
        }
        queue.addOperation {
            self.getForecast(coordinates: self.coordinates)
        }
    }
}

private extension ListInteractor {
    
    func getCityData(coordinates: Coordinates){
        forecastService.getCurrentAirQuality(coordinates: coordinates) { (result: Result<ForecastEntity, Error>) in
            switch result {
            case .success(let data):
                if let date = data.airPollutionInfo.first?.date {
                    let cityData = (date: date, data: data.airPollutionInfo)
                    self.output?.presentCity(data: cityData)
                }
                
            case .failure:
                self.output?.presentError(title: "Attention", message: "Something has gone wrong")
            }
        }
    }
    
    func getForecast(coordinates: Coordinates) {
        forecastService.getForecast(coordinates: coordinates) { (result: Result<ForecastEntity, Error>) in
            switch result {
            case .success(let data):
                let cal = Calendar.current
                let groupByDate = Dictionary(grouping: data.airPollutionInfo, by: { (item) -> Date in
                    let date = cal.startOfDay(for: item.date)
                    return date
                })
                
                var sections = [(date: Date, data: [AirPollutionInfo])]()
                groupByDate.forEach({ date, data in
                    sections.append((date: date, data: data))
                })
                
                sections.sort(by: {$0.date > $1.date})
                self.output?.presentForecast(data: sections)
                
            case .failure:
                self.output?.presentError(title: "Attention", message: "Something has gone wrong")
            }
        }
    }
}
