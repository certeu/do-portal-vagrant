.. _start-here:

=========================
Contributing to Mailman 3
=========================

Copyright (C) 2008-2017 by the Free Software Foundation, Inc.


Contact Us
==========

Contributions of code, problem reports, and feature requests are welcome.
Please submit bug reports on the Mailman bug tracker at
https://gitlab.com/mailman/mailman/issues (you need to have a login on GitLab
to do so).  You can also send email to the mailman-developers@python.org
mailing list, or ask on IRC channel ``#mailman`` on Freenode.


Requirements
============

For the Core, Python 3.4 or newer is required.  It can either be the default
'python3' on your ``$PATH`` or it can be accessible via the ``python3.4`` or
``python3.5`` binary.  If your operating system does not include Python 3, see
http://www.python.org for information about downloading installers (where
available) and installing it from source (when necessary or preferred).
Python 2 is not supported by the Core.

You may need some additional dependencies, which are either available from
your OS vendor, or can be downloaded automatically from the `Python
Cheeseshop`_.


Documentation
=============

The documentation for Mailman 3 is distributed throughout the sources.  The
core documentation (such as this file) is found in the ``src/mailman/docs``
directory, but much of the documentation is in module-specific places.  Online
versions of the `Mailman 3 Core documentation`_ is available online.


How to contribute
=================

We accept `merge requests`_ and `bug reports`_ on GitLab.  We prefer if every
merge request is linked to a bug report, because we can more easily manage the
priority of bug reports.  For more substantial contributions, we may ask you
to sign a `copyright assignment`_ to the Free Software Foundation, the owner
of the GNU Mailman copyright.  If you'd like to jump start your copyright
assignment, please contact the GNU Mailman `steering committee`_.


Get the sources
===============

The Mailman 3 source code is version controlled using Git. You can get a
local copy by running this command::

    $ git clone https://gitlab.com/mailman/mailman.git

or if you have a GitLab account and prefer ssh::

    $ git clone git@gitlab.com:mailman/mailman.git


Testing Mailman 3
=================

To run the Mailman test suite, just use the `tox`_ command::

    $ tox

`tox` creates a virtual environment (virtualenv) for you, installs all the
dependencies into that virtualenv, and runs the test suite from that
virtualenv.  By default it does not use the `--system-site-packages` so it
downloads everything from the Cheeseshop.

A bare ``tox`` command will try to run several test suites, which might take a
long time, and/or require versions of Python or other components you might not
have installed.  You can run ``tox -l`` to list the test suite *environments*
available.  Very often, when you want to run the full test suite in the
quickest manner with components that should be available everywhere, run one
of these command, depending on which version of Python 3 you have::

    $ tox -e py35
    $ tox -e py34

You can run individual tests in any given environment by providing additional
positional arguments.  For example, to run only the tests that match a
specific pattern::

    $ tox -e py35 -- -P user

You can see all the other arguments supported by the test suite by running::

    $ tox -e py35 -- --help

You also have access to the virtual environments created by tox, and you can
use this run the virtual environment's Python executable, or run the
``mailman`` command locally, e.g.::

    $ .tox/py35/bin/python
    $ .tox/py35/bin/mailman --help

If you want to set up the virtual environment without running the full test
suite, you can do this::

    $ tox -e py35 --notest -r


Testing with  PostgreSQL
========================

By default, the test suite runs with the built-in SQLite database engine.  If
you want to run the full test suite against the PostgreSQL database, set the
database up as described in :doc:`DATABASE`, then create a `postgres.cfg` file
any where you want.  This `postgres.cfg` file will contain the ``[database]``
section for PostgreSQL, e.g.::

    [database]
    class: mailman.database.postgresql.PostgreSQLDatabase
    url: postgres://myuser:mypassword@mypghost/mailman

Then run the test suite like so::

    $ MAILMAN_EXTRA_TESTING_CFG=/path/to/postgres.cfg tox -e py35-pg

You can combine these ways to invoke Mailman, so if you want to run an
individual test against PostgreSQL, you could do::

    $ MAILMAN_EXTRA_TESTING_CFG=/path/to/postgres.cfg tox -e py35-pg -- -P user

Note that the path specified in `MAILMAN_EXTRA_TESTING_CFG` must be an
absolute path or some tests will fail.


Building for development
========================

To build Mailman for development purposes, you can create a virtual
environment outside of tox.  You need to have the `virtualenv`_ program
installed, or you can use Python 3's built-in `pyvenv`_ command.

First, create a virtual environment (venv).  The directory you install the
venv into is up to you, but for purposes of this document, we'll install it
into ``/tmp/mm3``::

    $ python3 -m venv /tmp/mm3

Now, activate the virtual environment and set it up for development::

    % source /tmp/mm3/bin/activate
    % python setup.py develop

Sit back and have some Kombucha while you wait for everything to download and
install.


Building the documentation
==========================

Build the online docs by running::

    $ tox -e docs

Then visit::

    build/sphinx/html/index.html


Running Mailman 3
=================

What, you actually want to *run* Mailman 3?  Oh well, if you insist.

You will need to set up a configuration file to override the defaults and set
things up for your environment.  Mailman is configured using an "ini"-style
configuration system.

