import * as React from 'react';
import './TodoItem.css';
import { TodoService } from './TodoService';

export interface TodoItem {
    id?: number;
    text: string;
    done: boolean;
}

type TodoItemProps = { todo: TodoItem, onCompleted?: (t: TodoItem) => void };

export class TodoItemPresenter extends React.Component<TodoItemProps, {}> {
    constructor(props: TodoItemProps) {
        super(props);
        this.handleClick = this.handleClick.bind(this);
    }

    handleClick() {
        const todo = this.props.todo;

        if (!todo.done) {
            TodoService.completeTodo(todo.id as number)
                .then(updatedTodo => {
                        if (this.props.onCompleted) {
                            this.props.onCompleted(updatedTodo);
                        }
                    }
                );
        }
    }

    render() {
        const status = 'todo-item' + (this.props.todo.done ? ' done' : '');
        return (
            <li className={status} onClick={this.handleClick}>
                [<span className="cross">x</span>] {this.props.todo.text}
            </li>
        );
    }
}
