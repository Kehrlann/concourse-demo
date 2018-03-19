import * as React from 'react';
import { TodoService } from './TodoService';

export class TodoForm extends React.Component<{ onTodoAdded: (() => void) }, { value: string }> {

    constructor(props: { onTodoAdded: (() => void) }) {
        super(props);

        this.state = {value: ''};
        this.handleChange = this.handleChange.bind(this);
        this.handleSubmit = this.handleSubmit.bind(this);
    }

    handleChange(event: React.FormEvent<HTMLInputElement>) {
        this.setState({value: event.currentTarget.value});
    }

    handleSubmit(event: React.FormEvent<HTMLFormElement>) {
        TodoService.createTodo(this.state.value)
            .then(() => this.props.onTodoAdded());
        this.setState({value: ''});
        event.preventDefault();
    }

    render() {
        return (
            <form onSubmit={this.handleSubmit}>
                <h2>New todo :</h2>
                <input type="text" value={this.state.value} onChange={this.handleChange}/>
                <button type="submit">Create</button>
            </form>
        );
    }
}
