================================================
Mailman - The GNU Mailing List Management System
================================================

This is `GNU Mailman`_, a mailing list management system distributed under the
terms of the `GNU General Public License`_ (GPL) version 3 or later.

Mailman is written in Python_, a free object-oriented programming language.
Python is available for all platforms that Mailman is supported on, which
includes GNU/Linux and most other Unix-like operating systems (e.g. Solaris,
\*BSD, MacOSX, etc.).  Mailman is not supported on Windows, although web and
mail clients on any platform should be able to interact with Mailman just
fine.

GNU Mailman 3 consists of a `suite of programs`_ that work together:

* Mailman Core; the core delivery engine.  This is where you are right now.
* Postorius; the web user interface for list members and administrators.
* HyperKitty; the web-based archiver
* Mailman client; the official Python bindings for talking to the Core's REST
  administrative API.
* Mailman bundler; a convenient way to deploy Mailman 3.

Only the Core is required.  You could easily write your own web user interface
or archiver that speaks to the Core over its REST API.  The REST API is a pure
HTTP-based API so you don't *have* to use Python, or even our official
bindings.  And you can deploy whatever components you want using whatever
mechanisms you want.

But we really like Postorius and HyperKitty and hope you will too!


Copyright
=========

Copyright 1998-2017 by the Free Software Foundation, Inc.

This file is part of GNU Mailman.

GNU Mailman is free software: you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation, either version 3 of the License, or (at your option) any later
version.

GNU Mailman is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with
GNU Mailman.  If not, see <http://www.gnu.org/licenses/>.


Spelling
========

The name of this software is spelled `Mailman` with a leading capital `M`
but with a lower case second `m`.  Any other spelling is incorrect.  Its full
name is `GNU Mailman` but is often referred colloquially as `Mailman`.


History
=======

Mailman was originally developed by John Viega in the mid-1990s.  Subsequent
development (through version 1.0b3) was by Ken Manheimer.  Further work
towards the 1.0 final release was a group effort, with the core contributors
being: Barry Warsaw, Ken Manheimer, Scott Cotton, Harald Meland, and John
Viega.  Version 1.0 and beyond have been primarily maintained by Barry Warsaw
with contributions from many; see the `ACKNOWLEDGMENTS`_ file for details.
Jeremy Hylton helped considerably with the Pipermail code in Mailman 2.0.
Mailman 2.1 is primarily maintained by Mark Sapiro, with previous help by
Tokio Kikuchi.  Barry Warsaw is the lead developer on Mailman 3.  Aurélien
Bompard and Florian Fuchs lead development of Postorius and HyperKitty.
Abhilash Raj is a valued contributor to all bits and maintains the CI
infrastructure.


Project details
===============

The Mailman home page is:

* http://www.list.org

The community driven wiki (including the FAQ_) is at:

* http://wiki.list.org

Other help resources, such as on-line documentation, links to the mailing
lists and archives, etc., are available at:

* http://www.list.org/help.html

Mailman 3 is maintained on GitLab:

* https://gitlab.com/groups/mailman

You can report issues in the Core at:

* https://gitlab.com/mailman/mailman/issues

(GNU Mailman 2.1 is still maintained on Launchpad_.)

There are two mailing lists you can use to contact the Mailman 3 developers.
The general development mailing list:

* https://mail.python.org/mailman/listinfo/mailman-developers

and the Mailman 3 users list:

* https://lists.mailman3.org/mailman3/lists/mailman-users.mailman3.org/

For now, please leave the older mailman-users mailing list for Mailman 2.


.. _`GNU Mailman`: http://www.list.org
.. _`GNU General Public License`: http://www.gnu.org/licenses/gpl.txt
.. _Python: http://www.python.org
.. _FAQ: http://wiki.list.org/display/DOC/Frequently+Asked+Questions
.. _`Python 3.4`: https://www.python.org/downloads/release/python-342/
.. _`ACKNOWLEDGMENTS`: ACKNOWLEDGMENTS.html
.. _`Django`: https://www.djangoproject.com/
.. _`suite of programs`: http://docs.mailman3.org/en/latest/
.. _Launchpad: https://launchpad.net/mailman
