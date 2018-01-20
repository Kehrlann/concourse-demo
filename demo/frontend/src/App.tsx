import * as React from 'react';
import './App.css';
import { TodoList } from './todo/TodoList';
import { TodoService } from './todo/TodoService';
import { TodoItem } from './todo/TodoItem';
import { TodoForm } from './todo/TodoForm';

class App extends React.Component<{}, { todoItems: TodoItem[] }> {
    constructor(props: {}) {
        super(props);

        this.state = {todoItems: []};
    }

    componentDidMount() {
        TodoService.listTodos()
            .then(items => this.setState({todoItems: items}));
    }

    render() {
        return (
            <div className="App">
                <div className="App-header">
                    <h1>TODO all the things !</h1>
                </div>
                <TodoList todos={this.state.todoItems}/>
                <TodoForm/>
            </div>
        );
    }
}

export default App;
