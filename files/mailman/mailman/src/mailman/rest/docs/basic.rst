===========
REST server
===========

Mailman exposes a REST HTTP server for administrative control.

The server listens for connections on a configurable host name and port.

It is always protected by HTTP basic authentication using a single global
user name and password. The credentials are set in the `[webservice]` section
of the configuration using the `admin_user` and `admin_pass` properties.

Because the REST server has full administrative access, it should always be
run only on localhost, unless you really know what you're doing.  In addition
you should set the user name and password to secure values and distribute them
to any REST clients with reasonable precautions.

The Mailman major and minor version numbers are in the URL.


Credentials
===========

When the `Authorization` header contains the proper credentials, the request
succeeds.

    >>> from httplib2 import Http
    >>> headers = {
    ...     'Content-Type': 'application/x-www-form-urlencode',
    ...     'Authorization': 'Basic cmVzdGFkbWluOnJlc3RwYXNz',
    ...     }
    >>> url = 'http://localhost:9001/3.0/system/versions'
    >>> response, content = Http().request(url, 'GET', None, headers)
    >>> print(response.status)
    200


Version information
===================

System version information can be retrieved from the server, in the form of a
JSON encoded response.

    >>> dump_json('http://localhost:9001/3.0/system/versions')
    api_version: 3.0
    http_etag: "..."
    mailman_version: GNU Mailman 3...
    python_version: ...
    self_link: http://localhost:9001/3.0/system/versions


.. _REST: http://en.wikipedia.org/wiki/REST
