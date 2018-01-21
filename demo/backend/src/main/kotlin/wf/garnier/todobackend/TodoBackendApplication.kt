package wf.garnier.todobackend

import org.springframework.boot.SpringApplication
import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.data.rest.core.config.RepositoryRestConfiguration
import org.springframework.data.rest.webmvc.config.RepositoryRestConfigurerAdapter


@SpringBootApplication
class TodoBackendApplication: RepositoryRestConfigurerAdapter() {
    override fun configureRepositoryRestConfiguration(config: RepositoryRestConfiguration) {
        config.setBasePath("api")
        config.exposeIdsFor(TodoItem::class.java)
    }
}

fun main(args: Array<String>) {
    SpringApplication.run(TodoBackendApplication::class.java, *args)
}
