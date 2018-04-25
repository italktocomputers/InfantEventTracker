/*
Copyright (c) 2014, Andrew Schools <andrewschools@me.com>
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
        self.title = "Tracker";
        
        NotificationCenter.default.addObserver(
            forName: NSNotification.Name(
                rawValue: "NSUbiquitousKeyValueStoreDidChangeExternallyNotification"
            ),
            object: nil,
            queue: nil,
            using: { (Notification) -> Void in
                self.syncTimes()
            }
        )
        
        NSUbiquitousKeyValueStore.default.synchronize()
        
        self.diaperwet_Button.backgroundColor = UIColor.brown
        self.diaper_Button.backgroundColor = UIColor.brown
        self.bottle_Button.backgroundColor = UIColor.gray
        self.sleep_Button.backgroundColor = UIColor.blue
        
        self.store = NSUbiquitousKeyValueStore.default
        
        syncTimes()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func setTimeForDiaperWet(sender: AnyObject) {
        let date = Date();
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        let dateString = formatter.string(from: date)
        diaperwet_lastTime.text = dateString
        store?.set(dateString, forKey: "diaperwet_lastTime")
    }
    
    @IBAction func setTimeForDiaper(sender: AnyObject) {
        let date = Date();
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        let dateString = formatter.string(from: date)
        diaper_lastTime.text = dateString
        store?.set(dateString, forKey: "diaper_lastTime")
    }
    
    @IBAction func setTimeForBottle(sender: AnyObject) {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        let dateString = formatter.string(from: date)
        bottle_lastTime.text = dateString
        store?.set(dateString, forKey: "bottle_lastTime")
    }
    
    @IBAction func setTimeForSleep(sender: AnyObject) {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        let dateString = formatter.string(from: date)
        sleep_lastTime.text = dateString
        store?.set(dateString, forKey: "sleep_lastTime")
    }
    
    func syncTimes() {
        // Update any changes from iCloud
        self.store = NSUbiquitousKeyValueStore.default
        
        let diaperwet_lastTimeFromCloud = self.store?.object(
            forKey: "diaperwet_lastTime"
        ) as! String?
        
        let diaper_lastTimeFromCloud = self.store?.object(
            forKey: "diaper_lastTime"
        ) as! String?
        
        let bottle_lastTimeFromCloud = self.store?.object(
            forKey: "bottle_lastTime"
        ) as! String?
        
        let sleep_lastTimeFromCloud = self.store?.object(
            forKey: "sleep_lastTime"
        ) as! String?
        
        if diaperwet_lastTimeFromCloud != nil {
            diaperwet_lastTime.text = diaperwet_lastTimeFromCloud
        }
        
        if diaper_lastTimeFromCloud != nil {
            diaper_lastTime.text = diaper_lastTimeFromCloud
        }
        
        if bottle_lastTimeFromCloud != nil {
            bottle_lastTime.text = bottle_lastTimeFromCloud
        }
        
        if sleep_lastTimeFromCloud != nil {
            sleep_lastTime.text = sleep_lastTimeFromCloud
        }
    }
}

