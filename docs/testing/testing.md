# Testing the App

This app uses the Minitest gem for testing.

The primary folders in the test directory mirror the real folder structure of the app. The models directory are meant to hold unit tests for models, the controllers dirctory holds unit tests for controllers, etc.

Also included in the test directory are directories for testing plugins; cassettes, factories, and support. Cassettes and Factories hold the files for the VCR and Factory Girl gems respectively. Support holds any support files you need such as helper methods commonly used through out your tests.

## Running Tests

1. Have the [Docker app](https://www.docker.com/) running
2. Run `make setup`
3. Run `make test`

If you need to clean up the test environment, run `make minty-fresh` and you can clean up all images and volumes to ensure a non-persistent state.

## Creating new tests

Tests can be broken up into three parts:

1. Setup - create any elements needed for the test
2. Action - perform the action that you are testing for
3. Expectation - verify the test's result

## Stubbing and Mocking for Tests

Sometimes when writing a unit or integration test you may need to call a method or a class that you are not explicitely testing, or need to guarentee the results of that call. In those cases, you should look at using a stubbed or mocked object.

### Stubbed Objects

These provide canned answers to the methods which are called on them. They return hard coded information in order to reduce test dependencies and avoid time consuming operations.

### Mocked Objects

These are "smart" stubs, their purpose is to verify that some method was called. They are created with some expectations (i.e. expected method calls) and can then be verified to ensure those methods were called.

## VCR and FactoryGirl

Both of these gems are used to perform a series of actions easily and consistently during testing. VCR records all of the test suite's HTTP interactions and allow you to replay them during future test runs for fast, accurate tests. FactoryGirl (also known as FactoryBot in later versions,) is a framework for creating and using factories, a method to build an object that pre-fills defaults so you can create them as needed.

## Other Reading on Testing

- [Rails Guides: Testing Rails Applications](https://guides.rubyonrails.org/testing.html)
- [Minitest Documentation](http://docs.seattlerb.org/minitest/)
- [VCR Documentation](https://relishapp.com/vcr/vcr/docs)
- [FactoryBot Documentation](https://www.rubydoc.info/gems/factory_bot/)
