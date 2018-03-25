# OperationCode Backend

[![Build Status](https://travis-ci.org/OperationCode/operationcode_backend.svg?branch=master)](https://travis-ci.org/OperationCode/operationcode_backend) [![View performance data on Skylight](https://badges.skylight.io/status/0iQU6bEW8ha1.svg)](https://oss.skylight.io/app/applications/0iQU6bEW8ha1)

## Contributing to Operation Code

So, you want to learn how to program? Contributing to Operation Code is a great place to get started. This document will help you march from zero to deploying code in no time!

## Table of Contents
1. [Technologies Used](#operation-code-technologies)
2. [Quickstart](#quickstart)
3. [Setting Up Your Environment](#setting-up-your-environment)
4. [Finding an Issue](#finding-an-issue)
5. [Working on Your Issue](#working-on-your-issue)
6. [Submitting Your Changes](#submitting-your-changes)
7. [Code of Conduct](#code-of-conduct)

## Operation Code Technologies

The Operation Code site is comprised of a Rails API backend, and a React frontend.

#### What is a frontend?

When you visit our website you're interacting with two systems, a frontend application and a backend application. The frontend application is responsible for displaying images, text and data on our web pages.

Frontend applications are usually written using a combination of HTML, CSS, and Javascript and utilize one or more frameworks such as Angular, Backbone, Vue, and React.

https://operationcode.org uses React and can be viewed at https://github.com/OperationCode/operationcode_frontend.

#### What is a backend?

The backend (where you are now) is responsible for:

- exchanging data with the frontend via custom API endpoints
- running various background jobs like inviting new users to Slack, or signing them up for our newsletter
- interacting with third party services like SendGrid, GitHub and ID.me
- validating the integrity of our data
- authentication and security protocols
- and more

As a contributor to the https://operationcode.org backend, you will have the opportunity to work with the following technologies, services, and popular gems:

- [Ruby](https://www.ruby-lang.org/en/)
- [Ruby on Rails](http://rubyonrails.org/)
- [Redis](https://redis.io/)
- [PostgreSQL](https://www.postgresql.org/)
- [Docker](https://www.docker.com/)
- [GitHub](https://github.com/)
- [Travis CI](https://travis-ci.org/)
- [Code Climate](https://codeclimate.com/)
- [Apiary.io](https://apiary.io/)
- [Devise](https://github.com/plataformatec/devise)
- [Geocoder](https://github.com/alexreisner/geocoder)
- [ActsAsTaggableOn](https://github.com/mbleigh/acts-as-taggable-on)
- [JWT](https://github.com/jwt/ruby-jwt)
- [HTTParty](https://github.com/jnunemaker/httparty)

## Quickstart
1. [Setting Up Your Environment](#setting-up-your-environment)
2. [Find an Issue To Work On](#finding-an-issue)
3. [Submit Your Pull Request](#submitting-your-changes)

## Setting Up Your Environment
In order to work on the backend of the **Operation Code** site, you will need to install a few things.

There are three options for local setup:

- [Docker](/docs/setup/docker_setup.md) (recommended)
- Native (coming soon)
- [AWS Virtual Machine](/docs/setup/aws_vm_setup.md)

## Finding An Issue
* Now you have everything setup, you will need to find issues to work on. **Operation Code** uses Github's built in issue tracker. A listing of all our issues can be found [here](https://github.com/OperationCode/operationcode_backend/issues).

* Familiarize yourself with the issue types below, and browse for an issue that you want to work on. Don't be afraid to ask for clarification or help.

* Once you have found an issue, leave a comment stating that you plan to work on the issue. Once assigned to you, your mission is a go!

### Issue Types
Issue types are managed through labels. The below labels help us easily identify and manage issues with different workflows.

#### [Bug](https://github.com/OperationCode/operationcode_backend/issues?q=is%3Aopen+is%3Aissue+label%3A%22Type%3A+Bug%22)
Bugs are errors in code that produce unintended or unexpected results. In addition to the `bug` label, there may also be a tag indicating what the bug affects. For example [issue#124](https://github.com/OperationCode/operationcode/issues/124) was a bug that affected the testing environment.

#### [Feature](https://github.com/OperationCode/operationcode_backend/issues?q=is%3Aissue+is%3Aopen+label%3A%22Type%3A+Feature%22)
Features either add new functionality or improve existing functionality.

#### [Beginner friendly](https://github.com/OperationCode/operationcode_backend/issues?q=is%3Aopen+is%3Aissue+label%3A%22beginner+friendly%22)
These items are hand picked as being great candidates as your first issue to work on.

#### [Roadmap](https://github.com/OperationCode/operationcode/projects/4)
High level overview of upcoming Operation Code goals.  This is the source of upcoming issues.

## Working On Your Issue

* Please first **read** Operation Code's [guidelines for working an issue](https://github.com/OperationCode/operationcode/blob/master/CONTRIBUTING.md#guidelines-for-working-an-issue)

* From the forked and cloned repository on your environment, you can now create a [feature branch](http://nvie.com/posts/a-successful-git-branching-model/). It is a good idea to name your branch after the issue it is attached to.

   ```bash
   git checkout -b <feature-branch-name>
   ```

* You can check the branch your are currently working on by using the `branch` command.
  ```bash
  git branch
  ```

* Once you have finished your work, head over to **Operation Code**'s main GitHub page, and make a pull request. More information about pull requests can be found in the next section.

* To return to your main `master` branch, type the following in the terminal:
  ```bash
  git checkout master
  ```
## API Documentation

We use [Apiary](https://apiary.io/) for our API documentation, API mocking server, etc.

The API blueprint file is located at [/operationcode_backend/apiary.apib](https://github.com/OperationCode/operationcode_backend/blob/master/apiary.apib), and our live API documentation itself is located at http://docs.operationcodeapi.apiary.io/

Please ensure that any PRs that change the behavior of the API are updated in the documentation as well. To do so:

- Create a free account at [apiary.io](https://apiary.io/)
- Make your additions in the repository's `apiary.apib` file in your text editor
- Cut & paste the *whole* file into [the apiary editor](https://help.apiary.io/tools/apiary-editor/) to confirm that all of these changes do not create any **semantic issues**
- Repeat until there are no semantic errors
- Commit the `apiary.apib` file as part of a normal commit in your pull request
- The API endpoints are alphabetized, so all additions will need to be placed accordingly


## Submitting Your Changes
* When you have completed work on your feature branch, you are ready to submit a [pull request](https://help.github.com/articles/using-pull-requests/).

* Each pull request should:

  * Be tied to a single issue
  * Be named after the issue with the designated issue # as the name of the branch
  * Be fully tested
  * Have its own tests
  * Not break existing tests

* Once your pull request has been submitted, it will be reviewed by a core team member. This process helps to familiarize more people with the codebase, and provides a second set of eyes and perspective to your new feature.

* If your code is accepted, it will be merged into the `master` branch. If all the tests pass, it will be automatically deployed to [operationcode.org](operationcode.org) immediately.

* Congratulations! You have made your first contribution!

### Bots

Each pull request is inspected by the following bots:

* [CodeClimate](https://codeclimate.com) - Checks for style validation errors, insecure and problematic code on pull requests.

* [Travis](https://travis-ci.org/) - Runs the test suite on each check in, and deploys each change that gets merged.

## Code of Conduct

Please read through and adhere to our [code of conduct](https://github.com/OperationCode/operationcode_backend/blob/master/CODE_OF_CONDUCT.md) at all times.

## Code Standards

### Ruby

[Adhere to the Ruby Style Guide](https://github.com/bbatsov/ruby-style-guide)

### JS

[Adhere to the Google JS Style Guide](https://google.github.io/styleguide/jsguide.html)

## License

By contributing your code, you agree to license your contribution under the [MIT License](LICENSE).

By contributing to the code base, you agree to license your contribution under the [Creative Commons Attribution 3.0 Unported License](docs/LICENSE).
