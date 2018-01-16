package wf.garnier.todobackend

import org.springframework.data.repository.PagingAndSortingRepository
import org.springframework.data.rest.core.annotation.RepositoryRestResource

@RepositoryRestResource(path = "todo")
interface TodoRestRepository: PagingAndSortingRepository<TodoItem, Long>