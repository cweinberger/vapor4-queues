import Fluent
import FluentPostgresDriver
import QueuesFluentDriver
import Vapor

// Called before your application initializes.
public func configure(_ app: Application) throws {
    app.databases.use(
        .postgres(
            hostname: "db",
            port: 5432,
            username: "vapor_username",
            password: "vapor_password",
            database: "vapor_database"
        ),
        as: .psql
    )

    app.migrations.add(CreateTodo())
    app.migrations.add(JobModelMigrate())

    try app.autoMigrate().wait()

    app.queues.use(.fluent())
    app.queues.add(OutsideJob())
    app.queues.add(InsideJob())

    try app.queues.startInProcessJobs(on: .default)
    try app.queues.startScheduledJobs()

    app.queues.schedule(MyScheduledJob()).minutely().at(0)

    try routes(app)
}
