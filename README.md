You are meant to clone this repo into ~/bin or copy the init scripts to ~/bin.

Example:

```
kangxi:~/bin$ ls -l
total 20
lrwxrwxrwx 1  18 docker -> /usr/bin/docker.io
lrwxrwxrwx 1   9 foprex -> init-ship
lrwxrwxrwx 1   9 init -> init-boat
-rwxr-xr-x 1 496 init-boat
-rwxr-xr-x 1 457 init-ship
-rwxr-xr-x 1 424 init-yacht
-rwxr-xr-x 1 424 init-yacht2
-rwxr-xr-x 1 161 init-yacht-stop
lrwxrwxrwx 1  15 node -> /usr/bin/nodejs
lrwxrwxrwx 1  31 urbit -> /home/yebyen/del/urbit/bin/urbit
```

These can coexist with any of your own regular Earth ~/bin scripts.  See also
[yebyen/urbit-deb](//github.com/yebyen/urbit-deb) to build deb packages instead.

The various init scripts are meant to launch different ships; they contain some
variables to set a ship and its container's name, which you may change to suit
your own needs.  Start with init-ship.  There is also a stop script which init
should call to clean up (commit your ship's log) and prepare for next start.

If you are a Mac user, you might need to make changes.  The scripts were not
tested with MacOS or boot2docker.  YMMV, and pull requests are always welcome!
Finally, if you are able to get two ships in separate containers on the same
host to talk with each other, please tell me how!  It is a known bug, probably
docker's fault.  I think they did it on purpose.  (Urbit is otherwise really
very good at NAT-busting and establishing 2-way comms with hostile networks.)

-----

1. tl;dr
2. About urbit and docker
3. `init-yacht`
4. A submarine is berthed
5. Going beneath the surface and coming back up
6. From the Creator

-----

#### tl;dr

- [ ] Choose a name for your ship's container. `CONT=magsup`
- [ ] Choose a different name for the image. `SHIP=magsup-sogdep`
- [ ] Clone this repo: `git clone http://github.com/yebyen/urbinit ~/bin`
- [ ] Edit the script and set the values you chose above in `~/bin/init-ship`
- [ ] Pull down half a gigabyte of images: `docker pull yebyen/urbinit:latest`
- [ ] Tag from that precompiled image: `docker tag yebyen/urbinit:latest $SHIP`

Last step, to launch a container and start a submarine:

- [x] `~/bin/init-ship`

Read the script itself, or read on to understand what's happening, but the
short version is that when you <kbd>ctrl</kbd> + <kbd>d</kbd> a few times to
exit the ship and container, a brief delay happens when the Hoon machine in
`CONT` is `docker commit`'ted back to the image `SHIP`, before `init-yacht-stop
$SHIP` is called to clean up the lock file.

If the commit should fail, the lock created in `$HOME/dlock` won't be cleared.
If you do the wrong thing (should only happen in the event of power outage) you
may sink your ship!  Clearing the lock without `docker commit`ting your `$CONT`
back to image `$SHIP` can be an easy way to see your ship sink.  So, if your
container is stopped and you see when you try to restart it...

```
LOCK FILE EXISTS ALREADY... quitting
```

... read the script and see what it was meant to do at the end to clean up, or
you can just: `docker commit $CONT $SHIP && init-yacht-stop $SHIP`.

Docker layers these commits on top of each other with the configured storage
driver, btrfs or aufs probably.  You can do `init-yacht` many times.  However,
`doit.sh` is for when you've done this too many times.  The limit is up to at
least 127 times or more by now, minus any layers consumed by the build process.

To rebuild, look at the `durbdate*.sh` scripts.  You can build the top layers
with `./durbdate-mini.sh`, just quit with <kbd>ctrl</kbd> + <kbd>c</kbd> when
it asks for credentials and tries to push updated images to the index (unless
you are me, in which case, you can of course log in as yebyen and push them.)

#### Older instructions

I do most of my work on 32-bit hosts.  Use the i686 tag even if you don't.
Sorry if you come from even more exotic architectures.

1. `docker pull yebyen/urbinit` or `docker pull yebyen/urbinit:i686`
2. `docker tag yebyen/urbinit:i686 novfes-lodzod`
3. `git clone http://github.com/yebyen/urbinit ~/bin` or if you already have
   your own `~/bin` directory, just copy the files `init-yacht` and
  `init-yacht-stop` right into it.
4. `mkdir ~/.dlock`
5. `init-yacht` (or just `init`)

Now in Ubuntu, [screen](https://www.debian-administration.org/articles/34) is
running with urbit inside, and if you're already familiar with screen, resist
the urge to `^A`-`d` and exit the shell, when you want to try and leave your
ship running as a background process to come back later.  I'll explain...

Unless you are a docker and screen expert, you will have inadvertently stopped
the whole container and killed both of `screen` and `urbit` in the process.
Doing this may leave you with a giant 512MB or 1GB core file in your container,
committed and saved forever.  Moving on, since you didn't do that...

You are in front of a `urbit` that runs inside of `screen` under a `bash` with
its parent process docker, and your ship is floating at a newly created pier,
inside of a container.  It's dark here.  A constellation of items are with you
now, but you can't see them.

Screen is convenient because as you may know, with `^A`-`c` you can open up a
new Linux shell inside the container and do other things &mdash; bash, or edit
a file within the container `novfes`, that `init-yacht` started.

Your keys are being generated and shortly after that, your new submarine should
emerge to pull hoons from `~zod`.  When this is finished, you're left staring
at a prompt that looks something like this:

    ; ~zod |Tianming| is your neighbor
    ; ~zod |Tianming| is your neighbor
    [%fetch %main]
    [%fetch %main]
    ...
    [%fetch %arvo]
    fetched new objects, merging
    updating...
    ~dilmex-dilwyl-midsub-daplet--lantux-filtex-binsub-mognex/try=> 

If you are totally new, you should stop here and pick up
the [official Urbit](//github.com/urbit/urbit) docs.  You can skip to the first
mention of `:begin`, near "A new life awaits you on the off-world colonies!"
You are ready for your first destroyer.  If you are not so new here, you may
already have a good idea of what to do next.

There are no Unix system calls in Urbit, this is by design.  If docker started
`urbit` directly, you would be trapped there, which is still a problem because
there is no reasonable way to edit your hoon apps.  The `%clay` filesystem is
homed at `$URBIT_HOME` (at `/urbit/urb` in this, your new urbinit container).

-----

___Going beneath the surface___

If everything goes right, you'll eventually get tired and want to quit.  Press
`^D` two or more times: once for `urbit`, again for each extra shell window you
may have created with `^A`-`c` &mdash; now ending `screen` &mdash; and once
more for the top-most `bash`: the last waiting process in the container.  Now,
before it's too late, `docker ps -a` and `docker images` to see what happened.
There is a new commit, from your stopped container only seconds old, and it has
been saved on top of the previous image and retagged `novfes-lodzod` again.

To get back to your ship, run `init` again.  It seems a little brighter now.

___Coming back up___

I actually prefer to run: `screen init` &mdash; hold on, did I just tell you to
run a screen inside of screen?  You betcha.  You can do this now if you want to
leave your ship running in the background, then press `^A`-`d` like I know you
always wanted to do, and come back later.

-----

`docker attach novfes` &mdash; and this part, I'll usually do inside a `tmux`.

    $ tmux
    ...

    $ docker attach novfes

Now you have just one `screen` running inside of `tmux`.  `^B`-`d` is your safe
egress key.  You can come back after that again with `tmux attach` or `tmux a`.
`^B`-`c` will get you another shell on the host machine, and `^A`-`c` still
gets a new shell inside of the container.

There you could (for example) `git pull` and `make clean && make` if you needed
to recompile your `urbit` (on Flag Day or any other time), or you could use this
chance to find an editor you like and go for a browse around in `/urbit/urb/`
&mdash; I'd start by making a desk and copying some hoons from `zod/try/bin/`,
like `app.hoon`, `toy.hoon`, or even `zod/main/bin/thumb.hoon` into it.

`^P`-`^Q` detaches from `novfes` so you can safely close down tmux, and the pier
is still running in screen.  You can freely attach and detach in this way, of
course either with or without tmux.

`^A`-`d` is still just at the dangerous precipice of the next bad idea, `^D`,
but hey, you've probably seen some shit by now, so go ahead and try it.

---

#### From the Creator

I used the image `novfes-lodzod` as my commit target and `novfes` as the name
for my running container, to keep docker from getting confused &mdash; they
could each have the same name, and something in the Docker stack would surely
complain of a namespace conflict between image and container before too long.

If you are trying to follow/edit the scripts I had you put in `~/bin` in step
3, it may help to replace these names at the top of the script, and pick some
of your own.

---

If you play fast-and-loose detaching screen and exiting the parent process, you
will most very probably sink your ship if you don't know what you're doing.  I
did my best, there's velvet rope.  If you get an error message, read carefully
and you should be able to determine what's gone wrong to get back on the rails.

## Thanks for playing along!

You can also build for yourself from a `./Dockerfile` here, some `Dockerfile`s
you also find here in `urbinit-base` and `urbinit-src`, which ultimately depend
on [kingdonb/baseimage-docker](http://github.com/kingdonb/baseimage-docker).

If you did not already, create the empty directory ~/.dlock now, on the host
where you run your docker containers: `mkdir ~/.dlock` and begin some ships!

******

#### What to do:

Read `init-yacht` briefly since you may need to change it

******

### More than one pier?

If you want to run multiple piers on the same docker host machine, you would
simply make a copy of `init-yacht` and change the SHIP and CONT variables to
something unique on your host.  They can all use the same `init-yacht-stop`
since it takes $SHIP as its first argument.  You need not make other changes.

******

"[Curtis Yarvin]: I can't emphasize strongly enough that you can't just
recreate a destroyer within the current continuity era - it will have the wrong
message sequence numbers, and won't be able to acknowledge packets."

-- https://groups.google.com/forum/#!searchin/urbit-dev/I$20can$27t$20emphasize$20strongly$20enough/urbit-dev/T_NeU7Iy66o/lRg0OsMOlZcJ

On continuity -- search for "flag day" and "continuity breach" on urbit-dev, or go [here](http://urbit.org/docs/user/tour#-continuity-breaches).

