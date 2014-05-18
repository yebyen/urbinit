1. tl;dr
2. About urbit and docker
3. What to do
4. What about these other files?
5. More than one pier?
6. From the Creator
7. Polite and Friendly Etiquette/Advice for any Global Namespace Chat

******

#### tl;dr if you're familiar with docker

If you are on a real 64-bit host with Docker, you may optionally just omit any
`:i686` you find in the instructions below.  At press time the latest `:i686`
tags were actually newer than `yebyen/urbinit` `:latest`, but YMMV.

1. `docker pull yebyen/urbinit` or `docker pull yebyen/urbinit:i686`
2. `docker tag yebyen/urbinit:i686 novfes-lodzod`
3. `git clone http://github.com/yebyen/urbinit ~/bin` or if you already have
   your own `~/bin` directory, just copy the files `init-yacht` and
  `init-yacht-stop` right into it.
4. `init-yacht` (or just `init`)

Now in Ubuntu, [screen](https://www.debian-administration.org/articles/34) is
running with urbit inside, and if you're already familiar with screen, resist
the urge to `^A`-`d` when you want to try and leave your ship running.  Unless
you are an expert, you will almost certainly inadvertently stopped the whole
container and kill both of `screen` and `vere` in the process.

You are in front of a `vere` that runs inside of `screen` under a `bash` with
its parent process as docker, your ship floating at a newly created pier.
Screen is convenient because with `^A`-`c` you can open up a shell inside the
container and do other things (eg. edit a file within the container `novfes`
that `init-yacht` started for you.)

Your keys are being generated and shortly after that, your new submarine should
emerge to pull hoons from `~zod`.  If you are totally new here, you should stop
now, and pick up the official Urbit docs at their first mention of `:begin`.

******

If everything goes right, you'll eventually get tired and want to quit.  Press
`^D` three times (once for `vere`, once for `screen`, and once more for the top
most `bash`).  Now, before it's too late, `docker ps -a` and `docker images` to
see a new commit, only seconds old, has been saved over the previous image and
retagged `novfes-lodzod` again.

To get back to your ship, run `init` again.  I actually prefer to run: `screen
init` &mdash; hold on, did I just tell you to run a screen inside of screen?
You betcha.  Then press `^A`-`d` like you've been waiting to do, and come back.

`docker attach novfes` &mdash; and this part, I'll usually do inside a `tmux`.

    $ tmux
    ...

    $ docker attach novfes

Now you have `screen` running inside of `tmux`.  `^B`-`d` is your egress key.
Come back again with `tmux attach` or `tmux a`.  `^A`-`c` still gets a new
shell inside of the container.  `^A`-`d`, `^D` is still a bad idea.

******

I used the image `novfes-lodzod` as my commit target and `novfes` as the name
for my running container, to keep docker from getting confused &mdash; if you
are trying to follow/edit the scripts I had you put in `~/bin` in step 3, it
will help to know these names until you pick your own.

You can also build for yourself from the `Dockerfile` here, and each dependent
`Dockerfile` you find here in `urbinit-base` and `urbinit-src`, which depend on
[kingdonb/baseimage-docker](http://github.com/kingdonb/baseimage-docker).

__ Thanks for playing along! __

If you did not already, create the empty directory ~/.dlock now, on the host
where you run your docker containers: `mkdir ~/.dlock`

******

#### What to do:

Read `init-yacht` briefly since you need to change it

******

### More than one pier?

If you want to run multiple piers on the same docker host machine, you would
simply change the name of the lock file to something unique -- you could use
the $SHIP variable: LOCKFILE="$HOME/.dlock/$SHIP.lock"

******

#### From the Creator

"[Curtis Yarvin]: I can't emphasize strongly enough that you can't just
recreate a destroyer within the current continuity era - it will have the wrong
message sequence numbers, and won't be able to acknowledge packets."

-- https://groups.google.com/forum/#!searchin/urbit-dev/I$20can$27t$20emphasize$20strongly$20enough/urbit-dev/T_NeU7Iy66o/lRg0OsMOlZcJ

On continuity -- search for "flag day" and "continuity breach" on urbit-dev, or go [here](http://urbit.org/community/articles/continuity/).

