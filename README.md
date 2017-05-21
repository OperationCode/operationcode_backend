# Operation Code Backend

This repo stores the code for the Operation Code backend, located at [api.operationcode.org](http://api.operationcode.org)

## Setting up your Environment
* In order to work on the **Operation Code** site, you will need to install a few things.

  ### Docker
  Docker is a container system. Click the link below to install Docker on your Operating System.

  * [Mac](https://www.docker.com/docker-mac)
  * [Windows](https://www.docker.com/docker-windows)
  * [Linux (Ubuntu 16.04)](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-16-04)

  ### Git
  Git is a distributed version control system. This is how our code is stored and managed. Git can be frustrating, but it is an essential tool. If you want to learn more about Git, a great resource is [Think Like a Git](http://think-like-a-git.net/). If you find yourself in a real git pickle, see ["Oh, shit, git!"](http://ohshitgit.com/).

  * [Install Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)

  ### Make (for Windows only)
  Make is a tool which controls the generation of executables and other non-source files of a program from the program's source files.  It is a standard part of the GNU library and is included in most distrubtions of Linux, as well as OSX.  Unfortunately, Windows does not have a native make program, so it will need to be installed and added to PATH in order for the command line commands to work.  You can use the [GNUWin general installation guide](http://gnuwin32.sourceforge.net/install.html) as a general guide on how to install a GNU package and add it to PATH.

  * [Install Make](http://gnuwin32.sourceforge.net/packages/make.htm)

  ### Operation Code
  You are now ready for the actual **Operation Code** code base.

  * The common practice is to make a copy of the GitHub repository you want to work on (known as `forking` the repo), make your changes, and then request to merge those changes back into the project (known as a `pull request`).
  * Forking a repo is done through GitHub's web UI. It can be found in the top right corner of the **Operation Code**'s [GitHub](https://github.com/OperationCode/operationcode_backend) page.

  * The following commands will pull down the source code from your forked repo.
  * Make sure to replace `[YOUR-GITHUB-NAME]` with your GitHub name.  (example: https://github.com/iserbit/operationcode.git)

  #### Local Development Environment
    _Fork the repo first._
    ```bash
    git clone https://github.com/[YOUR-GITHUB-NAME]/operationcode_backend.git operationcodebackend-upstream
    cd operationcodebackend-upstream
    git remote add upstream https://github.com/OperationCode/operationcode_backend.git
    ```

  #### Database Setup:
  To setup the database simply run the following command in the root directory of the project.

  ```bash
  make setup
  ```

  #### Running Operation Code:
  Operation Code has some handy shortcuts built in to make common tasks simple. You can check out the [Makefile](https://github.com/OperationCode/operationcode_backend/blob/master/Makefile) to see a full listing of what these shortcuts are and what they do.

  To run Operation Code Backend simply type:
  ```bash
  make
  ```

  You can now make api requests to https://localhost:3000


