import * as React from 'react';
import { TodoItem, TodoItemPresenter } from './TodoItem';
import { shallow } from 'enzyme';

describe('TodoItemPresenter', () => {

    it('should have the text', () => {
        const todo: TodoItem = {text: 'This is a todo', done: false};
        const wrapper = shallow(<TodoItemPresenter todo={todo}/>);

        expect(wrapper.text()).toContain(todo.text);
    });

    it('should be marked as "DONE" when TODO is done', () => {
        const todo: TodoItem = {text: 'This is a todo', done: true};
        const wrapper = shallow(<TodoItemPresenter todo={todo}/>);

        expect(wrapper.hasClass('done')).toBeTruthy();
    });

    it('should not be marked as "DONE" when TODO is not done', () => {
        const todo: TodoItem = {text: 'This is a todo', done: false};
        const wrapper = shallow(<TodoItemPresenter todo={todo}/>);

        expect(wrapper.hasClass('done')).toBeFalsy();

    });
});