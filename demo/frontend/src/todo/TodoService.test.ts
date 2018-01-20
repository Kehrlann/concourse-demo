import { TodoService } from './TodoService';
import * as Sinon from 'sinon';

describe('TodoService', () => {
    describe('list todos', () => {
        it('should list all todos', async () => {
            const fetchStub = Sinon.stub(window, 'fetch');
            const expectedTodos = [{text: 'test', done: false}, {text: 'todo', done: true}];

            fetchStub.resolves({json: () => Promise.resolve({'_embedded': {todoItems: expectedTodos}})});

            const todos = await TodoService.listTodos();

            expect(todos).toEqual(expectedTodos);
        });
    });
});
