//
//  HomeViewController.swift
//  SwishBoss
//
//  Created by Timoté Vannier on 04/01/2023.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deliveryTours.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tv_tours.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! ToursTableViewCell
        
        let state = deliveryTours[indexPath.row].state
        cell.setLabelStatus(status: state)
        
        var deliveryDate = deliveryTours[indexPath.row].date
        print(deliveryDate)
        
        let getFormatter = DateFormatter()
        getFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'.000Z'"
        let printFormatter = DateFormatter()
        printFormatter.dateFormat = "dd/MM/yyyy"
        
        if let date = getFormatter.date(from: deliveryDate) {
             deliveryDate = printFormatter.string(from: date)
        }
        
//        let dateString = dateFormatter.string(from: deliveryDate)
        
        cell.setLabelDeliveryDate(date: deliveryDate)

        var name = deliveryTours[indexPath.row].deliverer?.name
        if(name == nil){
            name = "?"
        }
        var firstname = deliveryTours[indexPath.row].deliverer?.firstname
        if(firstname == nil){
            firstname = ""
        }
        
        cell.setLabelDeliverer(name: name!, firstname: firstname!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(self.deliveryTours[indexPath.row].deliverer == nil){
            let alert = UIAlertController(title: "Selectionnez un Livreur", message: nil, preferredStyle: .actionSheet)

            alert.view.addSubview(pickerView)

            pickerView.frame = CGRect(x: 0, y: 30, width: alert.view.bounds.width, height: 500)

            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)

            if let popoverController = alert.popoverPresentationController {
                popoverController.sourceView = self.view // The view to which the popover is anchored
                popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0) // The rect to which the popover is anchored
                popoverController.permittedArrowDirections = [] // The arrow directions allowed for the popover
            }

            present(alert, animated: true, completion: nil)
        } else {
            // TODO: timote
            let controller = DeliveryToursViewController.newInstance(deliveryTour: self.deliveryTours[indexPath.row])
            navigationController?.pushViewController(controller, animated: true)

        }
    }
    var deliveryTourService: DeliveryTourService = DeliveryTourAPIService() // OR ()
    var deliveryTours: [DeliveryTour] = []
    
    var deliverers: Deliverers!
    
    let pickerView = UIPickerView()
    
    @IBOutlet weak var tv_tours: UITableView!
    
    @IBOutlet weak var btn_deliverer: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        self.tv_tours.dataSource = self
        self.tv_tours.delegate = self
        let toursCell = UINib(nibName: "ToursTableViewCell", bundle: nil)
        tv_tours.register(toursCell, forCellReuseIdentifier: "cellID")
        tv_tours.rowHeight = 94.0
        tv_tours.backgroundColor = UIColor(red: 31.0/255, green: 39.0/255, blue: 49.0/255, alpha: 1)
        //tv_tours.layer.cornerRadius = 20
        btn_deliverer.layer.cornerRadius = 5
        
        if(Token.token == ""){
           
            let loginViewController = LoginViewController()

            self.navigationController?.pushViewController(loginViewController, animated: true)
        }else{
            
        }
        
     
    }
    
    
    @IBAction func btnGoToDelivererVC(_ sender: Any) {
        DelivererWebService.getItems(){err, success in
            guard err == nil else {
                print(err)
                return
            }
            guard (success != nil) else {
                return
            }
            DispatchQueue.main.async {
                //print(success)
                let delivererViewController = DelivererViewController.newInstance(deliverers: success!)
                self.navigationController?.pushViewController(delivererViewController, animated: true)
            }
            
        }
    }
    
    @IBAction func btnGoToProofDeliveryVC(_ sender: Any) {
        var parcels : [Parcel] = []
        for deliveryTour in deliveryTours {
            for parcel in deliveryTour.parcels{
                if(parcel.isDelivered == true){
                    parcels.append(parcel)
                }
            }
        }
        let proofDeliveryViewController = ProofDeliveryViewController.newInstance(parcels: parcels)
        self.navigationController?.pushViewController(proofDeliveryViewController, animated: true)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        deliveryTourService.getAll() { error, tours in
            print("HERE")
            guard error == nil else {
                print(error)
                return
            }
            print("TOURS")
            print(tours)
            guard let data = tours else{
                return
            }
            DispatchQueue.main.async {
                self.deliveryTours = data
                self.tv_tours.reloadData()
            }
        }
        
        DelivererWebService.getItems(){err, success in
            guard err == nil else {
                print(err)
                return
            }
            guard (success != nil) else {
                return
            }
            DispatchQueue.main.async {
                //print(success)
                self.deliverers = success!
            }
        }
    }

}

extension HomeViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return deliverers.rowCount
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(deliverers.rows[row].name) \(deliverers.rows[row].firstname)" // set the text for each row
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedOption = "\(deliverers.rows[row].name) \(deliverers.rows[row].firstname)"
        print(selectedOption)
        // TODO: call api ajouter le livreur a la tournee
    }
    
}
