import * as React from 'react';
import { shallow, ShallowWrapper } from 'enzyme';
import { TodoForm } from './TodoForm';
import { TodoService } from './TodoService';
import * as Sinon from 'sinon';

describe('TodoForm', () => {
    it('should have a text field', () => {
        const wrapper = shallow(<TodoForm/>);
        expect(wrapper.find('input').exists()).toBeTruthy();
        expect(wrapper.find('input').props().value).toBeFalsy();
    });

    it('should notice input changes', () => {
        const wrapper = shallow(<TodoForm/>);

        wrapper.find('input').simulate('change', {currentTarget: {value: 'TODO'}});

        expect(wrapper.find('input').props().value).toBeTruthy();
    });

    describe('when clicking CREATE', () => {
        let wrapper: ShallowWrapper;
        const TODO_TEXT = 'TODO';

        beforeEach(() => {
            wrapper = shallow(<TodoForm/>);
            wrapper.find('input').simulate('change', {currentTarget: {value: TODO_TEXT}});
        });

        it('should clear the text field', () => {
            wrapper.find('button').simulate('click');

            expect(wrapper.find('input').props().value).toBeFalsy();
        });

        it('should call the update service', () => {
            const createTodoSpy = Sinon.spy(TodoService, 'createTodo');
            wrapper.find('button').simulate('click');

            expect(createTodoSpy.calledOnce).toBeTruthy();
            expect(createTodoSpy.calledWith(TODO_TEXT)).toBeTruthy();
        });
    });
});