import * as React from 'react';
import { shallow } from 'enzyme';
import { TodoList } from './TodoList';
import { TodoItem, TodoItemPresenter } from './TodoItem';

describe('TodoList', () => {
    it('should display a todo', () => {
        const todo: TodoItem = {text: 'todo', done: false, id: 1};
        const wrapper = shallow(<TodoList todos={[todo]}/>);

        const presenter = wrapper.find(TodoItemPresenter);

        expect(presenter.props().todo).toEqual(todo);
    });

    it('should render all todos', () => {
        const todos: TodoItem[] = [
            {text: 'todo', done: false, id: 1},
            {text: 'todo', done: false, id: 2},
            {text: 'todo', done: false, id: 3}
            ];
        const wrapper = shallow(<TodoList todos={todos}/>);

        const presenter = wrapper.find(TodoItemPresenter);

        expect(presenter.length).toEqual(3);
    });
});