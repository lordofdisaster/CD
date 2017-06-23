//
//  CalendarViewController.swift
//  Cardee
//
//  Created by Alexander Lisovik on 5/23/17.
//  Copyright © 2017 Alexander Lisovik. All rights reserved.
//

import UIKit
import FSCalendar

class CalendarViewController: UIViewController, FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance {

    fileprivate let gregorian = Calendar(identifier: .gregorian)
    fileprivate let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    fileprivate weak var calendar: FSCalendar!
    var selectedDaysButton: UIButton!
    var sameDates: UIButton!

    var car: Car!
    var rentalType: RentalType!
    var present: DetailRentalViewController!
    
    // MARK: Controller Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.present = self.navigationController?.viewControllers[1].childViewControllers[0].childViewControllers[0] as! DetailRentalViewController
    }
    
    override func loadView() {
        
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = UIColor.white
        self.view = view
        
        let calendar = FSCalendar(frame: CGRect(x: 0, y: 30, width: view.frame.size.width, height: 400))
        calendar.dataSource = self
        calendar.delegate = self
        calendar.allowsMultipleSelection = true
        view.addSubview(calendar)
        
        self.calendar = calendar
        
        calendar.calendarHeaderView.backgroundColor = UIColor.white
        calendar.calendarWeekdayView.backgroundColor = UIColor.white
        calendar.register(DIYCalendarCell.self, forCellReuseIdentifier: "cell")
        calendar.swipeToChooseGesture.isEnabled = true
        calendar.appearance.caseOptions = FSCalendarCaseOptions.weekdayUsesSingleUpperCase
        calendar.scrollDirection = .vertical
        calendar.clipsToBounds = true
        calendar.appearance.headerTitleColor = Color.grayText
        
        self.selectedDaysButton = UIButton(type: .system)
        self.selectedDaysButton.frame = CGRect(x: 13, y: view.frame.size.height - 58 - 44 - 20 - 50, width: view.frame.size.width - 26, height: 45)
        self.selectedDaysButton.backgroundColor = Color.green
        self.selectedDaysButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightBold)
        self.selectedDaysButton.setTitleColor(UIColor.white, for: .normal)

        if self.rentalType == .daily {
            self.selectedDaysButton.setTitle("\(self.car.availabilityDailyDates.count) days available  •  Save", for: .normal)
        } else {
             self.selectedDaysButton.setTitle("\(self.car.availabilityHourlyDates.count) days available  •  Save", for: .normal)
        }
        
        self.selectedDaysButton.layer.cornerRadius = 3
        self.selectedDaysButton.addTarget(self, action: #selector(self.saveDateInfo), for: .touchUpInside)
        
        self.sameDates = UIButton(type: .system)
        self.sameDates.frame = CGRect(x: 0, y: view.frame.size.height - 107, width: view.frame.size.width, height: 43)
        self.sameDates.setTitle("Use Same Dates For Hourly & Daily", for: .normal)
        self.sameDates.layer.borderWidth = 0.5
        self.sameDates.layer.borderColor = Color.darkGray.cgColor
        self.sameDates.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        self.sameDates.setTitleColor(Color.darkGray, for: .normal)
        
        view.addSubview(self.sameDates)
        view.addSubview(self.selectedDaysButton)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Calendar"

        if self.rentalType == .daily {
            self.car.availabilityDailyDates.forEach { (date) in
                if Methods.transformStringToDate(string: date) > Date() {
                    self.calendar.select(Methods.transformStringToDate(string: date), scrollToDate: false)
                }
            }
        } else {
            self.car.availabilityHourlyDates.forEach { (date) in
                if Methods.transformStringToDate(string: date) > self.gregorian.date(byAdding: .day, value: -1, to: Date())! {
                    self.calendar.select(Methods.transformStringToDate(string: date), scrollToDate: false)
                }
            }
        }
        
        self.calendar.accessibilityIdentifier = "calendar"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.present.refreshDataOf(car: self.car)
    }
    
    func saveDateInfo() {
        if self.rentalType == .daily {
            AlamofireManager.availabilityDailyForCar(car: self.car) { success, error in
                if success {
                    CardeeAlert.showAlert(withTitle: "Success", message: "You changes were succesfully saved", sender: self)
                } else {
                    CardeeAlert.showAlert(withTitle: "Error", message: error!, sender: self)
                }
            }
        } else {
            AlamofireManager.availabilityHourlyForCar(car: self.car) { success, error in
                if success {
                    CardeeAlert.showAlert(withTitle: "Success", message: "You changes were succesfully saved", sender: self)
                } else {
                    CardeeAlert.showAlert(withTitle: "Error", message: error!, sender: self)
                }
            }
        }
    }
    
    // MARK: FSCalendarDataSource
    
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: "cell", for: date, at: position)
        return cell
    }
    
    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at position: FSCalendarMonthPosition) {
        self.configure(cell: cell, for: date, at: position)
    }
    
    // MARK: FSCalendarDelegate
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleOffsetFor date: Date) -> CGPoint {
        return CGPoint(x: 0, y: 3)
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleSelectionColorFor date: Date) -> UIColor? {
        return UIColor.white
    }
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        self.calendar.frame.size.height = bounds.height
    }
    
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        return monthPosition == .current
    }
    
    func minimumDate(for calendar: FSCalendar) -> Date {
        if self.rentalType == .daily {
            return self.gregorian.date(byAdding: .day, value: 1, to: Date())!
        } else {
            return Date()
        }
    }
 
    func calendar(_ calendar: FSCalendar, shouldDeselect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        return monthPosition == .current
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("did select date \(self.formatter.string(from: date))")
        if self.rentalType == .daily {
            self.car.availabilityDailyDates.append(self.formatter.string(from: date))
            self.selectedDaysButton.setTitle("\(self.car.availabilityDailyDates.count) days available  •  Save", for: .normal)
        } else {
            self.car.availabilityHourlyDates.append(self.formatter.string(from: date))
            self.selectedDaysButton.setTitle("\(self.car.availabilityHourlyDates.count) days available  •  Save", for: .normal)
        }
        
        self.configureVisibleCells()
    }
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date) {
        print("did deselect date \(self.formatter.string(from: date))")
        
        if self.rentalType == .daily {
            let index = self.car.availabilityDailyDates.index(of: self.formatter.string(from: date))
            self.car.availabilityDailyDates.remove(at: index!)
        } else {
            let index = self.car.availabilityHourlyDates.index(of: self.formatter.string(from: date))
            self.car.availabilityHourlyDates.remove(at: index!)
        }
        self.selectedDaysButton.setTitle("\(self.car.availabilityDailyDates.count) days available  •  Save", for: .normal)
        self.configureVisibleCells()
    }
    
