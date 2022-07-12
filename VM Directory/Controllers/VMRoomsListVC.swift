//
//  VMRoomsListVC.swift
//  VM Directory
//
//  Created by Eldho on 10/07/22.
//

import UIKit
import SVProgressHUD

class VMRoomsListVC: UIViewController {

    @IBOutlet weak var roomsTable: UITableView!
    
    var roomsArray = [RoomsModel]()
    var isAscending = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialiseView()
        
    }
    
    func initialiseView(){
        
        roomsTable.dataSource = self
        roomsTable.delegate = self
        getRoomsList()
    }
    
    @IBAction func refreshButtonAction(_ sender: UIBarButtonItem) {
        isAscending = false
        getRoomsList()
    }
    @IBAction func sortButtonAction(_ sender: UIBarButtonItem) {
        if isAscending{
            isAscending = false
            roomsArray = roomsArray.sorted(by: { $0.isOccupied && !$1.isOccupied })
        }else{
            isAscending = true
            roomsArray = roomsArray.sorted(by: { !$0.isOccupied && $1.isOccupied })
        }
        roomsTable.reloadData()
    }
}

extension VMRoomsListVC : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roomsArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VMRoomsListTCell") as! VMRoomsListTCell
        
        let data = roomsArray[indexPath.row]
        cell.roomIdLabel.text = "Room Id: \(data.id ?? "")"
        cell.maxOccupencyLabel.text = "Maximum occupancy: \(data.maxOccupancy ?? 0)"
        
        if data.isOccupied == true{
            cell.availabilityIndicatorView.backgroundColor = .red
            cell.roomStatusLabel.text = "Status: Occupied"
        }else{
            cell.availabilityIndicatorView.backgroundColor = .green
            cell.roomStatusLabel.text = "Status: Not Occupied"
        }
        return cell
    }
}

extension VMRoomsListVC{
    
    func getRoomsList(){
        
        SVProgressHUD.show()
        
        VMWebServices.shared.getRoomsList{
            (data, isError, isNetworkError, isGoToLogin, isMaintenance) in
            
            SVProgressHUD.dismiss()
            
            if isMaintenance{
                VMUtilities.shared.showAlertWithTitle(title: VMTitles.error, andMessage: VMAlerts.server_is_under_maintenance, inView: self)
                return
            }
            
            if isGoToLogin
            {
                print("Login expired")
                
                return
            }
            
            if  isNetworkError{
                VMUtilities.shared.showAlertWithTwoFunctionality(message: VMAlerts.no_internet, title: VMTitles.error, view: self, buttonOneTitle: VMAlertButtons.cancel, fucntionOne: {
                    
                }, buttonTwoTitle: VMAlertButtons.try_again) {
                    self.getRoomsList()
                }
                return
                
            }
            
            
            if let responseArray = data as? [[String : Any]]{
                print(responseArray)
                self.roomsArray.removeAll()
                for response in responseArray {
                    if let user = RoomsModel(JSON: response){
                        self.roomsArray.append(user)
                    }
                }
                self.roomsTable.reloadData()
            }
        }
    }
}
