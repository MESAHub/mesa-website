---
layout: post
title:  "Docker, Python and Web"
---

This week has seen three new/updated projects announced on mesa-users.

[Evan Bauer announces][docker-announce] [MESA-Docker][docker]:

    It’s a Docker container with MESA already installed, and it should
    work with any OS that supports Docker, including Windows 10.  This
    should serve as a useful tool for those who are ready to invest
    some extra effort to step beyond the limited options of MESA-Web,
    but not yet comfortable configuring their environment for full
    installation.

[Rob Farmer announces][python-announce] [pyMesa][python]:

    This is a set of low level python bindings for MESA to allow easy
    access to the individual MESA modules.  This is aimed for those
    people who want to quickly get a result from a MESA module and
    don’t want to worry about getting fortran code compiled and
    working.

[Carl Fields announces][web-announce] updates to [MESA-Web][web]:

    1. Users can now choose to upload a custom reaction rate.
    2. More mixing parameters available for calculations.
    3. Jobs now run for 4hrs or until iron core collapse.



[web-announce]:https://lists.mesastar.org/pipermail/mesa-users/2017-September/007864.html
[docker-announce]:https://lists.mesastar.org/pipermail/mesa-users/2017-August/007853.html
[python-announce]:https://lists.mesastar.org/pipermail/mesa-users/2017-August/007856.html

[web]:http://mesa-web.asu.edu/
[docker]:https://github.com/evbauer/MESA-Docker
[python]:https://github.com/rjfarmer/pyMesa
