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

import WatchKit
import Foundation
import UIKit


class InterfaceController: WKInterfaceController {
    let viewModel = ViewModel()
    @IBOutlet weak var diaperChangeButton: WKInterfaceButton!
    @IBOutlet weak var feedBabyButton: WKInterfaceButton!
    @IBOutlet weak var sleepButton: WKInterfaceButton!
    @IBOutlet weak var wetDiaperChangeButton: WKInterfaceButton!
    
    func delayButtonEnable(button: WKInterfaceButton) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 60 * 2) {
            button.setEnabled(true)
        }
    }

    override func awake(withContext context: Any?) {
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
    }

    @IBAction func diaperChange() {
        let date = Date();
        viewModel.saveAction(on: date, for: EventType.diaper_lastTime)
        diaperChangeButton.setEnabled(false)
        delayButtonEnable(button: self.diaperChangeButton)
    }
    
    @IBAction func bottle() {
        let date = Date();
        viewModel.saveAction(on: date, for: EventType.bottle_lastTime)
        feedBabyButton.setEnabled(false)
        delayButtonEnable(button: self.feedBabyButton)
    }
    
    @IBAction func didSleep() {
        let date = Date();
        viewModel.saveAction(on: date, for: EventType.sleep_lastTime)
        sleepButton.setEnabled(false)
        delayButtonEnable(button: self.sleepButton)
    }
    
    @IBAction func wetDiaperChange() {
        let date = Date();
        viewModel.saveAction(on: date, for: EventType.diaperwet_lastTime)
        wetDiaperChangeButton.setEnabled(false)
        delayButtonEnable(button: self.wetDiaperChangeButton)
    }
}
