import * as React from 'react';
import { TodoItem, TodoItemPresenter } from './TodoItem';

export class TodoList extends React.Component<{ todos: TodoItem[], onCompleted?: (t: TodoItem) => void }, {}> {
    render() {
        const todoList = this.props.todos.map(t =>
            <TodoItemPresenter todo={t} key={t.id} onCompleted={this.props.onCompleted}/>
        );
        return (
            <div className="todo-wrapper">
                <ul>
                    {todoList}
                </ul>
            </div>
        );
    }
}
