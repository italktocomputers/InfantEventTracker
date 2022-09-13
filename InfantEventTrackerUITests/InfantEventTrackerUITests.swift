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

import XCTest

class InfantEventTrackerUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testButtonsHaveCorrectLabels() {
        let app = XCUIApplication()
        app.launch()
        XCTAssert(app.buttons.staticTexts["Diaper Change"].exists)
        XCTAssert(app.buttons.staticTexts["Feed Baby"].exists)
        XCTAssert(app.buttons.staticTexts["Sleep"].exists)
        XCTAssert(app.buttons.staticTexts["Wet Diaper Change"].exists)
    }
    
    func checkLastTimeLabel(app: XCUIApplication, labelIdentifier: String, buttonText: String) {
        let lastTime = app.staticTexts.element(matching: .any, identifier: labelIdentifier).label
        print("last time===========\(lastTime)")
        app.buttons.staticTexts[buttonText].tap()
        let newLastTime = app.staticTexts.element(matching: .any, identifier: labelIdentifier).label
        print("new last time===========\(newLastTime)")
        XCTAssertNotEqual(lastTime, newLastTime)
        checkLastTimeLabelIsDate(lastTime)
        checkLastTimeLabelIsDate(newLastTime)
    }
    
    func checkLastTimeLabelIsDate(_ date: String) {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "hh:mm:ss"
        XCTAssert(dateFormatterGet.date(from: date) != nil)
    }
    
    func testLastTimeLabelsAreUpdated() {
        let app = XCUIApplication()
        app.launch()
        checkLastTimeLabel(app: app, labelIdentifier: "diaperChangeLabel", buttonText: "Diaper Change")
        checkLastTimeLabel(app: app, labelIdentifier: "wetDiaperChangeLabel", buttonText: "Wet Diaper Change")
        checkLastTimeLabel(app: app, labelIdentifier: "bottleLabel", buttonText: "Feed Baby")
        checkLastTimeLabel(app: app, labelIdentifier: "sleepLabel", buttonText: "Sleep")
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
