import * as React from 'react';
import { TodoService } from './TodoService';

export class TodoForm extends React.Component<{}, { value: string }> {

    constructor(props: {}) {
        super(props);

        this.state = {value: ''};
        this.handleChange = this.handleChange.bind(this);
        this.handleClick = this.handleClick.bind(this);
    }

    handleChange(event: React.FormEvent<HTMLInputElement>) {
        this.setState({value: event.currentTarget.value});
    }

    handleClick(event: React.FormEvent<HTMLButtonElement>) {
        TodoService.createTodo(this.state.value);
        this.setState({value: ''});
    }

    render() {
        return (
            <form>
                <input type="text" value={this.state.value} onChange={this.handleChange}/>
                <button type="submit" onClick={this.handleClick}>Create</button>
            </form>
        );
    }
}
