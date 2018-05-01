# Docker Setup

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

You can now visit http://localhost:3000 (or run `make open`) and you should see a Rails welcome message!

In case you used the Docker Toolbox, you might have also installed VirtualBox, which creates its own virtual network adapters. In that case, the server might be running on that IP address and may not be reachable via localhost, 127.0.0.1 or even 0.0.0.0. So, you will need to use `netstat` on the command line to figure out the IP address on which the server is bound.

#### Entering Rails Console

To enter Rails console after you are running the OperationCode Backend:
* Get a list of all running docker containers
```
$ docker ps
```
* You'll see output like this:
```
$ docker ps
CONTAINER ID        IMAGE                          COMMAND                  CREATED             STATUS              PORTS                    NAMES
0d7632d2da32        operationcodebackend_sidekiq   "sidekiq -C config/s…"   4 minutes ago       Up 4 minutes                                 operationcodebackend_sidekiq_1
ad85db4a0bf5        operationcodebackend_web       "bundle exec puma -C…"   4 minutes ago       Up 4 minutes        0.0.0.0:3000->3000/tcp   operationcodebackend_web_1
39fecccee668        postgres                       "docker-entrypoint.s…"   6 minutes ago       Up 6 minutes        5432/tcp                 operationcodebackend_operationcode-psql_1
9825975b1d44        redis:latest                   "docker-entrypoint.s…"   6 minutes ago       Up 6 minutes        6379/tcp                 operationcodebackend_redis_1
```
* Grab the CONTAINER ID for opreationcodebackend_web_1 (in this case, it is ad85db4a0bf5)
* Enter the Docker container with (substitute in the appropriate container id):
```
$ docker exec -it [CONTAINER-ID] bash
```
* Once you are in the container, run:
```
root@[CONTAINER-ID]:/app# rails console
```
* And you should be in the Rails console!
