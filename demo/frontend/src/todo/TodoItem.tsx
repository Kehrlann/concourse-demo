import * as React from 'react';
import './TodoItem.css';

export interface TodoItem {
    id?: number;
    text: string;
    done: boolean;
}

export class TodoItemPresenter extends React.Component<{todo: TodoItem}, {}> {
    render() {
        const status = 'todo-item' + (this.props.todo.done ? ' done' : '');
        return <li className={status}>[<span className="cross">x</span>] {this.props.todo.text}</li>;
    }
}
