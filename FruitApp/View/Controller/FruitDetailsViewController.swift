//
//  FruitDetailsViewController.swift
//  FruiteApp
//
//  Created by Muneer KK on 07/08/21.
//

import UIKit

class FruitDetailsViewController: UIViewController {
    
    // MARK: - vars
    @IBOutlet weak var textView: UITextView!
    
    var fruit: Fruit?
    
    // MARK: - view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = fruit?.type
        
        textView.text = fruit?.description
        textView.backgroundColor = .white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let property = EventProperty(name: "display", value: "FruitDetails")
        let info = EventProperty(name: "fruit", value: fruit?.type ?? "Unknown")
        FruitAnalytics.trackEvent(event: .display, metaData: [property, info])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
