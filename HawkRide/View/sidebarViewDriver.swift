//
//  sidebarViewDriver.swift
//  Hawk Ride
//
//  Created by Gregory Jones on 3/16/19.
//  Copyright © 2019 Gregory Jones. All rights reserved.
//



import UIKit
import Firebase

protocol SidebarDriverViewDelegate: class {
    func sidebarDidSelectRow(rowDriver: RowDriver)
    
    
}

enum RowDriver: String {
    case editProfile
    case rideHistory
    case schedule
    case vehicle
    case becomeAHawkRider
    case help
    case settings
    case logOut
    case pickUpMode
    case none
    
    init(rowDriver: Int) {
        switch rowDriver {
        case 0: self = .editProfile
        case 1: self = .rideHistory
        case 2: self = .schedule
        case 3: self = .vehicle
        case 4: self = .becomeAHawkRider
        case 6: self = .help
        case 7: self = .settings
        case 8: self =  .pickUpMode
        case 9: self = .logOut
        
            
        default: self = .none
        }
    }
}

  class SidebarViewDriver: UIView, UITableViewDelegate, UITableViewDataSource {
    
    var titleArr = [String]()
    let currentUserId = Auth.auth().currentUser?.uid
    
    weak var delegate: SidebarDriverViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor=UIColor(red: 54/255, green: 55/255, blue: 56/255, alpha: 1.0)
        self.clipsToBounds=true
        
        titleArr = ["Greg Jones", "Ride History", "Schedule", "Vehicle", "Become a Hawk Rider","Help", "Settings","",
                "Log out"]
      
        
        setupViews()
        myTableView.delegate=self
        myTableView.dataSource=self
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        myTableView.tableFooterView=UIView()
        myTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        myTableView.allowsSelection = true
        myTableView.bounces=false
        myTableView.showsVerticalScrollIndicator=false
        myTableView.backgroundColor = UIColor.clear
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = .clear
        
        cell.selectionStyle = .none
        if indexPath.row == 0 {
            cell.backgroundColor=UIColor(red: 54/255, green: 55/255, blue: 56/255, alpha: 1.0)
            
            // Profile Image Icon
            let cellImg: UIImageView!
            cellImg = UIImageView(frame: CGRect(x: 13, y: 18, width:60, height: 60))
            cellImg.layer.cornerRadius = 30
            cellImg.layer.masksToBounds=true
            cellImg.contentMode = .scaleAspectFill
            cellImg.layer.masksToBounds=true
            cellImg.image=#imageLiteral(resourceName: "editprofile")
            cell.addSubview(cellImg)
        
            // Ride History Icon
            let cellImg2: UIImageView!
            cellImg2 = UIImageView(frame: CGRect(x: 13, y: 120, width:20, height:20))
            cellImg2.layer.masksToBounds=true
            cellImg2.contentMode = .scaleAspectFill
            cellImg2.layer.masksToBounds=true
            cellImg2.image=#imageLiteral(resourceName: "baseline_history_white_24pt_1x")
            cell.addSubview(cellImg2)
            
            // Schedule Image Icon
            let cellImg3: UIImageView!
            cellImg3 = UIImageView(frame: CGRect(x: 13, y: 180, width:20, height:20))
            cellImg3.layer.masksToBounds=true
            cellImg3.contentMode = .scaleAspectFill
            cellImg3.layer.masksToBounds=true
            cellImg3.image=#imageLiteral(resourceName: "outline_schedule_white_24pt_1x")
            cell.addSubview(cellImg3)
            
            //Vehicle Image Icon
            let cellImg4: UIImageView!
            cellImg4 = UIImageView(frame: CGRect(x: 13, y: 240, width:20, height:20))
            cellImg4.layer.masksToBounds=true
            cellImg4.contentMode = .scaleAspectFill
            cellImg4.layer.masksToBounds=true
            cellImg4.image=#imageLiteral(resourceName: "baseline_time_to_leave_white_24pt_2x")
            cell.addSubview(cellImg4)
            
            // Become a Hawk Rider Image Icon
            let cellImg5: UIImageView!
            cellImg5 = UIImageView(frame: CGRect(x: 13, y: 300, width:20, height:20))
            cellImg5.layer.masksToBounds=true
            cellImg5.contentMode = .scaleAspectFill
            cellImg5.layer.masksToBounds=true
            cellImg5.image=#imageLiteral(resourceName: "outline_accessibility_new_white_24pt_1x")
            cell.addSubview(cellImg5)
            
            // Help Image Icon
            let cellImg6: UIImageView!
            cellImg6 = UIImageView(frame: CGRect(x: 13, y: 360, width:20, height:20))
            cellImg6.layer.masksToBounds=true
            cellImg6.contentMode = .scaleAspectFill
            cellImg6.layer.masksToBounds=true
            cellImg6.image=#imageLiteral(resourceName: "baseline_help_white_24pt_2x")
            cell.addSubview(cellImg6)
            
            // Settings Image Icon
            let cellImg7: UIImageView!
            cellImg7 = UIImageView(frame: CGRect(x: 13, y: 420, width:20, height:20))
            cellImg7.layer.masksToBounds=true
            cellImg7.contentMode = .scaleAspectFill
            cellImg7.layer.masksToBounds=true
            cellImg7.image=#imageLiteral(resourceName: "baseline_settings_white_24dp")
            cell.addSubview(cellImg7)
            
          
            // Go live text
            let cellLb3 = UILabel(frame: CGRect(x: 70, y: 480, width: 250, height: 30))
            cell.addSubview(cellLb3)
            cellLb3.text = "Go Live"
            cellLb3.font = UIFont(name: Fonts.montserratLight, size: 15)
            cellLb3.textColor=UIColor.white
            
          
            // Log out Image Icon
            let cellImg8: UIImageView!
            cellImg8 = UIImageView(frame: CGRect(x: 13, y: 540, width:20, height:20))
            cellImg8.layer.masksToBounds=true
            cellImg8.contentMode = .scaleAspectFill
            cellImg8.layer.masksToBounds=true
            cellImg8.image=#imageLiteral(resourceName: "baseline_clear_white_36pt_1x")
            cell.addSubview(cellImg8)
           
            // User's Profile Name
            let cellLbl = UILabel(frame: CGRect(x: 85, y: cell.frame.height/2-15, width: 250, height: 30))
            cell.addSubview(cellLbl)
            cellLbl.text = titleArr[indexPath.row]
            cellLbl.font = UIFont(name: Fonts.montserratLight, size: 15)
            cellLbl.textColor=UIColor.white
            
            //Go live switch
         /*   let pickupModeSwitch = UISwitch(frame: CGRect(x: 13, y: 400, width: 20, height: 20))
            pickupModeSwitch.isOn = false
         
            pickupModeSwitch.addTarget(self, action: #selector(switchChanged(sender:)), for: UIControl.Event.valueChanged)
            cell.accessoryView = pickupModeSwitch
            
            DataService.instance.REF_DRIVERS.observe(.value) { (snapshot) in
                if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                    for snap in snapshot {
                        if snap.key == Auth.auth().currentUser?.uid  {
                           pickupModeSwitch.isHidden = false
                           
                           let switchStatus = snap.childSnapshot(forPath: kIS_PICKUP_MODE_ENABLED).value as! Bool
                               pickupModeSwitch.isOn = switchStatus
                            
                            
                        }
                    }
                }
            } */
            
            
           /* DataService.instance.REF_USERS.observe(.value, with: { (snapshot) in
                    if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                        for snap in snapshot  {
                            if snap.key == Auth.auth().currentUser?.uid {
                                
                            }
                        }
                    }
                }) */
            
            
            
            
           
            
        
            // Horizontal Line that separates users' profile from the labels
            let label = UILabel()
            label.frame = CGRect(x:1, y:140, width:300, height: 1.0)
            label.backgroundColor = UIColor.lightGray
            self.addSubview(label)
            
        } else {
            
            // Ride History, Schedule, Vehcile, Become a Hawk Rider, Help, Settings, and Log out label
            let cellLb2 = UILabel(frame: CGRect(x: 40, y: cell.frame.height/2-15, width: 250, height: 30))
            cell.addSubview(cellLb2)
            cellLb2.text = titleArr[indexPath.row]
            cellLb2.font = UIFont(name: Fonts.montserratLight, size: 16)
            cellLb2.textColor=UIColor.white
         
            
            
        }
        return cell
       
    }
    
    
    
    
  /*  @objc func switchChanged(sender: UISwitch!) {
       // print("Switch value is \(sender.isOn)")
        if sender.isOn {
  DataService.instance.REF_DRIVERS.child(currentUserId!).updateChildValues([kIS_PICKUP_MODE_ENABLED: true])
        } else {
    DataService.instance.REF_DRIVERS.child(currentUserId!).updateChildValues([kIS_PICKUP_MODE_ENABLED: false])
        }
    } */
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.sidebarDidSelectRow(rowDriver: RowDriver(rowDriver: indexPath.row))
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 100
        } else {
            return 60
        }
    }
    
    func setupViews() {
        self.addSubview(myTableView)
        myTableView.topAnchor.constraint(equalTo: topAnchor).isActive=true
        myTableView.leftAnchor.constraint(equalTo: leftAnchor).isActive=true
        myTableView.rightAnchor.constraint(equalTo: rightAnchor).isActive=true
        myTableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive=true
    }
    
    let myTableView: UITableView = {
        let table=UITableView()
        table.translatesAutoresizingMaskIntoConstraints=false
        return table
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


