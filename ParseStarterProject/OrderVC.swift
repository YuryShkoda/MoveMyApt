//
//  OrderVC.swift
//  MoveMyStuff
//
//  Created by Yury on 8/8/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit
import GooglePlaces

extension OrderVC: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
        dismiss(animated: true, completion: nil)
        if isMoveFrom {
            moveFrom.text = place.formattedAddress!
        } else {
            moveTo.text = place.formattedAddress!
        }
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}

class OrderVC: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var isMoveFrom = true
    
    let aptSize = ["One item",
                   "Just a fiwe items",
                   "Studio 400-600 sq ft",
                   "Studio 600-700 sq ft",
                   "1 Bedroom 600-800 sq ft",
                   "1 Bedroom 800-1000 sq ft",
                   "2 Bedroom 1000-1500 sq ft",
                   "3 Bedroom 1500-2000 sq ft",
                   "4 Bedroom over 2000 sq ft"]
    
    @IBOutlet weak var moveFrom: UITextField!
    @IBOutlet weak var moveTo: UITextField!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var size: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var sizePicker: UIPickerView!
    @IBOutlet weak var pickUpStairs: UISwitch!
    @IBOutlet weak var dropOffStairs: UISwitch!
    
    @IBAction func moveFromEditing(_ sender: Any) {
        isMoveFrom = true
        presentPlaceAutocomplete()
    }
    @IBAction func moveFromChanged(_ sender: Any) {
        isMoveFrom = true
        presentPlaceAutocomplete()
    }
    @IBAction func moveToEditing(_ sender: Any) {
        isMoveFrom = false
        presentPlaceAutocomplete()
    }
    @IBAction func moveToChanged(_ sender: Any) {
        isMoveFrom = false
        presentPlaceAutocomplete()
    }
    
    @IBAction func creatOrder(_ sender: Any) {
        
        for subView in self.view.subviews as [UIView] {
            if let textField = subView as? UITextField {
                if textField.text == "" {
                    textField.layer.borderWidth = 1
                    textField.layer.borderColor = UIColor.red.cgColor
                }
            } else if let label = subView as? UILabel {
                if label.text == "" {
                    label.layer.borderWidth = 1
                    label.layer.borderColor = UIColor.red.cgColor
                }
            }
        }
        
        let customer = Customer.sharedInstance
        let order = Order(customerID: customer.id, status: "Pending", email: customer.email, date: date.text!, pickUpAddress: moveFrom.text!, dropOffAddress: moveTo.text!, pickUpStairs: pickUpStairs.isOn, dropOffStairs: dropOffStairs.isOn, stuff: size.text!)
        order.save()
    }
    
    func presentPlaceAutocomplete() {
        let placePickerController = GMSAutocompleteViewController()
        placePickerController.delegate = self
        present(placePickerController, animated: true, completion: nil)
    }
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle =  DateFormatter.Style.medium
        date.text = dateFormatter.string(from: sender.date)
//        datePicker.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sizePicker.delegate = self
        sizePicker.reloadAllComponents()
        sizePicker.selectRow(3, inComponent: 0, animated: true)
        
        let dateGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleDateTap(gestureRecognizer:)))
        date.isUserInteractionEnabled = true
        date.addGestureRecognizer(dateGestureRecognizer)
        
        let sizeGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleSizeTap(gestureRecognizer:)))
        size.isUserInteractionEnabled = true
        size.addGestureRecognizer(sizeGestureRecognizer)
    }
    
    //FIXME: need to write one func to handle taps
    func handleDateTap(gestureRecognizer: UIGestureRecognizer) {
        sizePicker.isHidden = true
        datePicker.isHidden = false
        datePicker.datePickerMode = UIDatePickerMode.date
    }
    
    func handleSizeTap(gestureRecognizer: UIGestureRecognizer){
        datePicker.isHidden = true
        sizePicker.isHidden = false
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return aptSize.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return aptSize[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        size.text = " " + aptSize[row]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
