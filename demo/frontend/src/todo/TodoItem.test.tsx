import * as React from 'react';
import { TodoItem, TodoItemPresenter } from './TodoItem';
import { shallow } from 'enzyme';
import * as Sinon from 'sinon';
import { SinonStub } from 'sinon';
import { TodoService } from './TodoService';

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

    describe('clicking on a todo', () => {
        let completeStub: SinonStub;

        beforeEach(() => {
           completeStub = Sinon.stub(TodoService, 'completeTodo');
           completeStub.resolves(null);
        });

        afterEach(() => {
            completeStub.restore();
        });

        it('should complete not-done todos', () => {
            const todo: TodoItem = {text: 'This is a todo', done: false, id: 42};
            const wrapper = shallow(<TodoItemPresenter todo={todo}/>);

            wrapper.simulate('click');

            expect(completeStub.calledOnce).toBeTruthy();
            expect(completeStub.calledWith(todo.id)).toBeTruthy();
        });

        it('should not modify done todos', () => {
            const todo: TodoItem = {text: 'This is a todo', done: true, id: 42};
            const wrapper = shallow(<TodoItemPresenter todo={todo}/>);

            wrapper.simulate('click');

            expect(completeStub.notCalled).toBeTruthy();
        });

        it('should call the onComplete handler', async() => {
            const todo: TodoItem = {text: 'This is a todo', done: false, id: 42};
            const completedTodo = Object.assign({}, todo, { done: true });

            const completeResponse = Promise.resolve(completedTodo);
            completeStub.returns(completeResponse);

            const handlerSpy = Sinon.spy();
            const wrapper = shallow(<TodoItemPresenter todo={todo} onCompleted={handlerSpy}/>);

            wrapper.simulate('click');
            await completeResponse;

            expect(handlerSpy.calledOnce).toBeTruthy();
            expect(handlerSpy.calledWith(completedTodo)).toBeTruthy();
        });
    });
});