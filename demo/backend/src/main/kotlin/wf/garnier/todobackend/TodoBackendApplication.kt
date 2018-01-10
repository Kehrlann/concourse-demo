package wf.garnier.todobackend

import org.springframework.boot.SpringApplication
import org.springframework.boot.autoconfigure.SpringBootApplication

@SpringBootApplication
class TodoBackendApplication

fun main(args: Array<String>) {
    SpringApplication.run(TodoBackendApplication::class.java, *args)
}
