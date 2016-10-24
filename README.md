ansible-nginx
====================================

[![Build Status](https://travis-ci.org/FGtatsuro/ansible-nginx.svg?branch=master)](https://travis-ci.org/FGtatsuro/ansible-nginx)

Ansible role for Nginx.

Requirements
------------

The dependencies on other softwares/librarys for this role.

- Debian
- Alpine Linux
- OSX
  - Homebrew (>= 0.9.5)

Role Variables
--------------

The variables we can use in this role.

|name|description|type|default|
|---|---|---|---|
|nginx_root_config_src|Root config file of Nginx on local. It is copied to `nginx_root_config_remote` on remote.|str|It isn't defined in default.|
|nginx_root_config_remote|Root config file of Nginx on remote. If root config file already exists, existing one is **OVERWRITTEN**.|str|/etc/nginx/nginx.conf|
|nginx_extra_config_src_dir|Directory including extra config files of Nginx on local.|src|It isn't defined in default.|
|nginx_extra_config_remote_dir|Directory including extra config files of Nginx on remote.|str|/etc/nginx/conf.d|
|nginx_config_owner|User of Nginx configs put by this role, `nginx_root_config_remote` and `nginx_extra_config_src_dir`(including config files under it).|str|root|
|nginx_config_group|Group of Nginx configs put by this role, `nginx_root_config_remote` and `nginx_extra_config_src_dir`(including config files under it).|str|root|

- The value is `nginx_extra_config_src_dir` is used as 'src' attribute of Ansible copy module. Thus, whether this value ends with '/' affects the behavior. (Ref. http://docs.ansible.com/ansible/copy_module.html)
- The value of `nginx_root_config_remote` is ignored when `nginx_root_config_src` isn't defined.
- The value of `nginx_extra_config_src_dir` is ignored when `nginx_extra_config_remote_dir` isn't defined.
- The values of `nginx_config_owner` and `nginx_config_group` are ignored when neither `nginx_root_config_src` nor `nginx_extra_config_src_dir` is defined.

Role Dependencies
-----------------

The dependencies on other roles for this role.

- FGtatsuro.python-requirements

Example Playbook
----------------

    - hosts: all
      roles:
         - { role: FGtatsuro.nginx }

Test on local Docker host
-------------------------

This project run tests on Travis CI, but we can also run them on local Docker host.
Please check `install`, `before_script`, and `script` sections of `.travis.yml`.
We can use same steps of them for local Docker host.

Local requirements are as follows.

- Ansible (>= 2.0.0)
- Docker (>= 1.10.1)

License
-------

MIT
