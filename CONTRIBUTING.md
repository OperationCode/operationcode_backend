# Guide To Contribution

Firstly, thank you for considering contributing to our project! It's people like you that make Operation Code such a great community.

The team at Operation Code wants to reiterate that joining our Slack team is the ultimate way to set yourself up for success when contributing to our repository. You can get an invite to our Slack channel by [requesting to join Operation Code](https://operationcode.org/join). Once in our Slack team, simply type: `/open #oc-projects` and then click enter. Feel free to ask for help; everyone is a beginner at first :smile_cat:!

**This guideline is for newer developers, developers who are unfamiliar with the quick start instructions, and developers who are unfamiliar with Ruby. This guide assumes that you only have a passing familiarity with the command line and are comfortable in our OS of choice.**

Reading this entire guide not only helps you contribute successfully into our codebase, it also helps to communicate that you respect the time of the developers managing and developing this open source project. In return, they should reciprocate that respect in addressing your issue, assessing changes, and helping you finalize your pull requests.

We're an open source project and we love to receive contributions from our community — you! There are many ways to contribute, from writing tutorials or blog posts, improving the documentation, submitting bug reports and feature requests or writing code which can be incorporated into the website itself.

Being an open source project involving contributors of varying levels of experience, it's difficult to create a perfect guide. Please note: most of the following instructions are not relevant to many Windows users - you'll need to research the equivalent of each command knowing what terminal you use on your Windows platform.

**Lastly, If an instruction begins with "Run ...", that means to type the text in place of ... within your command line interface.**


## Table Of Contents
- [Git and GitHub](#git-and-github)
	- [Git](#git)
	- [GitHub Workflow](#github-workflow)
- [Explanations](#explanations)
	- [What Is The Front-End?](#what-is-the-front-end)
	- [What Is The Back-End?](#what-is-the-back-end)
	- [What is REST? What is an API?](#what-is-rest-what-is-an-api)
- [Technologies](#technologies)
- [Gems](#gems)
- [Development Workflow](#development-workflow)
	- [Setting Up Your Environment](#setting-up-your-environment)
	- [Finding An Issue](#finding-an-issue)
	- [Returning To Work After A Break](#returning-to-work-after-a-break)
- [API Documentation](#api-documentation)
- [Resources](#resources)
- [Navigating Operating System Differences](#navigating-operating-system-differences)
	- [MacOS](#macos)
	- [Windows](#windows)


## Git and GitHub

### Git

There are many resources in the wild to learn about all forms of version control, including git. If none of the available resources have helped you, please join the `#git` channel on our Slack team for assistance.

### GitHub Workflow

<details>
<summary>Click to Expand</summary>
<ol>
  <li> Before working on an issue, post a comment on the issue asking to claim it. One of our maintainers will assign themselves as a placeholder on the issue, at which point you are good to start working on it. We don't like competition in open source, nor do we enjoy closing pull requests resolving the same issue... Please only work on issues you've claimed, are not assigned, and do not have others waiting to claim.</li>
  <li> Once you've claimed an issue, feel free to <a href="https://help.github.com/articles/fork-a-repo/">fork the repository</a> </li>
  <li> If you follow all of the instructions in the help article above, you'll be able to create a branch. That's <code>git checkout -b YOUR_BRANCH_NAME</code> Note that some companies and organizations have branch-naming conventions - we do not. </li>
  <li> Once you make a branch, you're free to open your preferred text editor and code. If you don't have a preferred text editor, Operation Code recommends <a href="https://code.visualstudio.com/"> Visual Studio Code</a>  (more commonly referred to as "VS Code" and not to be confused with Visual Studio). You'll want to follow along with <a href="#development-workflow">development workflow</a> to see how you should go about coding in the repository.</li>
  <li> When your changes are complete, commit your changes. If you use <code>git commit</code> often, you'll notice your commit is taking longer than usual! That's because we have a "pre-commit hook". This hook is <a href="https://stackoverflow.com/questions/8503559/what-is-linting">linting</a>, formatting (example: changing tabs to spaces), and testing all of your changes. If a test fails, so does the commit. If your code had changes after formatting, you'll need to re-stage those file(s) and use <code> git commit --amend</code> to add the linted/formatted code to your original commit. </li>
  <li> After committing, push your branch to your forked repository. <code>git push -u origin YOUR_BRANCH_NAME</code> should do the trick. </li>
  <li> Create a pull request within two weeks of claiming the issue, <a href="https://help.github.com/articles/creating-a-pull-request-from-a-fork/">using that branch on your fork.</a> You are at risk of being unassigned from the issue otherwise. While we like reserving issues out for others, this is necessary to prevent bogarting.
</ol>
</details>

  ## Explanations

  ### What Is The Front-End?

  When you visit our website you're interacting with two systems, a front-end application and a back-end API. The front-end application is responsible for displaying the "User Interface" - images, text, animations... everything you interact with visually or physically on our web page. Front-end applications are usually written using a combination of HTML, CSS, and JavaScript and utilize one or more frameworks such as [Angular](https://angular.io/), [Vue](https://vuejs.org/), and [React](https://reactjs.org/). We use React.

> "front-end" is synonymous with client, client-side, "the view", and "the UI".

### What Is The Back-End?

The back-end is responsible for providing data for the front-end to display. This sometimes involves processing the data entered into the front-end, and running various jobs like inviting new users to Slack, or signing them up for our newsletter. Our back-end is written in Rails and it's source code can be viewed [here](https://github.com/OperationCode/operationcode_backend). It acts primarily as a "REST API".

> "back-end" is synonymous with server, server-side, and "models & controllers"

### What is REST? What is an API?

[What is REST?](https://www.codecademy.com/articles/what-is-rest)

[What is an API?](https://medium.freecodecamp.org/what-is-an-api-in-english-please-b880a3214a82)

## Technologies

Here is a breakdown and summary of the main technologies our project utilizes in alphabetic order:

- [Ruby](https://www.ruby-lang.org/en/documentation/quickstart/) - The programming language this application is written in.
- [Rails](https://guides.rubyonrails.org) - The web framework we use to interact with ruby. This reduces the amount of boilerplate code and increases developer efficiency [Rails Quickstart](https://www.ruby-lang.org/en/documentation/quickstart/)
- [Active Job](https://guides.rubyonrails.org/v4.2/active_job_basics.html) - Jobs that are performed in the background (Queued, Async) or at time of request (Immediate, Synchronous).
- [Redis](https://redislabs.com/lp/redis-ruby/) - This is how the foreground and background tasks can communicate with each other to ensure that communication problems such as [Two General's Problem](https://en.wikipedia.org/wiki/Two_Generals%27_Problem) doesn't affect the reliability of the system.
- [Docker](https://opensource.com/resources/what-docker) - This is how we ensure that the build artifacts on your system and your system configuration doesn't affect how this is run on any other system.
- [Postgres](https://www.postgresql.org/about/) - Our data is stored in a postgres instance. Locally you can use a containerized postgres.
- Various External [APIs](https://medium.freecodecamp.org/what-is-an-api-in-english-please-b880a3214a82) - Such as Airtable, Slack, Github, Meetup and other operation code resources.
- [Make](https://www.gnu.org/software/make/) - We use various `make` command scripts to ensure you as a user don't have to waste your time. Our <a href="https://github.com/OperationCode/operationcode_backend/blob/master/Makefile">Makefile</a> includes these various scripts.

## Gems

Various modularized ruby packages are used to aid in the development process these so called "gems" can be viewed in our "Gemfile" and more information is found here:

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

## Development Workflow

### Setting Up Your Environment

<details>
  <summary>Click to Expand</summary>
In order to work on the backend of the **Operation Code** site, you will need to install a few things.

There are three options for local setup:

<ul>
  <li> <a href="/docs/setup/docker_setup.md">Docker</a> (recommended)</li>
  <li> <a href="/docs/setup/native_setup.md">Native</a> </li>
  <li> <a href="/docs/setup/aws_vm_setup.md">AWS Virtual Machine</a> </li>
</ul>
</details>

###  Finding An Issue

<details>
  <summary>Click to Expand</summary>
<ul>
<li> Now you have everything setup, you will need to find issues to work on. **Operation Code** uses Github's built in issue tracker. A listing of all our issues can be found <a href="https://github.com/OperationCode/operationcode_backend/issues">here</a></li>

<li>Familiarize yourself with the issue types below, and browse for an issue that you want to work on. Don't be afraid to ask for clarification or help. </li>

<li> Once you have found an issue, leave a comment stating that you plan to work on the issue. Once assigned to you, your mission is a go! </li>

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

</details>

### Returning To Work After A Break

<details>
  <summary>Click to Expand</summary>
Some issues take awhile to code a solution for. It is very normal to take a large amount of time to turn in well-written work that resolves an issue! In the meantime, there could be many other people contributing to the code base. Since we use Git, you'll want to keep you project up-to-date with the `master` branch so there are no [merge conflicts](https://help.github.com/articles/about-merge-conflicts/) to resolve when you make your pull request.
<ol>
  <li> <a href="https://help.github.com/articles/syncing-a-fork/">Keep your fork in sync with Operation Code's master branch.</a></li>
  <li> Run <code>make minty-fresh</code> to perform a complete reset of dependencies and build. </li>
</ol>
</details>

## API Documentation

We are using [Apiary.io](http://docs.operationcodeapi.apiary.io) for documentation. Any change to the API requires updating the documentation. This is to assist users in the future. To use, navigate to http://docs.operationcodeapi.apiary.io.

Example use:

- You want to gather all CodeSchool Members. Click on `CodeSchool | Collection` on the left-hand side.
- Select `List All CodeSchool Members`. A form will populate.
- You can switch to an Example Code in the language of your choosing. More than likely it will be JavaScript on the front-end.
- In the drop-down menu, select `Mock Server` and click on `Try`. You will see a `GET` request with the mock endpoint url.
- You can now copy and paste that into your front-end to test your code.
- Don't forget to remove the mock endpoint url when committing your changes for production. Reset your values and select `Production` to get the correct endpoint url.


## Resources

- [Operation Code Backend API Endpoints](http://docs.operationcodeapi.apiary.io/#)
- [An introduction to Git: what it is, and how to use it](https://medium.freecodecamp.org/what-is-git-and-how-to-use-it-c341b049ae61)
- [How to use Git efficiently – freeCodeCamp.org](https://medium.freecodecamp.org/how-to-use-git-efficiently-54320a236369?source=linkShare-e41cd5edcdac-1535829065)

## Navigating Operating System Differences

### MacOS


<details>
  <summary>Click to Expand</summary>

#### Update Your Mac

If possible, we highly recommend updating to the latest version of MacOS.
- [Apple instructions to Upgrade MacOS](http://www.apple.com/macos/how-to-upgrade/)

If your machine has limitations on the operating system it can run, know that our development has been tested and works on **MacOSX Yosemite v10.10.5**. If you are utilizing an older version of MacOSX, we ask that you continue to progress through the tutorials and let us know if everything works out okay for you. We're interested in finding the oldest Mac Operating System required to develop on this project, but it is difficult to test.

Please file an issue to update this README.md if you use an older OS and were able to navigate installation instructions.

#### Xcode Command Line Tools

If you have xcode installed ensure that it is updated to the latest version through the app store.  The full xcode package is not required for the command line tools.

Running the following in your terminal window should prompt you to install the xcode command line tools if you don't already have it installed.

```
gcc
```

You can verify installation with the command below, you should see similar output:

```
gcc --version
Configured with: --prefix=/Library/Developer/CommandLineTools/usr --with-gxx-include-dir=/usr/include/c++/4.2.1
Apple LLVM version 6.0 (clang-600.0.54) (based on LLVM 3.5svn)
Target: x86_64-apple-darwin14.0.0
Thread model: posix
```

- [A guide to installing xcode command line tools](http://railsapps.github.io/xcode-command-line-tools.html)

#### Homebrew

- [Homebrew website](https://brew.sh/)
- Paste the code below into a terminal window to install homebrew.

```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

#### Git

The easiest way to install git is with homebrew.

```
brew install git
```

You can also install Github Desktop for the Graphical interface into github.  There is no need to install the Command Line tools if you installed git with homebrew.

- [Github Desktop](https://desktop.github.com/)

</details>

### Windows

<details>
  <summary>Click to Expand</summary>

#### Git
- Install the full version of [CMDER](http://cmder.net/). This is a versatile terminal that wraps bash-like commands around Command Prompt by using Git for Windows. You have many options for getting Git on Windows.  We recommend using Git for Windows as it gives you a bash shell which can be very powerful and help you start to learn linux commands.

Follow the steps found in the [Quick Start Guide](https://github.com/OperationCode/front-end/blob/master/Dockerfile)

Occasionally you will deal with path issues this is fixed within windows by adding the appropriate key value pair to the path.

To add them in your path, you can go to your Control Panel by clicking on the `Start` > type in: `Control Panel` > click on `System and Security` > click on `System` > on the left hand side, click on `Advanced System Settings` > near the bottom of the window, click on the `Environment Variables` and then under the `User variables for {USER}` click on the `Path` table and click on `Edit..`.

Now add those paths one at a time that are listed above into your user environment path if they are not already there. This is assuming you are installing in the default folders during the installation of the programs used on the front-end.

You can also install Github Desktop for a GUI Interface to Github.  If you do this you don't want to install the Command Line tools, as CMDER and Git For Windows are more recent versions.

- [Github for Desktop](https://desktop.github.com/)

#### Ruby and Rails
// TODO: include local setup for these
</details>


### Linux

<details>
  <summary>Click to Expand</summary>
</details>
