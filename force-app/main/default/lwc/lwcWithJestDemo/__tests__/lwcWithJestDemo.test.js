import { createElement } from 'lwc';
import LwcWithJestDemo from '../lwcWithJestDemo';
describe('running jest in local for the first time',()=>{
   beforeEach(()=>{
        const component = createElement('c-lwc-with-jest-demo',{
            is : LwcWithJestDemo
        });
        document.body.appendChild(component);
   });

   test('paragraph bind variable testing',()=>{
        const jestDemo = document.querySelector('c-lwc-with-jest-demo');
        const para = jestDemo.shadowRoot.querySelector('p');
        expect(para.textContent).toBe('Hello JEST - Day One');
   });
})