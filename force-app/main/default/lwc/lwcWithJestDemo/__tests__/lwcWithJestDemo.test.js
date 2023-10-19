import { createElement } from "lwc";
import LwcWithJestDemo from "../lwcWithJestDemo";

async function flushPromises() {
  return Promise.resolve();
}

describe("running jest in local for the first time", () => {
  beforeEach(() => {
    const component = createElement("c-lwc-with-jest-demo", {
      is: LwcWithJestDemo
    });
    document.body.appendChild(component);
  });

  test("paragraph bind variable testing", () => {
    const jestDemo = document.querySelector("c-lwc-with-jest-demo");
    const para = jestDemo.shadowRoot.querySelector("p");
    expect(para.textContent).toBe("Hello JEST - Day One");
  });

  test("onlcick to show para", () => {
    const jestDemo = document.querySelector("c-lwc-with-jest-demo");
    const newPara = jestDemo.shadowRoot.querySelector(".newPara");
    expect(newPara.textContent).toBe("Hello JEST - Day One");
  });

  test("To Test Button Click", () => {
    const jestDemoNew = document.querySelector("c-lwc-with-jest-demo");
    const btn = jestDemoNew.shadowRoot.querySelectorAll("lightning-button");
    console.log(btn);
    expect(btn.length).toBe(1);
    btn[0].dispatchEvent(new CustomEvent("click"));
    return Promise.resolve().then(() => {
      const newPara = jestDemoNew.shadowRoot.querySelector(".newPara");
      expect(newPara.textContent).toBe("data changed");
    });
  });
});
