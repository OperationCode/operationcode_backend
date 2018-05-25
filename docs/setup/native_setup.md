# Native Setup

### Git
Git is a distributed version control system. This is how our code is stored and managed. Git can be frustrating, but it is an essential tool. If you want to learn more about Git, a great resource is [Think Like a Git](http://think-like-a-git.net/). If you find yourself in a real git pickle, see ["Oh, shit, git!"](http://ohshitgit.com/). If you have already installed Git as a part of the Docker Toolbox, you don't need to install it again using the following link.

* [Install Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)

### Not needed right? (I am gonna use "Rakefile")
```markdown
### Make (for Windows only)
Make is a tool which controls the generation of executables and other non-source files of a program from the program's source files. It is a standard part of the GNU library and is included in most distributions of Linux, as well as OSX. Unfortunately, Windows does not have a native make program, so it will need to be installed and added to PATH in order for the command line commands to work. You can use the [GNUWin general installation guide](http://gnuwin32.sourceforge.net/install.html) as a general guide on how to install a GNU package and add it to PATH.

* [Install Make](http://gnuwin32.sourceforge.net/packages/make.htm)
```

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

1. If **Bundler** is not installed run `gem install bundler`
2. Run `cp native_setup_Gemfile Gemfile` --> All this really does is uncomment the "bcrypt" gem.
3. Run `bundle install` to install all gem dependencies.

#### Database Setup:
_Install PostgreSQL if needed first._

1. Run `cp config/database.yml db/native_setup_database.yml` --> Modify database.yml file for native setup. Is this ok?
2. Run `rake db:create` --> need to create rake task
3. Run `rake db:migrate` --> Need rake task for this. After migrating I can get successful Rails welcome page  on localhost:3000 :raised_hands:.
4. Run `rake db:seed` --> **This is where I am getting errors** :sweat_smile:
5. Testing: need to figure out a way to do all of this (stole from docker_setup): `export RAILS_ENV=test && rake db:test:prepare && rake test && rubocop`

If you run into any `bundle install` issues, run `bundle`.


#### Running OperationCode Backend:
The OperationCode Backend has some handy shortcuts built in to make common tasks simple. You can check out the [Makefile](https://github.com/operationcode/operationcode_backend/blob/master/Makefile) to see a full listing of what these shortcuts are and what they do.

To run the OperationCode Backend simply type:
```bash
rails s
```

You can now visit http://localhost:3000 (or run `rake open` (need rake task for this)) and you should see a Rails welcome message!


**Not sure what this means... but may be needed to fix seeding issues**
```markdown
In case you used the Docker Toolbox, you might have also installed VirtualBox, which creates its own virtual network adapters.
In that case, the server might be running on that IP address and may not be reachable via localhost, 127.0.0.1 or even 0.0.0.0.
So, you will need to use `netstat` on the command line to figure out the IP address on which the server is bound.
```
