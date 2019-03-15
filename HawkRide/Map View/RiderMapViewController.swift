//
//  RideMapViewController.swift
//  Hawk Ride
//
//  Created by Gregory Jones on 2/26/19.
//  Copyright © 2019 Gregory Jones. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps

class RiderMapViewController: UIViewController, GMSMapViewDelegate {
    
    // MARK: - Properties
    @IBOutlet weak var mapView: GMSMapView!
    var sidebarView: SidebarView!
    var blackScreen: UIView!
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMapView()
        setupMenuButton()
        setupSideBarView()
        setupBlackScreen()
    }
    
    func setupMapView() {
        mapView.animate(toLocation: CLLocationCoordinate2DMake(39.995256, -75.241579))
        mapView.animate(toZoom: 15)
        mapView.delegate = self
        self.mapView.mapStyle(withFilename: "bright", andType: "json");
    }
    
    func setupMenuButton() {
        let btnMenu = UIButton(frame: CGRect(x: 0.0, y:0.0, width: 18, height: 14))
        btnMenu.setBackgroundImage(UIImage(named:"Menu"), for: .normal)
        btnMenu.addTarget(self, action: #selector(btnMenuAction),for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btnMenu)
    }
    
    func setupSideBarView() {
        sidebarView=SidebarView(frame: CGRect(x: 0, y: 0, width: 0, height: self.view.frame.height))
        sidebarView.delegate=self
        sidebarView.layer.zPosition=100
        self.view.isUserInteractionEnabled=true
        self.navigationController?.view.addSubview(sidebarView)
    }
    
    func setupBlackScreen() {
        blackScreen=UIView(frame: self.view.bounds)
        blackScreen.backgroundColor=UIColor(white: 0, alpha: 0.5)
        blackScreen.isHidden=true
        self.navigationController?.view.addSubview(blackScreen)
        blackScreen.layer.zPosition=99
        let tapGestRecognizer = UITapGestureRecognizer(target: self, action: #selector(blackScreenTapAction(sender:)))
        blackScreen.addGestureRecognizer(tapGestRecognizer)
    }
    
    @objc func btnMenuAction() {
        blackScreen.isHidden=false
        UIView.animate(withDuration: 0.5, animations: {
            self.sidebarView.frame=CGRect(x: 0, y: 0, width: 250, height: self.sidebarView.frame.height)
        }) { (complete) in
            self.blackScreen.frame=CGRect(x: self.sidebarView.frame.width, y: 0, width: self.view.frame.width-self.sidebarView.frame.width, height: self.view.bounds.height+100)
        }
    }
    
    @objc func blackScreenTapAction(sender: UITapGestureRecognizer) {
        blackScreen.isHidden=true
        blackScreen.frame=self.view.bounds
        UIView.animate(withDuration: 0.3) {
            self.sidebarView.frame=CGRect(x: 0, y: 0, width: 0, height: self.sidebarView.frame.height)
        }
    }
   
}


extension RiderMapViewController: SidebarViewDelegate {
   
    
    func sidebarDidSelectRow(row: Row) {
        blackScreen.isHidden=true
        blackScreen.frame=self.view.bounds
        UIView.animate(withDuration: 0.3) {
            self.sidebarView.frame=CGRect(x: 0, y: 0, width: 0, height: self.sidebarView.frame.height)
        }
        switch row {
        case .editProfile:
           let controller = EditProfileController()
           self.navigationController?.pushViewController(controller, animated: true)
            case .rideHistory:
            print("Ride History")
        case .becomeAHawkDriver:
            print("Become a Hawk Driver")
        case .help:
            print("Help")
        case .settings:
            print("Settings")
      case .logOut:
            print("Log out")
        case .none:
            break
            //        default:  //Default will never be executed
            //            break
        }
    }
   
}
    


extension GMSMapView {
    func mapStyle(withFilename name: String, andType type: String) {
        do  {
            if let styleURL = Bundle.main.url(forResource: name, withExtension: type) {
                self.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            }  else {
                NSLog("Unable to find style.join")
            }
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }
    }
}



