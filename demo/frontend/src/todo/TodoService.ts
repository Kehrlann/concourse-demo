import { TodoItem } from './TodoItem';

const API_ENDPOINT = '/api/todo';

export class TodoService {
    static listTodos(): Promise<TodoItem[]> {
        return fetch(API_ENDPOINT)
            .then(resp => resp.json())
            // tslint:disable-next-line:no-string-literal
            .then(json => json['_embedded'].todoItems)
            .catch(e => []);
    }

    static createTodo(text: string) {
        // TODO: fix me
    }
}