``src/mailman/config/schema.cfg`` defines the ini-file schema and contains
documentation for every section and configuration variable.  Sections that end
in ``.template`` or ``.master`` are templates that must be overridden in
actual configuration files.  There is a default configuration file that
defines these basic overrides in ``src/mailman/config/mailman.cfg``.  Your own
configuration file will override those.

By default, all runtime files are put under a ``var`` directory in the current
working directory.

Mailman searches for its configuration file using the following search path.
The first existing file found wins.

* ``-C config`` command line option
* ``$MAILMAN_CONFIG_FILE`` environment variable
* ``./mailman.cfg``
* ``~/.mailman.cfg``
* ``/etc/mailman.cfg``
* ``argv[0]/../../etc/mailman.cfg``

Run the ``mailman info`` command to see which configuration file Mailman will
use, and where it will put its database file.  The first time you run this,
Mailman will also create any necessary run-time directories and log files.

Try ``mailman --help`` for more details.  You can use the commands
``mailman start`` to start the runner subprocess daemons, and of course
``mailman stop`` to stop them.

Postorius, a web UI for administration and subscriber settings, is being
developed as a separate, Django-based project.  For now, the most flexible
means of configuration is via the command line and REST API.

Note that you can also "run" Mailman from one of the virtual environments
created by tox, e.g.::

    $ .tox/py35/bin/mailman info


Mailman Shell
=============

This documentation has examples which use the Mailman shell to interact with
Mailman.  To start the shell type ``mailman shell`` in your terminal.

There are some testings functions which need to be imported first before you
use them. They can be imported from the modules available in
``mailman.testing``.  For example, to use ``dump_list`` you first need to
import it from the ``mailman.testing.documentation`` module.

.. Of course, *this* doctest doesn't have these preloaded...
   >>> from zope.component import getUtility
   >>> from mailman.interfaces.listmanager import IListManager

The shell automatically initializes the Mailman system, loads all the
available interfaces, and configures the `Zope Component Architecture`_ (ZCA)
which is used to access all the software components in Mailman.  So for
example, if you wanted to get access to the list manager component, you could
do::

    $ mailman shell
    Welcome to the GNU Mailman shell

    >>> list_manager = getUtility(IListManager)


Related projects
================

What you are looking at right now is the Mailman Core.  It's "just" the
message delivery engine, but it's designed to work with a web user interface
for list members and administrators, and an archiver.  The GNU Mailman project
also develops a web ui and archiver, but these are available in separate git
repositories.


Mailman Web UI
--------------

The Mailman 3 web UI, called *Postorius*, interfaces to core Mailman engine
via the REST client API.  This architecture makes it possible for users with
other needs to adapt the web UI, or even replace it entirely, with a
reasonable amount of effort.  However, as a core feature of Mailman, the web
UI emphasizes usability over modularity at first, so most users should use the
web UI described here.  Postorius is a Django_ application.


The Archiver
~~~~~~~~~~~~

In Mailman 3, the archivers are decoupled from the Core.  Instead, Mailman 3
provides a simple, standard interface for third-party archiving tools and
services.  For this reason, Mailman 3 defines a formal interface to insert
messages into any of a number of configured archivers, using whatever protocol
is appropriate for that archiver.  Summary, search, and retrieval of archived
posts are handled by a separate application.

A new archive UI called `HyperKitty`_, based on the `notmuch mail indexer`_
was prototyped at the PyCon 2012 sprint by Toshio Kuratomi.  The HyperKitty
archiver is very loosely coupled to Mailman 3 core.  In fact, any email
application that speaks LMTP or SMTP will be able to use HyperKitty.
HyperKitty is also a Django application.


.. _`Postorius`: https://gitlab.com/mailman/postorius
.. _`HyperKitty`: https://gitlab.com/mailman/hyperkitty
.. _`Django`: http://djangoproject.org/
.. _`REST client module`: https://gitlab.com/mailman/mailmanclient
.. _`Five Minute Guide the Web UI`: WebUIin5.html
.. _`blog post`: http://wiki.list.org/display/DEV/A+5+minute+guide+to+get+the+Mailman+web+UI+running
.. _`notmuch mail indexer`: http://notmuchmail.org
.. _`five minute guide to Hyperkitty`: ArchiveUIin5.html
.. _`Pycon 2012 sprint`: https://us.pycon.org/2012/community/sprints/projects/
.. _`Python Cheeseshop`: http://pypi.python.org/pypi
.. _`virtualenv`: http://www.virtualenv.org/en/latest/
.. _`pyvenv`: https://docs.python.org/3/library/venv.html
.. _`Mailman 3 Core documentation`: https://mailman.readthedocs.io
.. _tox: https://testrun.org/tox/latest/
.. _`merge requests`: https://gitlab.com/mailman/mailman/merge_requests
.. _`bug reports`: https://gitlab.com/mailman/mailman/issues
.. _`copyright assignment`: https://www.fsf.org/licensing/assigning.html/?searchterm=copyright%20assignment
.. _`steering committee`: mailto:mailman-cabal@python.org
.. _`Zope Component Architecture`: https://pypi.python.org/pypi/zope.component
