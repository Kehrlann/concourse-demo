import * as React from 'react';
import { TodoService } from './TodoService';

export class TodoForm extends React.Component<{ onTodoAdded: (() => void)}, { value: string }> {

    constructor(props: { onTodoAdded: (() => void) }) {
        super(props);

        this.state = {value: ''};
        this.handleChange = this.handleChange.bind(this);
        this.handleClick = this.handleClick.bind(this);
    }

    handleChange(event: React.FormEvent<HTMLInputElement>) {
        this.setState({value: event.currentTarget.value});
    }

    handleClick(event: React.FormEvent<HTMLButtonElement>) {
        TodoService.createTodo(this.state.value)
            .then(() => this.props.onTodoAdded());
        this.setState({value: ''});
    }

    render() {
        return (
            <div>
                <h2>New todo :</h2>
                <input type="text" value={this.state.value} onChange={this.handleChange}/>
                <button onClick={this.handleClick}>Create</button>
            </div>
        );
    }
}
