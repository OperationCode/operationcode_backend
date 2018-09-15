# Docker Setup

### Quick Reference
1. Install Dependencies (git, make, docker)
    i. Install [git](#git) 

    ii. Install [make](#make-for-windows-only)

    iii. Install [docker](#docker)

2. Retrieve [Codebase](#local-development-environment)
3. Setup [Database](#database-setup)
4. Run [Codebase](#running-operationcode-backend)
5. Interact With [Codebase](#interact-with-backend)

## Install Dependencies

### Docker
Docker is a container system. Click the appropriate link below to install Docker on your operating system.

* [Mac](https://www.docker.com/docker-mac)
* [Windows 10 Professional or Enterprise edition](https://www.docker.com/docker-windows)
* [Windows 10 Home edition or earlier version of Windows](https://www.docker.com/products/docker-toolbox)
* [Linux (Ubuntu)](https://www.docker.com/docker-ubuntu)

Note that a full installation of the Docker Toolbox includes Git as well, which is also needed to work on the backend and is mentioned below.

### Git
Git is a distributed version control system. This is how our code is stored and managed. Git can be frustrating, but it is an essential tool. If you want to learn more about Git, a great resource is [Think Like a Git](http://think-like-a-git.net/). If you find yourself in a real git pickle, see ["Oh, shit, git!"](http://ohshitgit.com/). If you have already installed Git as a part of the Docker Toolbox, you don't need to install it again using the following link.

* [Install Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)

### Make (for Windows only)
Make is a tool which controls the generation of executables and other non-source files of a program from the program's source files. It is a standard part of the GNU library and is included in most distributions of Linux, as well as OSX. Unfortunately, Windows does not have a native make program, so it will need to be installed and added to PATH in order for the command line commands to work. You can use the [GNUWin general installation guide](http://gnuwin32.sourceforge.net/install.html) as a general guide on how to install a GNU package and add it to PATH.

* [Install Make](http://gnuwin32.sourceforge.net/packages/make.htm)

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

#### Database Setup:

1. Have the [Docker app](https://www.docker.com/) running
2. Run `make setup`
3. Run `make test` - recommended as it prepares your test env, and runs your tests initially.

If you run into any `bundle install` issues, run `make bundle`.

#### Running OperationCode Backend:
The OperationCode Backend has some handy shortcuts built in to make common tasks simple. You can check out the [Makefile](https://github.com/operationcode/operationcode_backend/blob/master/Makefile) to see a full listing of what these shortcuts are and what they do.

To run the OperationCode Backend simply type:
```bash
make
```

#### Interact With Backend:
You can now visit http://localhost:3000 (or run `make open`) and you should see a Rails welcome message!

In case you used the Docker Toolbox, you might have also installed VirtualBox, which creates its own virtual network adapters. In that case, the server might be running on that IP address and may not be reachable via localhost, 127.0.0.1 or even 0.0.0.0. So, you will need to use `netstat` on the command line to figure out the IP address on which the server is bound.

#### Clean Up Docker:
Once you are finished with any changes and they are commited you can clean up your environment to simulate a fresh start in production.

Run `make minty-fresh` and you can clean up all images, and volumes to ensure a non-persistent state. Any time this action occurs or you run into an issue with any of the containers the recommend first course of action is 

1. `make minty-fresh`
2. `make setup`
3. `make test`
4. `make`

This can be shortened to a make target: `make fresh-restart`
