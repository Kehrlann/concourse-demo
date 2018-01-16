package wf.garnier.todobackend

import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id

@Entity
data class TodoItem(@Id @GeneratedValue val id: Long = 0L, val text: String = "", val done: Boolean = false)