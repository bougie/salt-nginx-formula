=====
Nginx
=====

Install the nginx server and configure virtual hosts

.. note::

   See the full `Salt Formulas installation and usage instructions
      <http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_.

Available states
================

.. contents::
    :local:

``nginx``
---------

Runs the state to install nginx and configure the common files.

``nginx.install``
-----------------

Install nginx server.

``nginx.service``
-----------------

Manage the startup and running state of the nginx server.

``nginx.config``
----------------

Manage the nginx main server configuration file.

``nginx.vhosts``
----------------

Manage nginx virtual hosts files.
