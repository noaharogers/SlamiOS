import UIKit

public class ShowQueueViewController: UIViewController {
    @IBOutlet weak public var currentQueue: UITableView!

    @IBOutlet public weak var refreshQueueButton: UIBarButtonItem!
    @IBOutlet public weak var addMatchToQueueButton: UIBarButtonItem!

    public var queueManager: QueueManager?
    public var queueView: QueueView?

    override public func viewDidLoad() {
        super.viewDidLoad()
        initializeDelegates()
    }

    override public func viewWillAppear(animated: Bool) {
        if (!self.isRunningTests()) {
            refreshQueue()
        }
    }

    public func initializeDelegates() {
        queueView = QueueView(display: currentQueue, onDelete: { (matchId) in
            self.queueManager!.removeMatch(matchId)
        })
        if queueManager == nil {
            queueManager = APIManagedQueue(
                queueView: queueView!
            )
        }
        currentQueue!.dataSource = queueView
    }

    @IBAction public func refreshQueue() {
        disableButtons()
        queueManager!.loadQueue(enableButtons)
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
