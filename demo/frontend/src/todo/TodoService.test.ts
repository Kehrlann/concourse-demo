import { TodoService } from './TodoService';
import * as Sinon from 'sinon';
import { SinonStub } from 'sinon';

describe('TodoService', () => {
    let fetchStub: SinonStub;

    beforeEach(() => {
        fetchStub = Sinon.stub(window, 'fetch');
    });

    afterEach(() => {
        fetchStub.restore();
    });

    describe('list todos', () => {
        it('should list all todos', async () => {
            const expectedTodos = [{text: 'test', done: false}, {text: 'todo', done: true}];

            fetchStub.resolves({json: () => Promise.resolve({'_embedded': {todoItems: expectedTodos}})});

            const todos = await TodoService.listTodos();

            expect(fetchStub.calledOnce).toBeTruthy();
            expect(fetchStub.calledWith('/api/todo')).toBeTruthy();
            expect(todos).toEqual(expectedTodos);
        });
    });

    describe('create todo', () => {
        it('should create a todo', async () => {
            const todoText = 'TODO TEXT';
            const expectedTodo = {text: todoText, done: false};

            fetchStub.resolves({json: () => Promise.resolve(expectedTodo)});

            const response = await TodoService.createTodo(todoText);

            expect(fetchStub.calledOnce).toBeTruthy();
            expect(fetchStub.calledWith(
                '/api/todo',
                {method: 'POST', body: `{ "text": "${todoText}" }`, headers: {'Content-type': 'application/json'}}
            )).toBeTruthy();
            expect(response).toEqual(expectedTodo);
        });
    });
});