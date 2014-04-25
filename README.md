1. tl;dr
2. About urbit and docker
3. What to do
4. What about these other files?
5. More than one pier?
6. From the Creator
7. Polite and Friendly Etiquette/Advice for any Global Namespace Chat

*****

#### tl;dr if you're familiar with docker

1. `docker pull yebyen/urbinit`
2. `docker run -i -t yebyen/urbinit`
3. This will drop you in to a Debian instance, running [screen](https://www.debian-administration.org/articles/34), with urbit on screen 0 running a newly created pier for the first time. Now you're at the 'register' step on the urbit [setup page](http://urbit.org/setup/)
4. If you want to keep your ship / image, be sure to commit it before stopping the image.

For more patient readers, the following instructions will hopefully make clear
how to create and keep an image of your ship, preserving the checkpoint state
automatically whenever you brought it down.

You can also build the container yourself from the Dockerfile, and depends on
http://github.com/kingdonb/baseimage-docker (checkout -b trusty origin/trusty)

__ Thanks for playing along! __

*****

#### About urbit and docker:

Why this script?

Normal behavior when running vere on an already active pier is to cleanly bring
down the running vere with a signal 15 (term) and start the pier and its ships
again from the saved checkpoint.  This is accompished by testing the absence or
presence of a lock file.

You could encounter problems using a pier with missing checkpoints since an old
image of any running pier is going to have an old checkpoint serial, be missing
the pier lock, and will be unable to acknowledge the packets sent to it by the
network.

Another pier launched from that old image would most likely be in a bad state
(aside from that, it will try to report in to the network from the new address
and the network will have conflicting information about where to find you.)


To counter this, the urbinit script executes a simple locking activity which is
meant to prevent your ships and pier from being opened twice.

Without docker, with your pier on a single computer that does not have docker's
approach to sandboxing and process isolation, this is not necessary because of
the pier's lock file.  With docker, the lock is inside the container, probably
doesn't go back to the image under any circumstances, and launching your ship
from that image you will reliably find it to be unlocked.  This is regardless
of if it's running or not in another container.

Just like if you ran vere on two separate hosts, they will each get their own
address and compete for ~zod's attention.

It would be easy for the network to get confused if you ran the same ship
simultaneously at different addresses, as it's already explained in the docs.

Locking only permits vere to run a pier when its lock file has been cleared.
With urbinit too, this happens every successful stop, when the ship's pier is
committed back to the image (named $SHIP).

I simply added another lock out of the container, in the ~/.dlock directory.

If you did not already, create the empty directory ~/.dlock now, on the host
where you run your docker containers: `mkdir ~/.dlock`

*****

#### What to do:

The locking version is `init-urb`.  Run that, or use the symlink `urbinit`.

Read `init-urb` quickly since you need to change it, and use a script inside
the container like my `/.urbit-exec` below:

    #!/usr/bin/env bash
    URBIT_HOME=/home/urbit-master/urb
    pushd $URBIT_HOME
    export URBIT_HOME
    cd ..
    bin/vere mypier

(if you don't have a ship in a docker container already, skip forward to the
docker instructions and use my image, `yebyen/urbit-debian`, tag :dev or :bin.
It already has the urbit-exec script placed where init-urb expects to find it.)

Inside of your container, this script uses vere to start a pier named 'mypier'.
The first time, you should run `bin/vere -c mypier` by hand to create the pier.

I tend to name my piers 'pier' rather than 'mypier', so decide whether your
piers are called 'pier' or 'mypier' or 'frob' and make any needed adjustment to
the .urbit-exec script accordingly.

The other remaining scripts in this tarball don't care what the pier is called,
only your ship's docker image name ($SHIP) so it can launch that image and
commit it back when the urbit-exec's vere process exits.


If you don't already have a docker container with a ship in it, start with:

-- (pull my base image, run it and attach to the container)
    $ docker pull yebyen/urbit-debian
    $ ID=$(docker run -i -t -d yebyen/urbit-debian:dev /bin/bash)
    $ docker attach $ID

-- (then in the root shell of the container)
    # . /.bashrc
    # cd /urbit
    # git pull
    # make
    # bin/vere -c mypier

... wait for ~zod to send you the hoons
    /=try=> ^D (ctrl-D to exit vere)
    ^D

-- (now back in the shell on your docker host)
    $ docker commit $ID the-name-of--your-ship # <- This step saves you from sinking

You may need to have special permission (or be root) to run the docker verbs --
I didn't need to pay attention to any of that, using CoreOS.

After you commit your new ship, you can set SHIP to the name of its image at
line 3 in `init-urb`.

This does not need to be the name of your ship, but that seems to be the most
logical choice if you only have one destroyer at your pier.  You can name your
image any old thing (and set the SHIP variable to that, so urbinit knows what
image to launch.)

*****

### What about these other files?

The short, non-locking `urbit` version of the code is in a file called `urbit`.
This basic idea was reused with added locking in `init-urb`.  The +x perms on
the `urbit` script are disabled because you are not meant to run it.

If you had trouble understanding the locking version, init-urb, you should read
`urbit` and compare to that.  This four line script serves no other purpose and
is provided only for reference, since locking makes things more complicated --
it's the non-locking version for you to read and understand.

Don't use it.  It's not safe.  Your ship may sink.  You've been warned!

*****

### More than one pier?

If you want to run multiple piers on the same docker host machine, you would
simply change the name of the lock file to something unique -- you could use
the $SHIP variable: LOCKFILE="$HOME/.dlock/$SHIP.lock"

*****

#### From the Creator

"[Curtis Yarvin]: I can't emphasize strongly enough that you can't just
recreate a destroyer within the current continuity era - it will have the wrong
message sequence numbers, and won't be able to acknowledge packets."

-- https://groups.google.com/forum/#!searchin/urbit-dev/I$20can$27t$20emphasize$20strongly$20enough/urbit-dev/T_NeU7Iy66o/lRg0OsMOlZcJ

On continuity -- search for "flag day" and "continuity breach" on urbit-dev, or go [here](http://urbit.org/community/articles/continuity/).

If you use a `yebyen/urbit-debian` image provided, your `URBIT_HOME` is /urbit and the `/.urbit-exec` script is provided, already replaced 'mypier' with 'pier', but you still have to create your pier and this must match the name in `/.urbit-exec` for urbinit to bring up your ship.


#### Polite and Friendly Etiquette/Advice for any Global Namespace Chat
One last thing: before you use :chat, please consider using :begin to create a
ship with a shorter name.  It will allow you to mark more permanently your own
identity, and it can take up a lot less space within a given line of text.

Please do not :chat from a submarine!  It's rude, and what's more, likely it
has already been made impossible by Tlon, Inc. at the time you read this :)
