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

#### Local Development Environment
_Fork the repo first._
```bash
git clone https://github.com/[YOUR-GITHUB-NAME]/operationcode_backend.git operationcode-upstream
cd operationcode-upstream
git remote add upstream https://github.com/OperationCode/operationcode_backend.git
```

1. If [Bundler](https://bundler.io/) is not installed run `gem install bundler`.
2. Run `bundle install` to install all of the gems in your [Gemfile](Gemfile).
3. Download and install [PostgreSQL](https://www.postgresql.org/download/) if you don't have it already.

#### Database Setup:


1. Run `cp config/database.yml. config/native_setup_database.yml`.
2. Run `bin/rake db:create`.
3. Run `bin/rake db:migrate`.
4. Run `bin/rake db:seed` --> **This is where I am getting errors** :sweat_smile:.

### Testing
1. Run `RAILS_ENV=test rake db:test:prepare`.
2. Run `bin/rake test & rubocop`.

#### Running OperationCode Backend:
To run the OperationCode Backend simply type:
```bash
rails s
```

You can now visit http://localhost:3000 and you should see the "Yay! You're on Rails!" welcome message.
