import * as React from 'react';
import App from './App';
import * as Sinon from 'sinon';
import { TodoService } from './todo/TodoService';
import { TodoItem } from './todo/TodoItem';
import { shallow } from 'enzyme';
import { TodoList } from './todo/TodoList';

describe('App', () => {
    let todoPromise: Promise<TodoItem[]>;
    const todos = [{text: 'todo', done: true}];

    beforeEach(() => {
        const listTodosStub = Sinon.stub(TodoService, 'listTodos');
        todoPromise = Promise.resolve(todos);
        listTodosStub.returns(todoPromise);
    });

    it('loads the correct todo items', async () => {
        const wrapper = shallow(<App/>);
        await todoPromise;

        wrapper.update();

        const todoList = wrapper.find(TodoList);
        expect(todoList.props().todos).toEqual(todos);
    });
});