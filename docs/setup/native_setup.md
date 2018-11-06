# Native Setup

### Git

Git is a distributed version control system. This is how our code is stored and managed. Git can be frustrating, but it is an essential tool. If you want to learn more about Git, a great resource is [Think Like a Git](http://think-like-a-git.net/). If you find yourself in a real git pickle, see ["Oh, shit, git!"](http://ohshitgit.com/). If you have already installed Git as a part of the Docker Toolbox, you don't need to install it again using the following link.

* [Install Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)

### Code Base

You are now ready for the actual **OperationCode Backend** code base.

* The common practice is to make a copy of the GitHub repository you want to work on (known as `forking` the repo), make your changes, and then request to merge those changes back into the project (known as a `pull request`).
* Forking a repo is done through GitHub's web UI. It can be found in the top right corner of the **OperationCode Backend**'s [GitHub](https://github.com/OperationCode/operationcode_backend) page.

* The following commands will pull down the source code from your forked repo.
* Make sure to replace `[YOUR-GITHUB-NAME]` with your GitHub name. (example: https://github.com/iserbit/operationcode_backend.git)

```bash
git clone https://github.com/[YOUR-GITHUB-NAME]/operationcode_backend.git operationcode-upstream
cd operationcode-upstream
git remote add upstream https://github.com/OperationCode/operationcode_backend.git
```

### Ruby Version Manager

RVM is a command-line tool which allows you to easily install, manage, and work with multiple ruby environments.

1. [Install RVM](https://rvm.io/).
2. You may need to restart terminal after the installation for the changes to take effect.
3. Install the ruby version specified in the [`.ruby-version`](/.ruby-version) file. You can check the version by running `ruby -v`
4. Ensure ruby gemset from [`.ruby-gemset`](/.ruby-gemset) is applied. Run `rvm gemset list`. If a different gemset is applied, just run ``dir=`pwd` && cd .. && cd $dir``

### Install Dependencies

1. Install [Bundler](https://bundler.io/) `gem install bundler`
2. Run `bundle install` to install all of the gems in your [Gemfile](Gemfile).
3. Download and install [PostgreSQL](https://www.postgresql.org/download/) if you don't have it already.

#### Database Setup:

1. Run `bin/rails db:create`
2. Run `bin/rails db:migrate`
3. Run `bin/rails db:seed`

### Testing

1. Run `RAILS_ENV=test bin/rails db:test:prepare`
2. Run `bin/rails test`

### Linting

1. Run `rubocop`
2. To autocorrect run `rubocop -a`

#### Running OperationCode Backend:

To run the OperationCode Backend simply type:

```bash
bin/rails s
```

You can now visit any route available from `bin/rails routes`. For example `http://localhost:3000/api/v1/status` and you should see the corresponding data returned.

