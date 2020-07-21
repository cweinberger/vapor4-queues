import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req in
        return "It works!"
    }
    
    app.get("hello") { req in
        return "Hello, world!"
    }

    let todoController = TodoController()
    app.get("todos", use: todoController.index)
    app.post("todos", use: todoController.create)
    app.on(.DELETE, "todos", ":todoID", use: todoController.delete)

    app.get("add-job") { req -> EventLoopFuture<HTTPStatus> in
        app.queues.queue.dispatch(OutsideJob.self, .init(name: "Christian"))
            .transform(to: .ok)
    }
}
