//
//  AddRegistrationTableViewController.swift
//  HotelCordoba
//
//  Created by omaestra on 31/07/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import UIKit

class AddRegistrationTableViewController: UITableViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var checkInDateLabel: UILabel!
    @IBOutlet weak var checkInDatePicker: UIDatePicker!
    @IBOutlet weak var checkOutDateLabel: UILabel!
    @IBOutlet weak var checkOutDatePicker: UIDatePicker!
    
    @IBOutlet weak var numberOfAdultsStepper: UIStepper!
    @IBOutlet weak var numberOfChildrenStepper: UIStepper!
    @IBOutlet weak var numberOfAdultsValueLabel: UILabel!
    @IBOutlet weak var numberOfChildrenValueLabel: UILabel!
    
    @IBOutlet weak var wifiSwitch: UISwitch!
    
    @IBOutlet weak var roomTypeLabel: UILabel! {
        didSet {
            roomTypeLabel.text = "Not set"
        }
    }
    
    let checkInDatePickerCellIndexPath = IndexPath(row: 1, section: 1)
    let checkOutDatePickerCellIndexPath = IndexPath(row: 3, section: 1)
    
    let checkInDatePickerLabelIndexPath = IndexPath(row: 0, section: 1)
    let checkOutDatePickerLabelIndexPath = IndexPath(row: 2, section: 1)
    
    var isCheckInDatePickerShown: Bool = false {
        didSet {
            checkInDatePicker.isHidden = !isCheckInDatePickerShown
        }
    }
    
    var isCheckOutDatePickerShown: Bool = false {
        didSet {
            checkOutDatePicker.isHidden = !isCheckOutDatePickerShown
        }
    }
    
    var registration: Registration? {
        guard let roomType = roomType else { return nil }
        
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let checkInDate = checkInDatePicker.date
        let checkOutDate = checkOutDatePicker.date
        let numberOfAdults = Int(numberOfAdultsStepper.value)
        let numberOfChildren = Int(numberOfChildrenStepper.value)
        let hasWifi = wifiSwitch.isOn
        
        return Registration(firstName: firstName,
                            lastName: lastName,
                            emailAddress: email,
                            checkInDate: checkInDate,
                            checkOutDate: checkOutDate,
                            numberOfAdults: numberOfAdults,
                            numberOfChildren: numberOfChildren,
                            roomType: roomType,
                            wifi: hasWifi)
    }
    var roomType: RoomType? {
        didSet {
            self.roomTypeLabel.text = roomType?.name ?? "Not set"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
        [firstNameTextField, lastNameTextField, emailTextField].forEach({
            
            $0?.addTarget(self, action: #selector(textFieldValueDidChange(_:)), for: .editingChanged)
        })

        let midnightToday = Calendar.current.startOfDay(for: Date())
        checkInDatePicker.minimumDate = midnightToday
        checkInDatePicker.date = midnightToday
        
//                checkOutDatePicker.minimumDate = checkInDatePicker.date.addingTimeInterval(86400)
        
        let aheadDate = Calendar.current.date(byAdding: .hour, value: 24, to: checkInDatePicker.date, wrappingComponents: true)
        checkOutDatePicker.minimumDate = aheadDate
        
        updateLocalizations()
        updateDateViews()
        updateNumberOfGuests()
        updateRoomType()
    }
    
    @IBAction func textFieldValueDidChange(_ textField: UITextField) {
        print("\(textField.text ?? "")")
    }
    
    func updateLocalizations() {
//        self.navigationItem.title = NSLocalizedString("registrations.new.title", comment: "New registration")
        
        self.navigationItem.title = String(format: "Hola %@ que tal", locale: Locale(identifier: "es"), arguments: ["Oswaldo"])
        
        let path = Bundle.main.path(forResource: "en", ofType: "lproj")!
        let bundle = Bundle(path: path)
        self.navigationItem.title = bundle?.localizedString(forKey: "registrations.edit.title", value: nil, table: nil)
    }
    
    func updateDateViews() {
        let dateFormatter = DateFormatter()
//        dateFormatter.dateStyle = .short
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        checkInDateLabel.text = dateFormatter.string(from: checkInDatePicker.date)
        checkOutDateLabel.text = dateFormatter.string(from: checkOutDatePicker.date)
        
        if checkOutDatePicker.date.compare(Date()) == .orderedAscending {
            
        }
        let aheadDate = Calendar.current.date(byAdding: .hour, value: 24, to: checkInDatePicker.date, wrappingComponents: true)
        checkOutDatePicker.minimumDate = aheadDate
    }
    
    func updateNumberOfGuests() {
        numberOfAdultsValueLabel.text = "\(Int(numberOfAdultsStepper.value))"
        numberOfChildrenValueLabel.text = "\(Int(numberOfChildrenStepper.value))"
    }
    
    func updateRoomType() {
        self.roomTypeLabel.text = roomType?.name ?? "Not set"
    }

    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        updateDateViews()
    }
    
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        updateNumberOfGuests()
    }
    
    @IBAction func wifiSwitchChanged(_ sender: UISwitch) {
        
    }
    
    @IBAction func handleCancel(_ sender: Any) {
        if registration != nil {
            self.navigationController?.popViewController(animated: true)
        } else {
            self.navigationController?.dismiss(animated: true, completion: nil)
        }
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath {
        case checkInDatePickerLabelIndexPath:
            if isCheckInDatePickerShown {
                isCheckInDatePickerShown = false
            } else if isCheckOutDatePickerShown {
                isCheckOutDatePickerShown = false
                isCheckInDatePickerShown = true
            } else {
                isCheckInDatePickerShown = true
            }
            
            tableView.beginUpdates()
            tableView.endUpdates()
            
        case checkOutDatePickerLabelIndexPath:
            if isCheckOutDatePickerShown {
                isCheckOutDatePickerShown = false
            } else if isCheckInDatePickerShown {
                isCheckInDatePickerShown = false
                isCheckOutDatePickerShown = true
            } else {
                isCheckOutDatePickerShown = true
            }
            
            tableView.beginUpdates()
            tableView.endUpdates()
        case IndexPath(row: 0, section: 4):
            let destination = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SelectRoomTypeTableViewController") as! SelectRoomTypeTableViewController
            destination.delegate = self
            self.navigationController?.pushViewController(destination, animated: true)
        default:
            break
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case checkInDatePickerCellIndexPath:
            return isCheckInDatePickerShown ? 216.0 : 0.0
        case checkOutDatePickerCellIndexPath:
            return isCheckOutDatePickerShown ? 216.0 : 0.0
        default:
            return super.tableView(tableView, heightForRowAt: indexPath)
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToSelectRoomType" {
            let destination = segue.destination as! SelectRoomTypeTableViewController
            destination.delegate = self
        }
    }
}

extension AddRegistrationTableViewController: SelectRoomTypeTableViewControllerDelegate {
    func didSelect(roomType: RoomType) {
        self.roomType = roomType
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}
