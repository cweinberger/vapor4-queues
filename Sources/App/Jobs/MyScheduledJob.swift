import Queues
import Vapor

/// A recurring job that will trigger a `SurveyJob`
struct MyScheduledJob: ScheduledJob {
    func run(context: QueueContext) -> EventLoopFuture<Void> {
        context.logger.info("MyScheduledJob triggered")
        return context.queue.dispatch(OutsideJob.self, .init(name: "Christian Weinberger"))
    }
}
