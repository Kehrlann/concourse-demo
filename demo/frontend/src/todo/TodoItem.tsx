import * as React from 'react';

export interface TodoItem {
    text: string;
    done: boolean;
}

export class TodoItemPresenter extends React.Component<{todo: TodoItem}, {}> {
    render() {
        const status = this.props.todo.done ? '[x]' : '[ ]';
        return <li>{this.props.todo.text} {status}</li>;
    }
}