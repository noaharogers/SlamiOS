import UIKit

public class ShowQueueViewController: UIViewController {
    @IBOutlet weak public var currentQueue: UITableView!

    @IBOutlet public weak var refreshQueueButton: UIBarButtonItem!
    @IBOutlet public weak var addMatchToQueueButton: UIBarButtonItem!

    public var queueManager: QueueManagerProtocol?
    public var queue: QueueView?

    override public func viewDidLoad() {
        super.viewDidLoad()
        initializeDelegates()
        if (!self.isRunningTests()) {
            refreshQueue()
        }
    }

    public func initializeDelegates() {
        queue = QueueView(display: currentQueue)
        queueManager = QueueManager(queueView: queue!)
        currentQueue!.dataSource = queue
    }

    func refreshQueue() {
        queueManager!.loadQueue()
    }


    @IBAction public func clickRefreshQueue(sender: AnyObject) {
        disableButtons()
        queueManager!.reloadQueue(enableButtons)
    }

    public func enableButtons() {
        refreshQueueButton.enabled = true
        addMatchToQueueButton.enabled = true
    }

    public func disableButtons() {
        refreshQueueButton.enabled = false
        addMatchToQueueButton.enabled = false
    }

    @IBAction func cancelAddMatch(segue:UIStoryboardSegue) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    private func isRunningTests() -> Bool {
        let environment = NSProcessInfo.processInfo().environment
        let injectBundle = environment["XCInjectBundle"] as! String?
        if let pathExtension = injectBundle?.pathExtension {
            return pathExtension == "xctest"
        } else {
            return false
        }
    }
}
