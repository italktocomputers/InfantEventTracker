/*
Copyright (c) 2022, Andrew Schools <andrewschools@me.com>
Permission is hereby granted, free of charge, to any
person obtaining a copy of this software and associated
documentation files (the "Software"), to deal in the
Software without restriction, including without
limitation the rights to use, copy, modify, merge,
publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the
following conditions:
The above copyright notice and this permission notice
shall be included in all copies or substantial portions
of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*/

import UIKit
import CloudKit

@objc(ViewController)

class ViewController: UIViewController {
    
    @IBOutlet weak var diaperwet_lastTime: UILabel!
    @IBOutlet weak var diaper_lastTime: UILabel!
    @IBOutlet weak var bottle_lastTime: UILabel!
    @IBOutlet weak var sleep_lastTime: UILabel!
    @IBOutlet weak var diaperwet_Button: UIButton!
    @IBOutlet weak var diaper_Button: UIButton!
    @IBOutlet weak var bottle_Button: UIButton!
    @IBOutlet weak var sleep_Button: UIButton!
    
    var store: NSUbiquitousKeyValueStore?
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.title = "Infant Event Tracker";
        
        EventTimes.observeStore(notify: syncTimes)
        syncTimes()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func setTimeForDiaperWet(sender: AnyObject) {
        let date = Date();
        EventTimes.triggerEvent(on: Date(), for: EventType.diaperwet_lastTime)
        updateUI(date: date, label: diaperwet_lastTime)
    }
    
    @IBAction func setTimeForDiaper(sender: AnyObject) {
        let date = Date();
        EventTimes.triggerEvent(on: Date(), for: EventType.diaper_lastTime)
        updateUI(date: date, label: diaper_lastTime)
    }
    
    @IBAction func setTimeForBottle(sender: AnyObject) {
        let date = Date();
        EventTimes.triggerEvent(on: Date(), for: EventType.bottle_lastTime)
        updateUI(date: date, label: bottle_lastTime)
    }
    
    @IBAction func setTimeForSleep(sender: AnyObject) {
        let date = Date();
        EventTimes.triggerEvent(on: Date(), for: EventType.sleep_lastTime)
        updateUI(date: date, label: sleep_lastTime)
    }
    
    func updateUI(date: Date, label: UILabel) {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        let dateString = formatter.string(from: date)
        label.text = dateString
    }
    
    func syncTimes() -> Void {
        EventTimes.sync()
        
        if let lastTime = EventTimes.fetchTime(for: EventType.diaperwet_lastTime) {
            diaperwet_lastTime.text = lastTime
        }
        
        if let lastTime = EventTimes.fetchTime(for: EventType.diaper_lastTime) {
            diaper_lastTime.text = lastTime
        }
        
        if let lastTime = EventTimes.fetchTime(for: EventType.bottle_lastTime) {
            bottle_lastTime.text = lastTime
        }
        
        if let lastTime = EventTimes.fetchTime(for: EventType.sleep_lastTime) {
            sleep_lastTime.text = lastTime
        }
    }
    @IBAction func goToHomePage(_ sender: Any) {
        UIApplication.shared.open(URL(string: "https://github.com/italktocomputers")!)
    }
}