//    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
//        for currentDate in self.dates {
//            if self.formatter.string(from: date)currentDate == date {
//                return #imageLiteral(resourceName: "check_thick")
//            }
//        }
//        return nil
//    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, imageOffsetFor date: Date) -> CGPoint {
        return CGPoint(x: 10, y: -10)
    }
    
    // MARK: Private functions
    
    private func configureVisibleCells() {
        self.calendar.visibleCells().forEach { (cell) in
            let date = calendar.date(for: cell)
            let position = calendar.monthPosition(for: cell)
            self.configure(cell: cell, for: date, at: position)
        }
    }
    
    private func configure(cell: FSCalendarCell, for date: Date, at position: FSCalendarMonthPosition) {
        
        let diyCell = (cell as! DIYCalendarCell)
        
        // Custom today circle
        
        if self.gregorian.isDateInToday(date) {
            diyCell.layer.borderColor = UIColor.lightGray.cgColor
            diyCell.layer.borderWidth = 0.5
            diyCell.layer.cornerRadius = diyCell.contentView.bounds.width/2
            //diyCell.titleLabel.textColor = Color.grayText
        }

        // Configure selection layer
        
        if position == .current {
            var selectionType = SelectionType.none
            if calendar.selectedDates.contains(date) {
                diyCell.layer.borderWidth = 0
                let previousDate = self.gregorian.date(byAdding: .day, value: -1, to: date)!
                let nextDate = self.gregorian.date(byAdding: .day, value: 1, to: date)!
                if calendar.selectedDates.contains(date) {
                    if calendar.selectedDates.contains(previousDate) && calendar.selectedDates.contains(nextDate) {
                        selectionType = .middle
                    }
                    else if calendar.selectedDates.contains(previousDate) && calendar.selectedDates.contains(date) {
                        selectionType = .rightBorder
                    }
                    else if calendar.selectedDates.contains(nextDate) {
                        selectionType = .leftBorder
                    }
                    else {
                        selectionType = .single
                    }
                }
            } else {
                selectionType = .none
            }
            if selectionType == .none {
                diyCell.selectionLayer.isHidden = true
                return
            }
            diyCell.selectionLayer.isHidden = false
            diyCell.selectionType = selectionType
        } else {
            diyCell.selectionLayer.isHidden = true
        }
        
    }
}
