import Foundation
protocol TengeManagerDelegate {
    
    func didUpdatePrice(price: String, currency: String)
    func didFailWithError(error: Error)
}
struct TengeManager {
    var delegate: TengeManagerDelegate?
    let currencyArray = ["EUR","CAD","PLN","RUB","USD"]
    let urlStr = "http://data.fixer.io/api/latest?access_key=60c18c76b7429396be4b9ba59c6d3f6f&format=1"
    func getTengePrice(for currency: String) {
        let URLString = urlStr
        
        if let url = URL(string: URLString){
            let session = URLSession(configuration: .default)
            print("test1")
            let task = session.dataTask(with: url){ (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    
                    if let tengePrice = self.parseJSON(safeData, currency: currency) {
                        
                        //Optional: round the price down to 2 decimal places.
                        let priceString = String(format: "%.2f", tengePrice)
                        
                        //Call the delegate method in the delegate (ViewController) and
                        //pass along the necessary data.
                        self.delegate?.didUpdatePrice(price: priceString, currency: currency)
                    }
                }
                
            }
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data, currency: String) -> Double? {
        print("test2")
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(TengeData.self , from: data)
            let usd = decodedData.rates.USD
            let cad = decodedData.rates.CAD
            let eur = decodedData.rates.EUR
            let pln = decodedData.rates.PLN
            let rub = decodedData.rates.RUB
            let kzt = decodedData.rates.KZT
            var price = 0.0
            if currency == "USD"{
                price = kzt/usd
            } else if currency == "CAD"{
                price = kzt/cad
            }else if currency == "PLN"{
                price = kzt/pln
            }else if currency == "EUR"{
                price = eur * kzt
            }else if currency == "RUB"{
                price = kzt/rub
            }
            return price
        }catch{
            delegate?.didFailWithError(error: error)
            print(error)
            return nil
        }
    }
}
