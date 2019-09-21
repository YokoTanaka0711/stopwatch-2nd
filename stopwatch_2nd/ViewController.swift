//
//  ViewController.swift
//  stopwatch_2nd
//
//  Created by 田中陽子 on 2019/09/19.
//  Copyright © 2019 Yoko Tanaka. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{

    var laps:[String]=[]
    
    var timer = Timer()
    var minutes:Int = 0
    var seconds:Int = 0
    var fractions:Int = 0
    
    var stopwatchString:String = ""
    
    var startStopWatch:Bool = true
    var addLap:Bool = false
    
    let stopPic = UIImage(named: "stop")
    let state = UIControl.State.normal

    
    @IBOutlet weak var stopwatchLabel: UILabel!
    @IBOutlet weak var lapsTableView: UITableView!
    @IBOutlet weak var startStopBtn: UIButton!
    @IBOutlet weak var lapResetBtn: UIButton!
    
    @IBAction func startStop(_ sender: Any) {
        
        if startStopWatch == true{
            
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateStopwatch), userInfo: nil, repeats: true)
            
            startStopWatch = false
            
            startStopBtn.setImage(stopPic, for: state)//グローバル変数にいれといてから、やるやり方
            lapResetBtn.setImage(UIImage(named:"lap"), for: .normal)
            
            addLap = true
            
        }else{
            
            timer.invalidate()
            
            startStopWatch = true
            
            startStopBtn.setImage(UIImage(named: "start.png"), for: .normal)
            lapResetBtn.setImage(UIImage(named: "reset.png"), for: .normal)
            
            addLap = false
            
            
        }
        
        
    }
    
    @IBAction func lapReset(_ sender: Any) {
        
        if addLap == true{
            
            laps.insert(stopwatchString, at: 0)
            lapsTableView.reloadData()
            
            
            
        }else{
            
            addLap == false
    
            lapResetBtn.setImage(UIImage(named: "lap.png"), for: .normal)
            
            laps.removeAll(keepingCapacity: false)
            lapsTableView.reloadData()
            
            fractions = 0
            seconds = 0
            minutes = 0
            
            stopwatchString = "00:00.00"
            stopwatchLabel.text = stopwatchString
            
            
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        stopwatchLabel.text = "00:00.00"
    }
    
    @objc func updateStopwatch(){
        
        fractions += 1
        
        if fractions == 100{
            
            seconds += 1
            fractions = 0
        }
        
        if seconds == 60 {
          
            minutes += 1
            seconds = 0
            
        }
        
        let fractionString = fractions > 9 ? "\(fractions)":"0\(fractions)"
        let secondsString = seconds > 9 ? "\(seconds)":"0\(seconds)"
        let minitesString = minutes > 9 ? "\(minutes)":"0\(minutes)"
        
        stopwatchString = "\(minitesString):\(secondsString).\(fractionString)"
        stopwatchLabel.text = stopwatchString
    }
    
    //tableView関数

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style:UITableViewCell.CellStyle.value1, reuseIdentifier: "Cell")
        
        cell.backgroundColor = UIColor(red: 216/255, green: 203/255, blue: 212/255, alpha: 50/100)
        cell.textLabel?.text = "Lap\(laps.count-indexPath.row)"//上にプッシュされるように
        cell.detailTextLabel?.text = laps[indexPath.row]
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return laps.count //ラップの数を反映
        
    }
    
    
    
}

