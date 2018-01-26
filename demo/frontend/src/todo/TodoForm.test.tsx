import * as React from 'react';
import { shallow, ShallowWrapper } from 'enzyme';
import { TodoForm } from './TodoForm';
import { TodoService } from './TodoService';
import * as Sinon from 'sinon';
import { SinonSpy, SinonStub } from 'sinon';
import { TodoItem } from './TodoItem';

describe('TodoForm', () => {
    let callbackSpy: SinonSpy;

    beforeEach(() => {
        callbackSpy = Sinon.spy();
    });

    it('should have a text field', () => {
        const wrapper = shallow(<TodoForm onTodoAdded={callbackSpy}/>);
        expect(wrapper.find('input').exists()).toBeTruthy();
        expect(wrapper.find('input').props().value).toBeFalsy();
    });

    it('should notice input changes', () => {
        const wrapper = shallow(<TodoForm onTodoAdded={callbackSpy}/>);

        wrapper.find('input').simulate('change', {currentTarget: {value: 'TODO'}});

        expect(wrapper.find('input').props().value).toBeTruthy();
    });

    describe('when clicking CREATE', () => {
        let wrapper: ShallowWrapper;
        const TODO_TEXT = 'TODO';
        let createTodoStub: SinonStub;
        let createTodoPromise: Promise<TodoItem>;

        beforeEach(() => {
            createTodoStub = Sinon.stub(TodoService, 'createTodo');
            createTodoPromise = Promise.resolve({text: '', done: false});
            createTodoStub.returns(createTodoPromise);

            wrapper = shallow(<TodoForm onTodoAdded={callbackSpy}/>);
            wrapper.find('input').simulate('change', {currentTarget: {value: TODO_TEXT}});
        });

        afterEach(() => {
            createTodoStub.restore();
        });

        it('should clear the text field', () => {
            wrapper.find('button').simulate('click');

            expect(wrapper.find('input').props().value).toBeFalsy();
        });

        it('should call the update service', () => {
            wrapper.find('button').simulate('click');

            expect(createTodoStub.calledOnce).toBeTruthy();
            expect(createTodoStub.calledWith(TODO_TEXT)).toBeTruthy();
        });

        it('should call the onTodoAdded callback', async () => {
            wrapper.find('button').simulate('click');

            await createTodoPromise;

            expect(callbackSpy.calledOnce).toBeTruthy();
        });
    });

});
