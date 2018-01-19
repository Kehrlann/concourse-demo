import * as React from 'react';

export interface TodoItem {
    id?: number;
    text: string;
    done: boolean;
}

export class TodoItemPresenter extends React.Component<{todo: TodoItem}, {}> {
    render() {
        const status = this.props.todo.done ? '[x]' : '[ ]';
        return <li>{status} {this.props.todo.text}</li>;
    }
}