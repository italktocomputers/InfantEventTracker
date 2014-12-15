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
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "icloudKeyValueChanged:", name: "NSUbiquitousKeyValueStoreDidChangeExternallyNotification", object: nil)
        
        NSUbiquitousKeyValueStore.defaultStore().synchronize()
        
        self.diaperwet_Button.backgroundColor = UIColor.brownColor()
        self.diaper_Button.backgroundColor = UIColor.brownColor()
        self.bottle_Button.backgroundColor = UIColor.grayColor()
        self.sleep_Button.backgroundColor = UIColor.blueColor()
        
        self.store = NSUbiquitousKeyValueStore.defaultStore()
        
        syncTimes()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func setTimeForDiaperWet(sender: AnyObject) {
        var date = NSDate();
        var formatter = NSDateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        let dateString = formatter.stringFromDate(date)
        diaperwet_lastTime.text = dateString
        store!.setString(dateString, forKey: "diaperwet_lastTime")
    }
    
    @IBAction func setTimeForDiaper(sender: AnyObject) {
        var date = NSDate();
        var formatter = NSDateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        let dateString = formatter.stringFromDate(date)
        diaper_lastTime.text = dateString
        store!.setString(dateString, forKey: "diaper_lastTime")
    }
    
    @IBAction func setTimeForBottle(sender: AnyObject) {
        var date = NSDate()
        var formatter = NSDateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        let dateString = formatter.stringFromDate(date)
        bottle_lastTime.text = dateString
        store!.setString(dateString, forKey: "bottle_lastTime")
    }
    
    @IBAction func setTimeForSleep(sender: AnyObject) {
        var date = NSDate()
        var formatter = NSDateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        let dateString = formatter.stringFromDate(date)
        sleep_lastTime.text = dateString
        store!.setString(dateString, forKey: "sleep_lastTime")
    }
    
    func syncTimes() {
        // update any changes from iCloud
        self.store = NSUbiquitousKeyValueStore.defaultStore()
        
        let diaperwet_lastTimeFromCloud = self.store?.objectForKey("diaperwet_lastTime") as String?
        let diaper_lastTimeFromCloud = self.store?.objectForKey("diaper_lastTime") as String?
        let bottle_lastTimeFromCloud = self.store?.objectForKey("bottle_lastTime") as String?
        let sleep_lastTimeFromCloud = self.store?.objectForKey("sleep_lastTime") as String?
        
        if (diaperwet_lastTimeFromCloud != nil) {
            diaperwet_lastTime.text = diaperwet_lastTimeFromCloud
        }
        
        if (diaper_lastTimeFromCloud != nil) {
            diaper_lastTime.text = diaper_lastTimeFromCloud
        }
        
        if (bottle_lastTimeFromCloud != nil) {
            bottle_lastTime.text = bottle_lastTimeFromCloud
        }
        
        if (sleep_lastTimeFromCloud != nil) {
            sleep_lastTime.text = sleep_lastTimeFromCloud
        }
    }
    
    func icloudKeyValueChanged(notification: NSNotification) {
        self.syncTimes()
    }
}

