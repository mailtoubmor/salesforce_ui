import { createElement } from "lwc";
import WireApexDemo from "c/wireApexDemo";
import fetchAllAccounts from "@salesforce/apex/FetAccountDetails.fetchAllAccounts";
const mockGetAccountList = require("./data/accounts.json");

// Mock getAccountList Apex wire adapter
jest.mock(
  "@salesforce/apex/FetAccountDetails.fetchAllAccounts",
  () => {
    const { createApexTestWireAdapter } = require("@salesforce/sfdx-lwc-jest");
    return {
      default: createApexTestWireAdapter(jest.fn())
    };
  },
  { virtual: true }
);

describe("c-wire-apex-demo", () => {
  afterEach(() => {
    // The jsdom instance is shared across test cases in a single file so reset the DOM
    while (document.body.firstChild) {
      document.body.removeChild(document.body.firstChild);
    }
  });

  it('renders 5 records', () => {
    const element = createElement('c-wire-apex-demo', {
      is: WireApexDemo
    });
    document.body.appendChild(element);
      
    // Emit data from @wire
    fetchAllAccounts.emit(mockGetAccountList);
      
    return Promise.resolve().then(() => {
      // Select elements for validation
      const accountElements = element.shadowRoot.querySelectorAll('.para');
      expect(accountElements.length).toBe(mockGetAccountList.length);
      expect(accountElements[0].textContent).toBe(mockGetAccountList[0].Name);
    });
  });
});
