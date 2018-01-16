package wf.garnier.todobackend

import com.jayway.jsonpath.JsonPath
import org.assertj.core.api.Assertions.assertThat
import org.junit.Test
import org.junit.runner.RunWith
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.boot.test.context.SpringBootTest
import org.springframework.boot.test.web.client.TestRestTemplate
import org.springframework.test.context.junit4.SpringRunner

@RunWith(SpringRunner::class)
@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
class TodoRestRepositoryTests {

    @Autowired
    lateinit var client: TestRestTemplate

    @Autowired
    lateinit var repo: TodoRestRepository

    @Test
    fun `it loads todos`() {
        val items = listOf(TodoItem(), TodoItem())
        repo.save(items)

        val result = client.getForObject("/api/todo", String::class.java)

        val numerOfTodos: Int = JsonPath.read(result, "$._embedded.todoItems.length()")
        assertThat(numerOfTodos).isEqualTo(items.size)
    }

}
