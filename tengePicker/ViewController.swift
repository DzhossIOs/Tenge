
import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, TengeManagerDelegate {
  
    

    @IBOutlet weak var currencyName: UILabel!
    @IBOutlet weak var tengeLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    var tengeManager = TengeManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tengeManager.delegate = self
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
    }
    func didUpdatePrice(price: String, currency: String) {

           DispatchQueue.main.async {
               self.tengeLabel.text = price
               self.currencyName.text = currency
           }
       }
    func didFailWithError(error: Error) {
              print(error)
          }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
          return 1
      }
      
      func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return tengeManager.currencyArray.count
      }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return tengeManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency = tengeManager.currencyArray[row]
        tengeManager.getTengePrice(for: selectedCurrency)
    }


}


