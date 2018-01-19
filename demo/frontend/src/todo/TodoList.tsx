import * as React from 'react';
import { TodoItem, TodoItemPresenter } from './TodoItem';

export class TodoList extends React.Component<{ todos: TodoItem[] }, {}> {
    render() {
        const todoList = this.props.todos.map(t => <TodoItemPresenter todo={t} key={t.id}/>);
        return (
            <div className="todo-wrapper">
                <ul>
                    {todoList}
                </ul>
            </div>
        );
    }
}