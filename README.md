# What this is

- Containerized ruby, installed within a ruby env (rbenv), and jekyll, installed within that rbenv.
- The idea is to freeze both the version of ruby and jekyll used, so a container build at a later date doesn't end up with different versions which may or may not work with the NSC web codebase.

# What is included

- Docker and Singularity recipes to install jekyll 4.3.3 under rbenv (ruby v3.3.4) and jekyll 3.9.4 under rbenv (ruby 3.0.7)
- There is a script (compile.sh) which can be used if you want to generate html code for the webpage, without actually logging onto the container.

## Docker Installation

- The prebuilt container is also available on the Docker hub, and can be pulled down.

```
    docker pull pchengi/nscjekyll
```

## Build locally from Dockerfile

- You can also build the docker container yourself. 

```
    git clone https://github.com/snic-nsc/nscjekyllsetup.git
    cd nscjekyllsetup
    sudo docker build -t nscjekyll .
```

## Starting the docker container

```
    sudo docker run --rm -i -d -v <path to checked out nscweb repo>:/mnt -p 4000:4000 --name nscjekyll nscjekyll bash

```

- The above command starts the container, and mounts your checked out nscweb directory onto /mnt directory on the container; it also proxies port 4000 on the container onto your host machine.

## Scripted html code generation

- You can generate the html code for the files in the nscweb repo, without having to login into the container, using the compile.sh script on the container. It'll write the generated files to the _site directory, within your repo. It will output the compilation message(s) onto the terminal, and also return the exit code returned by jekyll, which can be used to test if the compilation was successful. Note that the `compile.sh` script takes an argument; if `nsc` is specified, it uses `jekyll 2.1.1`, else it will use a more current version of Jekyll, `jekyll 3.5.2`.

```
sudo docker exec -it nscjekyll bash /home/nscuser/compile.sh nsc
Configuration file: /home/nscuser/mnt/_config.yml
            Source: /home/nscuser/mnt
       Destination: /home/nscuser/mnt/_site
      Generating... 
                    done.
```

## Serving the contents using Jekyll

- In order to serve the file contents using Jekyll, simply do the following:

```
sudo docker exec -it nscjekyll bash
source rubyenv nsc
cd mnt
jekyll serve --watch
```
- At this point, if you don't see errors on the console, you should be able to point the browser on your host machine to localhost:4000 and view the pages.

## Singularity installation

- The singularity build recipe is found in the singularity directory, in this repo.
- To build:
```
cd singularity
sudo singularity build nscjekyll.simg Singularity
```

- To simply compile pages (such as via a script)
```
singularity exec --bind <checked-out nscweb directory>:/mnt nscjekyll.simg bash /usr/local/src/nscjekyllsetup/compile.sh nsc
```

- Run the jekyll web server, to serve pages, you could do one of the following:
```
singularity exec --bind <checked-out nscweb directory>:/mnt nscjekyll.simg bash
source /usr/local/src/nscjekyllsetup/rubyenv
cd /mnt
jekyll serve --watch
```

or   
```
singularity shell nscjekyll.simg
source /usr/local/src/nscjekyllsetup/rubyenv
cd <checked-out nscweb directory>
jekyll serve --watch
```

## Converting Docker to Singularity

- If you don't wish to build a singularity container from scratch, using the recipe, you can convert it from a prebuilt docker image.
- To do this, execute the build.sh script in docker-to-singularity folder, under `singularity'.
